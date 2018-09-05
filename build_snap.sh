# Reset
Color_Off='\033[0m'       # Text Reset

# Regular Colors
Black='\033[0;30m'        # Black
Red='\033[0;31m'          # Red
Green='\033[0;32m'        # Green
Yellow='\033[0;33m'       # Yellow
Blue='\033[0;34m'         # Blue
Purple='\033[0;35m'       # Purple
Cyan='\033[0;36m'         # Cyan
White='\033[0;37m'        # White

# Bold
BBlack='\033[1;30m'       # Black
BRed='\033[1;31m'         # Red
BGreen='\033[1;32m'       # Green
BYellow='\033[1;33m'      # Yellow
BBlue='\033[1;34m'        # Blue
BPurple='\033[1;35m'      # Purple
BCyan='\033[1;36m'        # Cyan
BWhite='\033[1;37m'       # White

# Background
On_Black='\033[40m'       # Black
On_Red='\033[41m'         # Red
On_Green='\033[42m'       # Green
On_Yellow='\033[43m'      # Yellow
On_Blue='\033[44m'        # Blue
On_Purple='\033[45m'      # Purple
On_Cyan='\033[46m'        # Cyan
On_White='\033[47m'       # White

SNAPPY_PROJECTS=/home/$USER

if [ -z "$1" ]; then
    echo -e "${BRed}Error: ${Yellow}1 Argument missing. Snap project folder is mandatory. $Color_Off" 
    exit
fi

PROJECT_FOLDER=$1

echo -e "$Cyan"
echo -e "-------------------------------------------------"
echo -e ""
echo -e " Building ${Yellow}$PROJECT_FOLDER $Cyan"
echo -e " Snappy Projects Home: ${Yellow}$SNAPPY_PROJECTS $Cyan"
echo -e ""
echo -e "------------------------------------------------- $Color_Off"

echo -e "${BYellow}Start snaping... $Color_Off"
lxc launch ubuntu:16.04 snapcraft -c security.privileged=true && \
#lxc config profile set default security.privileged true
lxc config device add snapcraft homedir disk source=$SNAPPY_PROJECTS path=/home/ubuntu && \
echo -e "${Yellow}Please wait while container is starting. This action can take 1 or 2 minutes. $Color_Off"
sleep 20
lxc exec snapcraft -- snap install snapcraft --classic >/dev/null 2>&1
echo -e "${Yellow}Installing and configuring tools ... $Color_Off"
lxc exec snapcraft -- snap install snapcraft --classic && \
lxc exec snapcraft -- sh -c "apt update && apt install python-pip -y" && \
lxc exec snapcraft -- sh -c "cd /home/ubuntu/$PROJECT_FOLDER; snapcraft" && \
echo -e "${Yellow}Cleaning lxd.. $Color_Off"
lxc stop snapcraft && \
lxc delete snapcraft && \
echo -e "${BYellow}Done! $Color_Off"
