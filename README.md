# cover
Automated high quality, high resolution, marketing art designer written in minimalist Bash using ImageMagick and Love!

## Demo

```hand1``` preset
![hand1](/docs/hand1.png)

```laptop1``` preset
![laptop1](/docs/laptop1.png)

Actual size close-up (resulting images are print quality)
![quality](/docs/quality.png)

## Requirements

- [ImageMagick](https://imagemagick.org)

## Quick Installation

    mkdir ~/GitHub; cd ~/GitHub;
    git clone git@github.com:fantasyui-com/cover.git cover;

## Usage

Fork this repository anywhere you like, open up your terminal execute ```cover/use``` ```PRESET-NAME``` ```YOUR-INPUT-IMAGE``` ```OUTPUT-IMAGE``` example:

```shell

~/GitHub/cover/use laptop1 ~/Desktop/source-screenshot.png ~/merged-result.png

```

## Bonus

Here is a quick script that will create images based on Screen*.png on your ~/Desktop (This may take a while). The program below is meant to help you get started on processing large collections.

```shell

#!/bin/bash
INDEX=1;
find ~/Desktop -maxdepth 1 -type f -iname "Screen*.png" | while read NAME
do
  ~/GitHub/cover/use hand1 "${NAME}" ./test-hand1-${INDEX}.png;
  ~/GitHub/cover/use laptop1 "${NAME}" ./test-laptop1-${INDEX}.png;
  INDEX=$((INDEX+1));
done;

```

## Credits

- Alejandro Escamilla
  - [laptop1](https://unsplash.com/@alejandroescamilla?photo=xII7efH1G6o)
- William Iven
  - [hand1](https://unsplash.com/@firmbee?photo=dAmHWsRYP9c)
