#!/bin/bash
set -e

if [ -f .env ]; then
    source .env
else
    echo ".env file not found!"
    exit 1
fi

# ubuntu
# install zsh and oh-my-zsh
sudo apt install zsh -y
wget -O /tmp/ohmyzsh-install-script.sh https://raw.github.com/ohmyzsh/ohmyzsh/master/tools/install.sh
sed -i '/^  echo "${FMT_BLUE}Time to change your default shell to zsh:${FMT_RESET}"/,/^  esac/d' /tmp/ohmyzsh-install-script.sh
sh /tmp/ohmyzsh-install-script.sh
rm /tmp/ohmyzsh-install-script.sh

# install i3wm
sudo apt install i3 -y
sudo systemctl stop gdm
sudo apt install lightdm -y
sudo systemctl enable lightdm
sudo apt install picom rofi -y

# install alacritty
sudo apt install alacritty -y

# setup config files
cp -r .config/* /home/$MACHINE_USER/.config/

echo "xset r rate 300 50" >> /home/$MACHINE_USER/.zshrc
echo "ZSH_THEME=\"agnoster\"" >> /home/$MACHINE_USER/.zshrc

# setup aws
sudo snap install aws-cli --classic
if [ -f .env ]; then
    aws configure --profile default configure set aws_access_key_id $AWS_ACCESS_KEY_ID
    aws configure --profile default configure set aws_secret_access_key $AWS_SECRET_ACCESS_KEY
else
    echo "Not Setupping Up the aws cli.env file not found!"
    exit 1
fi

# setup git
git config --global user.email $GIT_EMAIL
git config --global user.name $GIT_NAME
ssh-keygen -t rsa -b 4096 -C $GIT_EMAIL -f /home/$MACHINE_USER/.ssh/id_rsa -N ""
eval "$(ssh-agent -s)"
ssh-add /home/$MACHINE_USER/.ssh/id_rsa
pub=`cat /home/$MACHINE_USER/.ssh/id_rsa.pub`
curl -L \
  -X POST \
  -H "Accept: application/vnd.github+json" \
  -H "Authorization: Bearer $GITHUB_API_TOKEN" \
  -H "X-GitHub-Api-Version: 2022-11-28" \
  https://api.github.com/user/keys \
  -d "{\"title\":\"H: $(hostname) U: $MACHINE_USER\",\"key\":\"$pub\"}"
# setting up permissions
sudo chown -R $MACHINE_USER:$MACHINE_USER /home/$MACHINE_USER/.ssh/id_rsa /home/$MACHINE_USER/.ssh/id_rsa.pub
sudo chmod 600 /home/$MACHINE_USER/.ssh/id_rsa
sudo chmod 644 /home/$MACHINE_USER/.ssh/id_rsa.pub
