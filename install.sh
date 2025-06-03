#!/bin/bash 

echo "Setting up yay..."
cd ~
sudo pacman -S --needed git base-devel go
git clone https://aur.archlinux.org/yay.git
cd yay
makepkg -si
cd ..

echo "Installing require application..."

sudo pacman -S xorg xorg-xinit xorg-server xorg-xrandr vim network-manager-applet net-tools i3 sddm emacs alacritty nitrogen stow picom make cmake nerd-fonts ttf-jetbrains-mono-nerd qt5-declarative qt5-quickcontrols2 qt5-graphicaleffects
sudo systemctl enable sddm
echo "Done!!"

read -p "Do you want to clone the dotfiles repo? (yes/no): " answer

if [[ "$answer" == "yes" || "$answer" == "y" ]]; then
    echo "cloning dotfiles repo"
    git clone https://github.com/NOTHING-R/dotfiles.git ~/dotfiles
else
    echo "You can found it in https://github.com/NOTHING-R"
fi

read -p "Do you want to set up EXWM in .xinitrc? (yes/no): " answer
if [[ "$answer" == "yes" || "$answer" == "y" ]]; then
    echo "Setting up EXWM in .xinitrc and Xresources..."
    echo "Xft.dpi: 125" > ~/.Xresources

    cat > ~/.xinitrc <<EOF
#!/bin/sh
# Set environment variables or configurations

# Start EXWM via Emacs
exec emacs
EOF

    chmod +x ~/.xinitrc
    echo ".xinitrc configured!"

    echo "Creating EXWM desktop session entry..."
    sudo bash -c 'cat > /usr/share/xsessions/exwm.desktop <<EOF
[Desktop Entry]
Name=EXWM
Exec=emacs
Type=Application
DesktopName=EXWM
EOF'

    echo "EXWM setup complete!" 
else
    echo "Skipping EXWM setup. You can do it manually later."
fi
