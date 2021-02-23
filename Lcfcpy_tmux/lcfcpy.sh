#!/bin/bash
#esegue lcfcpy in Tmux

####### Variabili ########
# inserire il percorso completo degli script variables_script.sh

variables_script='percorso/script/completo/Lcfcpy_tmux/variables_script.sh'

trap saluti INT
reset="\e[0m"
bold="\e[1m"
red="\e[1;31m"

clear

echo ""
echo ""
echo ""
echo ""
echo ""
echo ""
echo ""
echo -e "                            ${bold}Benvenuti su lcfcpy.sh!"
echo ""
echo -e "                  ============================================="
echo -e "                     =======================================${reset}"
echo ""
echo -e "                  ${red}            Abilitare il Debug usb "
echo -e "                       E collegare lo smartphone al computer ${reset} "
echo ""
echo -e "                    ${bold}======================================="
echo -e "                  ============================================= ${reset}"

count=1
while [ $count -lt 1800 ]
do
count=`expr $count + 1`
done

clear
tmux new-session -s lcfcpy ' '$variables_script' ';
tmux a;

function saluti {

                clear
echo -e "       ${bold}andrealucifero.it${reset}"

echo "+------------------------------------------------+"
echo "|                .,;clooooolc:,.                 |"
echo "|           ..,;ccdkl:::::::::cclc;'.            |"
echo "|        .,:;;;;;oNWWXOo::::::cccccccl:'         |"
echo "|      ,:,,;;;;;;o0NWWWWNOdc::ccccccccccl:.      |"
echo "|    ,;,,,,;;;;;;;::oOXWWWWN0xlccccccccccccc.    |"
echo "|  .:'',,,,;;;;;;;:::::okXWWWWWKklccccccccccl:   |"
echo "| ';''',,,,;;;;;;;::::::::KWWWWWNkcclcccccccccl  |"
echo "|.;'''',,,,;;;;;;;:::::::OWWW0oxccl0WNOocccccccc |"
echo "|:.'''',,,,;;;;;;;::::::kWWWKccccckKWNxccdxcccco.|"
echo "|c.'''',,,,;;;;;;;::::::llllc:cccccclccoKWWWKklc;|"
echo "|c.'''',,,;ccclllllllldXNNXdooooooooooookKWWWWWX;|"
echo "|:.'''',,;XNNNNNNNNWWWWWWWWWWWWWWWWWWWWWWWWWWWWW.|"
echo "|.;'''',,kKKKXNNNWNNNNNNNNNNNNNNNNNNNNNNNNNNNNNd |"
echo "| ';''',,,,;;oWNNWc:::c:clllllccccccccccccccccl  |"
echo "|  .:'',,,,;;oWNNWc:::ookk0kkdoxOdxcccccccccl:   |"
echo "|    ,;,,,,;;oWNNWc:::::cccccccccccccccccccc.    |"
echo "|      ,:,,;;oWNNWc:::::::::::ccccccccccl:.      |"
echo "|        .,:;oWNNWc:::::::::::cccccccl:'         |"
echo "|           .'oOXWc:::::::::::cclc;'.            |"
echo "|                .,;clooddool:;.                 |"
echo "+------------------------------------------------+"		

		count=1
		while [ $count -lt 1000 ]
		do
		count=`expr $count + 1`
		done
		clear
		exit
		}

saluti;
