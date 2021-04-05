#!/bin/sh
# lcfcpy 1.0
# Script per scrcpy e comandi adb

# Per funzioni base Installare scrcpy e adb tools
# La modalità Desktop è disponibile da Android 10
# Per disabilitare la tastiera virtuale installare l'app Android NullKeyboard
# Prima di eseguire lo script verificare le variabili dopo il segno = non lasciare spazi.

######### Variabili ############

risoluzione=1920x1080/210          #risoluzione schermo virtuale + DPI

display=1                          #id schermo, per clonare lo schermo inserire 0

ip_dispositivo=0.0.0.0:5555        #ip dispositivo più porta :5555

bit_rate=8M			                   #valore es. 2M per Wifi o 8M per USB

rotazione_schermo=0	               #valori da 0 a  3

ripristina_tastiera=com.touchtype.swiftkey/com.touchtype.KeyboardService
# adb shell ime list -a -s ( per sapere il nome completo della vostra tastiera )

#colore
red="\e[1;31m"
reset="\e[0m"
bold="\e[1m"
######################################################################################
######################################################################################
echo "--------------------------------------------------------------------------------"
echo "                                    lcfcpy.sh                andrealucifero.it"
echo "--------------------------------------------------------------------------------"
echo "=========================    Abilitare il Debug USB    ========================="
echo "===========  E collegare lo smartphone al Computer tramite cavo  ==============="
echo "--------------------------------------------------------------------------------"
echo "================================================================================"
echo "=====   Digita il Carattere/Numero Associato   =======   x per uscire   ========"
echo "================================================================================"
echo " 							  Device IP $ip_dispositivo "
echo ""
echo " 1) Abilita display secondario ($risoluzione; ID display=$display; Bit-rate=$bit_rate)"
echo " 2) Riavvia il dispositivo per la Desktop mode (Solo con esito positivo step 1)"
echo " 3) Abilita adb in WiFi (il dispositivo deve essere connesso con cavo usb)"
echo " 4) Connete adb in Wifi (il dispositivo deve essere connesso nella stessa rete)"
echo " 5) Esegui scrcpy "
echo " "
echo " a/s) Abilita/Disabilita Tastiera virtuale"

trap restore INT
read opt
case $opt in

1)
  clear
  adb shell settings put global overlay_display_devices $risoluzione
  adb shell settings put global enable_freeform_support 1
  adb shell settings put global force_desktop_mode_on_external_displays 1
  exec $0;;

2)
  clear
  adb reboot
  echo "--------------------------------------------------------------------------------"
  echo "     ==========    Aspettare che il Dispositivo si riavvi     ==============="
  exec $0;;

3)
  clear
  adb tcpip 5555
  echo "--------------------------------------------------------------------------------"
  echo "    ===================   Con esito positivo premi 4   ======================="
  exec $0;;

4)
  clear
  adb connect $ip_dispositivo
  echo "--------------------------------------------------------------------------------"
  echo "   ==========  Verificare di essere connessi alla stessa rete  =============="
  exec $0;;

5)
  clear
  echo "--------------------------------------------------------------------------------"
  echo "===========================    Scrcpy   =================================="
  scrcpy --shortcut-mod "lctrl" --disable-screensaver --lock-video-orientation "$rotazione_schermo" --display "$display" -b $bit_rate -Sw -f
  exec $0;;

a)
  clear
  adb shell ime set $ripristina_tastiera
  echo "=========   Tastiera virtuale abilitata   ========="
  exec $0;;

s)
  clear
  adb shell ime set com.wparam.nullkeyboard/.NullKeyboard
  echo "#########   Tastiera virtuale disabilitata   #########"
  exec $0;;

x)
  ;;

*)
  clear
  echo "#########   VALORE ERRATO!   #########"
  exec $0;;

esac

 	function restore {
		 clear
		 echo ""
		 echo -e "${bold} Visita ${red} andrealucifero.it ${reset}"
		 echo ""
		 echo "	  Ciao Ciao!"
		 echo ""
		exit
	}

restore
