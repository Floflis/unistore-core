#!/bin/sh

echo "Installing UniStore..."
sudo cp -f unistore /usr/bin && sudo chmod +x /usr/bin/unistore
echo "Done."

# todo: install uni shorter command

if [ ! -e /usr/lib/node_modules ]
   then
      echo "\e[101m UniStore uses Dat, which depends upon Node to work. Build and install NodeJS? [Y/n] \e[0m"
      read insnod
      case $insnod in
         [nN])
            echo "Cannot install UniStore without its dependencies."
            exit;;
         [yY])
            echo "Sorry, but actually we can't install NodeJS for you. Please search how to install NodeJS. After installed, reply on this same script to install Dat, and done"
            echo "\e[43m ;D \e[0m"
          # echo "Installing build dependencies..."
          # sudo apt-get install python g++ make # todo: detect different platforms, based on NodeJS build docs / also, do pre-compiled builds
          # echo "Extracting NodeJS..."
          # extract node.tar.gz / if not included, download from OS software repo
          # echo "Building NodeJS..."
          # cd include/node && chmod +x configure && ./configure | make -j4
            break ;;
         *)
            echo "Invalid answer." && exit
      esac
fi

if [ ! -e /usr/lib/node_modules/dat ]
   then
      echo "\e[101m UniStore depends upon Dat (which depends on NodeJS) to work. Install Dat protocol? [Y/n] \e[0m"
      read insdat
      case $insdat in
         [nN])
            echo "Cannot install UniStore without its dependencies."
            exit;;
         [yY])
            if [ -e /1/Floflis/libs/node_modules ]
               then
                  nodemodules="/1/Floflis/libs/node_modules"
               else
                  nodemodules="/usr/lib/node_modules"
fi
            echo "Moving Dat..."
            cd include && sudo cp -f dat.tar.gz $nodemodules
            echo "Extracting Dat..."
            cd $nodemodules
            sudo tar -zxvf dat.tar.gz
            echo "Installing Dat..."
            cd $nodemodules/dat && sudo npm link && sudo npm install -g && sudo npm update -g
            cd $nodemodules
            sudo rm dat.tar.gz
            echo "Done! Run 'unistore' command to use it." && exit
            break ;;
         *)
            echo "Invalid answer." && exit
      esac
fi
