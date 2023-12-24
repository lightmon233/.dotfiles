#!/bin/bash
#the main packages
install_stage=(
    cava
    neofetch
    neovim
    ranger
    rofi
    alsa-utils
    xclip
    wqy-zenhei
    kitty
    paru
    ttf-meslo-nerd
    netease-cloud-music
    go-musicfox
    qqmusic
    wine
    adobe-source-han-serif-cn-fonts
    noto-fonts-cjk
    adobe-source-han-sans-cn-fonts
    powerline-fonts
    ttf-font-awesome
    wqy-bitmapfont
    wqy-microhei
    wqy-microhei-lite
    wqy-zenhei
    adobe-source-code-pro-fonts
    google-chrome
    ttf-ms-fonts
    baidunetdisk-bin
    gparted
    ksnip
    shotgun
    zsh
    noto-fonts-emoji
    mako 
    waybar
    swww 
    swaylock
    wofi 
    wlogout 
    xdg-desktop-portal-hyprland 
    swappy 
    grim 
    slurp 
    thunar 
    btop
    firefox
    thunderbird
    mpv
    pamixer 
    pavucontrol 
    brightnessctl 
    bluez 
    bluez-utils 
    blueman 
    network-manager-applet 
    gvfs 
    thunar-archive-plugin 
    file-roller
    starship 
    papirus-icon-theme 
    ttf-jetbrains-mono-nerd 
    noto-fonts-emoji 
    lxappearance 
    xfce4-settings
    nwg-look-bin
    sddm
    wayland-screenshot
    grimshot
    swaybg
    pyprland
    obs-studio
    cliphist
    wl-clipboard
    polkit-gnome # 图形化密码管理
    udiskie
    ueberzug # ranger需要它来预览图片
    shellcheck # neovim 需要它来检查shell脚本
)

# set some colors
CNT="[\e[1;36mNOTE\e[0m]"
COK="[\e[1;32mOK\e[0m]"
CER="[\e[1;31mERROR\e[0m]"
CAT="[\e[1;37mATTENTION\e[0m]"
CWR="[\e[1;35mWARNING\e[0m]"
CAC="[\e[1;33mACTION\e[0m]"
INSTLOG="install.log"

# function that would show a progress bar to the user
show_progress() {
    while ps | grep $1 &> /dev/null;
    do
        echo -n "."
        sleep 2
    done
    echo -en "Done!\n"
    sleep 2
}

# function that will test for a package and if not found it will attempt to install it
install_software() {
    # First lets see if the package is there
    if yay -Q $1 &>> /dev/null ; then
        echo -e "$COK - $1 is already installed."
    else
        # no package found so installing
        echo -en "$CNT - Now installing $1 ."
        yay -S --noconfirm $1 &>> $INSTLOG &
        show_progress $!
        # test to make sure package installed
        if yay -Q $1 &>> /dev/null ; then
            echo -e "\e[1A\e[K$COK - $1 was installed."
        else
            # if this is hit then a package is missing, exit to review log
            echo -e "\e[1A\e[K$CER - $1 install had failed, please check the install.log"
            exit
        fi
    fi
}

# clear the screen
clear

# let the user know that we will use sudo
echo -e "$CNT - This script will run some commands that require sudo. You will be prompted to enter your password.
If you are worried about entering your password then you may want to review the content of the script."
sleep 1

# give the user an option to exit out
read -rep $'[\e[1;33mACTION\e[0m] - Would you like to continue with the install (y,n) ' CONTINST
if [[ $CONTINST == "Y" || $CONTINST == "y" ]]; then
    echo -e "$CNT - Setup starting..."
    sudo touch /tmp/hyprv.tmp
else
    echo -e "$CNT - This script will now exit, no changes were made to your system."
    exit
fi

### Install all of the above pacakges ####
read -rep $'[\e[1;33mACTION\e[0m] - Would you like to install the packages? (y,n) ' INST
if [[ $INST == "Y" || $INST == "y" ]]; then

    # Stage 1 - main components
    echo -e "$CNT - Installing main components, this may take a while..."
    for SOFTWR in ${install_stage[@]}; do
        install_software $SOFTWR 
    done

    # Start the bluetooth service
    echo -e "$CNT - Starting the Bluetooth Service..."
    sudo systemctl enable --now bluetooth.service &>> $INSTLOG
    sleep 2

    # Enable the sddm login manager service
    echo -e "$CNT - Enabling the SDDM Service..."
    sudo systemctl enable sddm &>> $INSTLOG
    sleep 2
    
fi

### Copy Config Files ###
read -rep $'[\e[1;33mACTION\e[0m] - Would you like to copy config files? (y,n) ' CFG
if [[ $CFG == "Y" || $CFG == "y" ]]; then
    echo -e "$CNT - Copying config files..."
    
    # installing sddm theme(sddm-sugar-candy)
    git clone https://framagit.org/MarianArlt/sddm-sugar-candy.git ~/sddm-sugar-candy
    cp -r ~/sddm-sugar-candy /usr/share/sddm/themes/
    touch /etc/sddm.conf
    echo "[Theme]" >> /etc/sddm.conf
    echo "Current=sddm-sugar-candy" >> /etc/sddm.conf

    echo -e "$CNT - Copying successful!"
fi

