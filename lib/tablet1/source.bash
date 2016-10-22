# source image https://unsplash.com/@firmbee?photo=GANqCr1BRTU

IW=4133
IH=2745

AX=423
AY=1747

BX=1377
BY=2546

CX=1405
CY=1401

DX=2392
DY=2106

# create a blank canvas
convert -size ${IW}x${IH}^ canvas:transparent "${DIR}/lib/${SUB}/layer-01.png";

# get the width and then height of the hole (based on the four hole coordinates)
HW=$(echo "scale=2;sqrt(((${CX}-${AX})^2)+((${CY}-${AY})^2))"|bc)
HH=$(echo "scale=2;sqrt(((${BX}-${AX})^2)+((${BY}-${AY})^2))"|bc)

# resize SRC image to match the artwork hole.
convert "$SRC" -resize ${HW}x${HH}^ -gravity center -crop ${HW}x${HH}+0+0 -sharpen 0x2 -quality 100 "${DIR}/lib/${SUB}/resized.png";

# insert resized SRC image into blank canvas;
composite -geometry +0+0 "${DIR}/lib/${SUB}/resized.png" "${DIR}/lib/${SUB}/layer-01.png" "${DIR}/lib/${SUB}/layer-01.png";
rm "${DIR}/lib/${SUB}/resized.png";

# four point distort of the SRC image recently placed on blank canvas, to fit into the upcoming artwork hole
convert "${DIR}/lib/${SUB}/layer-01.png" -matte -virtual-pixel transparent -distort Perspective "0,0,${AX},${AY} 0,${HH},${BX},${BY} ${HW},0,${CX},${CY} ${HW},${HH},${DX},${DY}" "${DIR}/lib/${SUB}/layer-01.png";

# place artwork layer over the resized/distorted SRC image and save result
composite -geometry +0+0 "${DIR}/lib/${SUB}/overlay.png" "${DIR}/lib/${SUB}/layer-01.png" "${OUT}";
rm "${DIR}/lib/${SUB}/layer-01.png";
