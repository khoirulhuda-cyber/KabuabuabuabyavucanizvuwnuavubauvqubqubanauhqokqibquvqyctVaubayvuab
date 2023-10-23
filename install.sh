#!/bin/bash

if (( $EUID != 0 )); then
    echo "Please run as root"
    exit
fi

clear

installTheme(){
    cd
    sudo apt install unzip
    sudo apt-get install zip
    cd /usr/share/
    npm install --global yarn
    echo "Installing theme..."
    cd /var/www/
    git clone https://github.com/khoirulhuda-cyber/Halahtaitemapenlnibod
    cd /var/www/
    unzip -o tema.zip
    cd /var/www/pterodactyl

    curl -sL https://deb.nodesource.com/setup_16.x | sudo -E bash -
    apt update
    apt install -y nodejs


    yarn
    yarn add react-feather
    
    php artisan migrate
    > yes
    yarn build:production
    php artisan view:clear


}

installThemeQuestion(){
    while true; do
        read -p "Are you sure that you want to install the theme [y/n]? " yn
        case $yn in
            [Yy]* ) installTheme; break;;
            [Nn]* ) exit;;
            * ) echo "Please answer yes or no.";;
        esac
    done
}

repair(){
    bash <(curl https://raw.githubusercontent.com/Angelillo15/MinecraftPurpleTheme/main/repair.sh)
}

restoreBackUp(){
    echo "Restoring backup..."
    cd /var/www/
    tar -xvf MinecraftPurpleThemebackup.tar.gz
    rm MinecraftPurpleThemebackup.tar.gz

    cd /var/www/pterodactyl
    yarn build:production
    sudo php artisan optimize:clear
}
echo "PEMBUAT:IKHRUL HOST"
echo "This program is free software: you can redistribute it and/or modify"
echo ""
echo "NAMA: IKHRUL HOST"
echo "NOMOR: 081542692178"
echo ""
echo "[1] Install theme"
echo "[2] Restore backup"
echo "[3] Repair panel (use if you have an error in the theme installation)"
echo "[4] Exit"

read -p "Please enter a number: " choice
if [ $choice == "1" ]
    then
    installThemeQuestion
fi
if [ $choice == "2" ]
    then
    restoreBackUp
fi
if [ $choice == "3" ]
    then
    repair
fi
if [ $choice == "4" ]
    then
    exit
fi