#!/bin/bash

sudo /usr/bin/ruby -e "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install)" -y

brew install bash wget curl screen u-boot-tools
wget https://raw.githubusercontent.com/Homebrew/homebrew-cask/cf82f0a10d08afd146e176c275a03964ae9e5866/Casks/android-platform-tools.rb

brew cask install android-platform-tools.rb

cd /usr/local/bin

wget https://github.com/Thore-Krug/Sunxi-tools-Mac/archive/V.1.0.zip

unzip V.1.0.zip

rm V.1.0.zip

cd

git clone https://github.com/Thore-Krug/Chip-tools-Mac.git

cd Chip-tools-Mac

find ./ -name "*.sh" -exec chmod +x {} \;

cd

wget https://github.com/Thore-Krug/Chip-tools-Mac/releases/download/V1/Flash-CHIP-Mac

echo " U can now Close this Window "
