#!/bin/bash

#Install Brew and the necessary Packages

function install-brew {

  /usr/bin/ruby -e "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install)"

  brew install bash wget curl screen u-boot-tools libusb zlib pkg-config git 
  
  brew install homebrew/cask/android-platform-tools
}

#Install the C.H.I.P Tools ported for MacOS
function install-chip-tools {

  git clone https://github.com/younghoonk17/Chip-tools-Mac.git

  cd Chip-tools-Mac

  chmod +x *.sh
}

#Install the Sunxi-Tools into your Path

function install-sunxi-tools {
  git clone https://github.com/linux-sunxi/sunxi-tools.git

  cd sunxi-tools

  pkg-config --libs libusb-1.0

  pkg-config --libs zlib

  sudo make install-all
}

# Reinstall the Brew Packages

function brew-packages {
  brew reinstall bash wget curl screen u-boot-tools libusb zlib pkg-config
}


#Reinstall brew

function brew-reinstall {

  echo "PLEASE NOTE THIS WILL REMOVE ANY BREW PACKAGES TOO EVEN THE ONES U DIDNT INSTALLED WITH THIS SCRIPT "
  echo " PRESS N TO ABORT OR y TO PROCEED "
  sudo ruby -e "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/uninstall)"

  sudo /usr/bin/ruby -e "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install)" -y

}

#Print out the help

function help {

echo
echo "   #  #  #"
echo "  #########"
echo "###       ###"
echo "  # {#}   #"
echo "###  '\######"
echo "  #       #"
echo "###       ###"
echo "  ########"
echo "   #  #  #"
echo
echo
echo " HELP "
echo
echo "---------------------------------------------------------------"
echo " This Script install all necessary tools to Flash a C.H.I.P Computer from a Mac Computer "
echo
echo " To Install everything you need run "
echo
echo " ./Flasher.sh install-all "
echo "---------------------------------------------------------------"
echo
echo " To Flash your C.H.I.P run "
echo
echo " sudo ./Flasher.sh flash "
echo
echo "---------------------------------------------------------------"
echo
echo " To reinstall the Brew Packages run "
echo
echo " ./Flasher.sh reinstall brew-packages"
echo
echo "---------------------------------------------------------------"
echo
echo " To reinstall the Brew Packagemanger"
echo
echo " ./Flasher.sh brew-reinstall "
echo
echo "---------------------------------------------------------------"

}


#Install the Flasher Envroiment

function install-all {
  echo "Installing brew and all necessary packages available via brew "
  install-brew
  echo " Installing C.H.I.P Tools for MacOS "
  install-chip-tools
  cd Chip-tools-Mac
  echo "Installing the sunxi tools and install it in your Path "
  install-sunxi-tools

}

function flash {

echo
echo "   #  #  #"
echo "  #########"
echo "###       ###"
echo "  # {#}   #"
echo "###  '\######"
echo "  #       #"
echo "###       ###"
echo "  ########"
echo "   #  #  #"


echo " Welcome to the C.H.I.P Flasher Tool "

echo " Please enter your wanted flavour "
echo " ++++++++++++++++++++++++++++++++++++++++++ "
echo " enter p for pocketchip Image "
echo " enter s for the headless Server Image "
echo " enter g for the Desktop Image "
echo " enter b for the Buildroot Image "
echo " ++++++++++++++++++++++++++++++++++++++++++ "
echo " IMPORTANT INFO "
echo " If u suffer from Power Problems add a n "
echo " to your choice of flavour "
echo " Example: gn for the No-Limit Desktop Image "
echo " ++++++++++++++++++++++++++++++++++++++++++ "
echo " Other options "
echo " ++++++++++++++++++++++++++++++++++++++++++ "
echo " enter f for Force Clean "
echo " ++++++++++++++++++++++++++++++++++++++++++ "
echo " Then press enter please "

read flavour

if [ -d Chip-tools-Mac ]; then
 cd Chip-tools-Mac
 git pull
 chmod +x *.sh
 FEL='sudo sunxi-fel' FASTBOOT='sudo fastboot' SNIB=false ./chip-update-firmware.sh -$flavour
 elif [ ! -d Chip-tools-Mac ]; then
 git clone https://github.com/Thore-Krug/Chip-tools-Mac.git
 cd  Chip-tools-Mac
 chmod +x *.sh
 FEL='sudo sunxi-fel' FASTBOOT='sudo fastboot' SNIB=false ./chip-update-firmware.sh -$flavour
fi


}

"$@"
