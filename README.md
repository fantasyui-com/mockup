# mockup
Perspective app screens and isometric mock-up tool. Automated high quality, high resolution, marketing art designer for mockups. Written in minimalist Bash using ImageMagick and Love!

## Mockup Demo

Overview
![all](/docs/all.jpg)

```hand1``` preset
![hand1](/docs/hand1.jpg)

```laptop1``` preset
![laptop1](/docs/laptop1.jpg)

```gray1``` preset
![gray1](/docs/gray1.jpg)

Actual size close-up (resulting images are print quality)
![quality](/docs/quality.jpg)

## Requirements

- [ImageMagick](https://imagemagick.org)

## Quick Installation

    mkdir ~/GitHub; cd ~/GitHub;
    git clone git@github.com:fantasyui-com/mockup.git mockup;

## Usage

Fork this repository anywhere you like, open up your terminal execute: ```mockup/use``` ```PRESET-NAME```  ```OUTPUT-IMAGE``` ```YOUR-INPUT-IMAGE(S)``` (Note that output comes before input, we can be sure there is a single output but some presets will accept multiple images.)

```shell

~/GitHub/mockup/use laptop1 ~/merged-result.png ~/Desktop/source-screenshot.png ~/Desktop/another-source-screenshot.png

```

## Bonus

Here is a quick script that will create images based on Screen*.png on your ~/Desktop (This may take a while). The program below is meant to help you get started on processing large collections.

```shell

#!/bin/bash
INDEX=1;
find ~/Desktop -maxdepth 1 -type f -iname "Screen*.png" | while read NAME
do

  ~/GitHub/mockup/use hand1 ./test-hand1-${INDEX}.png "${NAME}";
  ~/GitHub/mockup/use laptop1 ./test-laptop1-${INDEX}.png "${NAME}";
  ~/GitHub/mockup/use tv1 ./test-laptop1-${INDEX}.png "${NAME}";
  ~/GitHub/mockup/use tablet1 ./test-laptop1-${INDEX}.png "${NAME}";

  INDEX=$((INDEX+1));
done;

```

## Credits

- [Alejandro Escamilla](https://unsplash.com/@alejandroescamilla)
  - [laptop1](https://unsplash.com/@alejandroescamilla?photo=xII7efH1G6o)
- [William Iven](https://unsplash.com/@firmbee)
  - [hand1](https://unsplash.com/@firmbee?photo=dAmHWsRYP9c)
  - [tablet1](https://unsplash.com/@firmbee?photo=GANqCr1BRTU)
- [Jens Kreuter](https://unsplash.com/@jenskreuter)
  - [tv](https://unsplash.com/@jenskreuter?photo=ngMtsE5r9eI)
