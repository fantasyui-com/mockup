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

DOMINANT_COLOR=1;

NOTE Create a blank canvas.
convert -size ${IMAGE_WIDTH}x${IMAGE_HEIGHT}^ gradient:${BACKGROUND:-'#333333'}-black "${TEMPORARY}/layer-00.png";

NOTE Resize primary image in preparation for placement.
convert "${INPUT[0]}" -resize ${PRIMARY_WIDTH}x${PRIMARY_HEIGHT}^  -crop ${PRIMARY_WIDTH}x${PRIMARY_HEIGHT}+0+0 -sharpen 0x2 -quality 100 "${TEMPORARY}/resized1.png";

NOTE Add rounded corners to primary image
convert "${TEMPORARY}/resized1.png" \( +clone -threshold -1 -draw "fill black polygon 0,0 0,150 150,0 fill white circle 150,150 150,0" \( +clone -flop \) -compose Multiply -composite \) +matte -compose CopyOpacity -composite "${TEMPORARY}/resized1.png"

NOTE Add drop shadow to primary image
convert "${TEMPORARY}/resized1.png" \( +clone -background black -shadow 75x50+100+100 \) +swap -background none  -layers merge +repage "${TEMPORARY}/resized1.png"

NOTE Resize secondary image in preparation for placement.
convert "${INPUT[1]}" -resize ${SECONDARY_WIDTH}x${SECONDARY_HEIGHT}^ -crop ${SECONDARY_WIDTH}x${SECONDARY_HEIGHT}+0+0 -sharpen 0x2 -quality 100 "${TEMPORARY}/resized2.png";

NOTE Combine prinmary and secondary images on a canvas.
convert -size ${IMAGE_WIDTH}x${IMAGE_HEIGHT}^ gradient:${BACKGROUND:-'#333333'}-black -page +${PRIMARY_WIDTH}+0 "${TEMPORARY}/resized2.png" -page +100+100  "${TEMPORARY}/resized1.png" -layers flatten  "${OUTPUT}";

rm ${TEMPORARY}/*.png;
