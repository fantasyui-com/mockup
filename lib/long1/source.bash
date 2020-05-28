if [ -z "${INPUT[1]}" ]; then
  INFO This template works with one or two images.
  INPUT[1]="${INPUT[0]}";
fi

# image size 3840 × 2160
IMAGE_WIDTH=3840;
IMAGE_HEIGHT=2160;

PRIMARY_WIDTH=$(echo "scale=2; 0.75*${IMAGE_WIDTH}"|bc)
PRIMARY_HEIGHT=$IMAGE_HEIGHT;

SECONDARY_WIDTH=$(echo "scale=2; 0.33*${IMAGE_WIDTH}"|bc)
SECONDARY_HEIGHT=$IMAGE_HEIGHT;

NOTE Guess primary/secondary dominant colors.
PRIMARY_COLOR=$(convert "${INPUT[0]}" +dither -colors 5 -define histogram:unique-colors=true -format "%c" histogram:info: |  sort -bnr | awk '{print $3}' | cut -c1-7 | head -n 1);
SECONDARY_COLOR=$(convert "${INPUT[0]}" +dither -colors 5 -define histogram:unique-colors=true -format "%c" histogram:info: |  sort -bn | awk '{print $3}' | cut -c1-7 | head -n 1);

# NOTE Dominant color is: [$DOMINANT_COLOR], final value ${BACKGROUND:-$DOMINANT_COLOR}
# NOTE Create a blank canvas.
# convert -size ${IMAGE_WIDTH}x${IMAGE_HEIGHT}^ gradient:${BACKGROUND:-'#333333'}-black "${TEMPORARY}/layer-00.png";
# convert -size ${IMAGE_WIDTH}x${IMAGE_HEIGHT}^ gradient:${BACKGROUND:-$DOMINANT_COLOR}-black "${TEMPORARY}/layer-00.png";

NOTE Resize primary image in preparation for placement.
convert "${INPUT[0]}" -resize ${PRIMARY_WIDTH}x${PRIMARY_HEIGHT}^  -crop ${PRIMARY_WIDTH}x${PRIMARY_HEIGHT}+0+0 -sharpen 0x2 -quality 100 "${TEMPORARY}/resized1.png";

NOTE Add rounded corners to primary image
convert "${TEMPORARY}/resized1.png" \( +clone -threshold -1 -draw "fill black polygon 0,0 0,128 128,0 fill white circle 128,128 128,0" \( +clone -flop \) -compose Multiply -composite \) +matte -compose CopyOpacity -composite "${TEMPORARY}/resized1.png"

NOTE Add drop shadow to primary image
convert "${TEMPORARY}/resized1.png" \( +clone -background black -shadow 75x50+100+100 \) +swap -background none  -layers merge +repage "${TEMPORARY}/resized1.png"

NOTE Resize secondary image in preparation for placement.
convert "${INPUT[1]}" -resize ${SECONDARY_WIDTH}x${SECONDARY_HEIGHT}^ -crop ${SECONDARY_WIDTH}x${SECONDARY_HEIGHT}+0+0 -sharpen 0x2 -quality 100 "${TEMPORARY}/resized2.png";

NOTE Combine prinmary and secondary images on a canvas.
convert -size ${IMAGE_WIDTH}x${IMAGE_HEIGHT}^ gradient:${BACKGROUND:-$PRIMARY_COLOR}-${SECONDARY_COLOR} -page +${PRIMARY_WIDTH}+0 "${TEMPORARY}/resized2.png" -page +100+100 "${TEMPORARY}/resized1.png" -layers flatten  "${OUTPUT}";

rm ${TEMPORARY}/*.png;
