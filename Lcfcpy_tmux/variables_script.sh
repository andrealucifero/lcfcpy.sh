#!/bin/sh
# lcfcpy 2.0
# Script per scrcpy e adb tools
# Per funzioni base Necessita di scrcpy, adb tools e di Tmux
# Per disabilitare la tastiera virtuale installare l'app Android NullKeyboard
# Per visualizzare il traffico della rete installare ifstat

######### Variabili ############

risoluzione=1920x1080/210          #risoluzione schermo virtuale

display=1                          #id schermo

ip_dispositivo=0.0.0.0:5555        #ip dispositivo più porta :5555

bit_rate=8M			                   #valore es. 2M per Wifi o 8M per USB

rotazione_schermo=0	               #valori da 0 a 3

schedarete=wlp2s0 		   
#necessita di ifstat installato, inserire il nome della scheda di rete desiderata

tastiera_predefinita=com.touchtype.swiftkey/com.touchtype.KeyboardService   
#adb shell ime list -a -s per sapere il nome completo tastiera



######################################################################################
######################################################################################
echo "--------------------------------------------------------------------------------"
echo "                                    lcfcpy.sh	           andrealucifero.it"
echo "================================================================================"
echo "=====   Digita il Carattere/Numero Associato   =======   x per uscire   ========"
echo "================================================================================"
echo " 							  Device IP $ip_dispositivo "
echo " 1) Abilita display secondario ($risoluzione ID display=$display)"
echo " 2) Riavvia il dispositivo per la Desktop mode (Solo con esito positivo step 1)"
echo " 3) Abilita adb in WiFi (il dispositivo deve essere connesso con cavo usb)"
echo " 4) Connete adb in Wifi (il dispositivo deve essere connesso nella stessa rete)"
echo " 5) Esegui scrcpy"
echo ""
printf "%-30s  | %25s\n" ' q/w) Abilita/Disabilita Rete dati' ' a/s) Abilita/Disabilita Tastiera virtuale'
printf "%-34s  | %32s\n" '   h) Abilita Hotspot' 'p) Elimina display secondario'
printf "%-34s  | %26s\n" '   b) Percentuale Batteria' 'n) Traffico rete '$schedarete''
echo "--------------------------------------------------------------------------------"


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
  echo "   #######   Verificare ID display e che il dispositivo sia connesso  #######"
  adb shell dumpsys display | grep "mDisplayId="
  tmux split-window -d -v -p 45 "scrcpy --shortcut-mod "lctrl" --disable-screensaver --lock-video-orientation "$rotazione_schermo" --display "$display" -b $bit_rate -Sf --stay-awake" #;read"  (per la modalita lettura)
  exec $0;;

s)
  clear
  adb shell ime set com.wparam.nullkeyboard/.NullKeyboard
  echo "#########   Tastiera virtuale disabilitata   #########"
  exec $0;;

a)
  clear
  adb shell ime set $tastiera_predefinita
  echo "=========   Tastiera virtuale abilitata   ========="
  exec $0;;

q)
  clear
  adb shell svc data enable
  echo "=========   Rete dati abilitati   ========="
  exec $0;;

w)
  clear
  adb shell svc data disable
  echo "#########   Rete dati disabilitati   #########"
  exec $0;;

b)
 clear
 tmux split-window -h -p 25 "adb shell dumpsys battery | grep 'level\|USB powered\|AC powered' | grep -v 'mod level';read "
 exec $0;;

n)
 clear
 tmux split-window -h -p 25 "ifstat -i  $schedarete"
 exec $0;; 

h)
  clear
  adb shell am start -n com.android.settings/.TetherSettings
  adb shell input keyevent 66
  adb shell input keyevent 66
  adb shell input keyevent 66
  adb shell am force-stop com.android.settings
 exec $0;;

p)
 clear
 adb shell settings put global overlay_display_devices 0
 exec $0;;

x)
  ;;

*)
  clear
  echo "#########   VALORE ERRATO!   #########"
  exec $0;;

esac
