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
export RUNZSH=no
export ZDOTDIR=/home/$MACHINE_USER
sudo wget -O /tmp/ohmyzsh-install-script.sh https://raw.github.com/ohmyzsh/ohmyzsh/master/tools/install.sh
sudo sed -i '/^  echo "${FMT_BLUE}Time to change your default shell to zsh:/,/^  esac/d' /tmp/ohmyzsh-install-script.sh
# sudo sed -i 's/^\(\s*\)chsh -s.*/\1echo "Skipping changing shell to zsh"/' /tmp/ohmyzsh-install-script.sh
sudo -u $MACHINE_USER HOME=/home/$MACHINE_USER USER=$MACHINE_USER sh /tmp/ohmyzsh-install-script.sh --unattended
sudo rm /tmp/ohmyzsh-install-script.sh
sudo chsh -s /bin/zsh $MACHINE_USER

# install i3wm
sudo apt install i3 -y
echo "lightdm shared/default-x-display-manager select lightdm" | sudo debconf-set-selections
# sudo systemctl disable gdm
# sudo DEBIAN_FRONTEND=noninteractive apt install lightdm -y
# sudo systemctl enable lightdm
sudo apt install picom rofi -y

# install alacritty
sudo apt install alacritty -y

# setup config files, from $MACHINE_USER to avoid the ownership issues
sudo -u $MACHINE_USER mkdir -p /home/$MACHINE_USER/.config
sudo -u $MACHINE_USER cp -r ./config/* /home/$MACHINE_USER/.config

echo "xset r rate 250 50" >> /home/$MACHINE_USER/.zshrc
sed -i 's/ZSH_THEME="robbyrussell"/ZSH_THEME="agnoster"/' /home/$MACHINE_USER/.zshrc

# setup aws
sudo snap install aws-cli --classic
if [ -f .env ]; then
    aws --profile default configure set aws_access_key_id $AWS_ACCESS_KEY_ID
    aws --profile default configure set aws_secret_access_key $AWS_SECRET_ACCESS_KEY
    aws --profile default configure set region $AWS_REGION
    mv ~/.aws/ /home/$MACHINE_USER/
    sudo chown -R $MACHINE_USER:$MACHINE_USER /home/$MACHINE_USER/.aws
    sudo chmod 600 /home/$MACHINE_USER/.aws/credentials /home/$MACHINE_USER/.aws/config
else
    echo "Not Setupping Up the aws cli.env file not found!"
    exit 1
fi

# setup git, but the default user is root, how can we setup the git config for the MACHINE_USER
sudo -u $MACHINE_USER git config --global user.email $GIT_EMAIL
sudo -u $MACHINE_USER git config --global user.name $GIT_NAME
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
