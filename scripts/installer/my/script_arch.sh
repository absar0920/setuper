#!/bin/bash
set -e

if [ -f .env ]; then
    source .env
else
    echo ".env file not found!"
    exit 1
fi

# Arch Linux
# Install zsh and oh-my-zsh
sudo pacman -S --noconfirm zsh
export RUNZSH=no
export ZDOTDIR=/home/$MACHINE_USER
sudo wget -O /tmp/ohmyzsh-install-script.sh https://raw.github.com/ohmyzsh/ohmyzsh/master/tools/install.sh
sudo sed -i '/^  echo "${FMT_BLUE}Time to change your default shell to zsh:/,/^  esac/d' /tmp/ohmyzsh-install-script.sh
sudo -u $MACHINE_USER HOME=/home/$MACHINE_USER USER=$MACHINE_USER sh /tmp/ohmyzsh-install-script.sh --unattended
sudo rm /tmp/ohmyzsh-install-script.sh
sudo chsh -s /bin/zsh $MACHINE_USER

# Install i3wm
sudo pacman -S --noconfirm i3-wm picom rofi
sudo pacman -S --noconfirm lightdm lightdm-gtk-greeter
sudo systemctl enable lightdm

# Install Alacritty
sudo pacman -S --noconfirm alacritty

# Setup config files, from $MACHINE_USER to avoid ownership issues
sudo -u $MACHINE_USER mkdir -p /home/$MACHINE_USER/.config
sudo -u $MACHINE_USER cp -r ./configs/* /home/$MACHINE_USER/.config

echo "xset r rate 250 50" >> /home/$MACHINE_USER/.zshrc
sed -i 's/ZSH_THEME="robbyrussell"/ZSH_THEME="agnoster"/' /home/$MACHINE_USER/.zshrc

# Setup AWS CLI
sudo pacman -S --noconfirm aws-cli
if [ -f .env ]; then
    aws --profile default configure set aws_access_key_id $AWS_ACCESS_KEY_ID
    aws --profile default configure set aws_secret_access_key $AWS_SECRET_ACCESS_KEY
    aws --profile default configure set region $AWS_REGION
    mv ~/.aws/ /home/$MACHINE_USER/
    sudo chown -R $MACHINE_USER:$MACHINE_USER /home/$MACHINE_USER/.aws
    sudo chmod 600 /home/$MACHINE_USER/.aws/credentials /home/$MACHINE_USER/.aws/config
else
    echo "Not setting up the AWS CLI. .env file not found!"
    exit 1
fi

# Setup tmux-sessionizer
sudo -u $MACHINE_USER mkdir -p /home/$MACHINE_USER/.local/bin
sudo -u $MACHINE_USER cp ./tools/tmux-sessionizer /home/$MACHINE_USER/.local/bin
sudo -u $MACHINE_USER chmod +x /home/$MACHINE_USER/.local/bin/tmux-sessionizer
echo "export PATH=$PATH:/home/$MACHINE_USER/.local/bin" >> /home/$MACHINE_USER/.zshrc

# Setup Git for MACHINE_USER
sudo -u $MACHINE_USER git config --global user.email $GIT_EMAIL
sudo -u $MACHINE_USER git config --global user.name $GIT_NAME
sudo -u $MACHINE_USER ssh-keygen -t rsa -b 4096 -C $GIT_EMAIL -f /home/$MACHINE_USER/.ssh/id_rsa -N ""
eval "$(ssh-agent -s)"
ssh-add /home/$MACHINE_USER/.ssh/id_rsa
pub=$(cat /home/$MACHINE_USER/.ssh/id_rsa.pub)
curl -L \
  -X POST \
  -H "Accept: application/vnd.github+json" \
  -H "Authorization: Bearer $GITHUB_API_TOKEN" \
  -H "X-GitHub-Api-Version: 2022-11-28" \
  https://api.github.com/user/keys \
  -d "{\"title\":\"H: $(hostnamectl --static) U: $MACHINE_USER\",\"key\":\"$pub\"}"
# Setting up permissions
sudo chown -R $MACHINE_USER:$MACHINE_USER /home/$MACHINE_USER/.ssh/id_rsa /home/$MACHINE_USER/.ssh/id_rsa.pub
sudo chmod 600 /home/$MACHINE_USER/.ssh/id_rsa
sudo chmod 644 /home/$MACHINE_USER/.ssh/id_rsa.pub