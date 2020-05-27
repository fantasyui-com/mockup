# source image http://unsplash.com/photos/xII7efH1G6o/download

IW=5616
IH=3744

AX=1724
AY=541

BX=1814
BY=1736

CX=3855
CY=539

DX=3783
DY=1742

# create a blank canvas
convert -size ${IW}x${IH}^ canvas:transparent "${TEMPORARY}/layer-01.png";

# get the width and then height of the hole (based on the four hole coordinates)
HW=$(echo "scale=2;sqrt(((${CX}-${AX})^2)+((${CY}-${AY})^2))"|bc)
HH=$(echo "scale=2;sqrt(((${BX}-${AX})^2)+((${BY}-${AY})^2))"|bc)

# resize SRC image to match the artwork hole.
convert "${INPUT[0]}" -resize ${HW}x${HH}^ -gravity center -crop ${HW}x${HH}+0+0 -sharpen 0x2 -quality 100 "${TEMPORARY}/resized.png";

# insert resized SRC image into blank canvas;
composite -geometry +0+0 "${TEMPORARY}/resized.png" "${TEMPORARY}/layer-01.png" "${TEMPORARY}/layer-01.png";
rm "${TEMPORARY}/resized.png";

# four point distort of the SRC image recently placed on blank canvas, to fit into the upcoming artwork hole
convert "${TEMPORARY}/layer-01.png" -matte -virtual-pixel transparent -distort Perspective "0,0,${AX},${AY} 0,${HH},${BX},${BY} ${HW},0,${CX},${CY} ${HW},${HH},${DX},${DY}" "${TEMPORARY}/layer-01.png";

# place artwork layer over the resized/distorted SRC image and save result
composite -geometry +0+0 "lib/${TEMPLATE}/overlay.png" "${TEMPORARY}/layer-01.png" "${OUTPUT}";
rm "${TEMPORARY}/layer-01.png"
