# lcfcpy

lcfcpy è uno script che ha lo scopo di essere un lanciatore per [scrcpy] e di comandi [adb] preimpostati, ottimizzato per abilitare ed usare la desktop mode dei dispositivi Android 10 o superiore.

## Dipendenze e versioni

È possibile scegliere due versioni; 
La prima denominata dal singolo script **lcfcpy** è uno script per chi non ha grosse pretese con funzioni basilari. Per essere adoperato necessita solo di **scrcpy** e di **adb tools** qualora si volesse adoperare la modalità wirless di scrcpy.

Per installare scrcpy rimando alla pagina ufficiale : [github scrcpy]

Per installare adb tools:

```
 apt install adb            #Ubuntu e derivate
 dnf install android-tools  #Fedora
```

per maggiori informazioni rimando alla pagina ufficiale di [adb tools]

La seconda versione è contenuto all’interno della cartella **Lcfcpy_tmux**,  al suo interno troverete due script che devono stare necessariamente insieme perché il primo “**lcfcpy.sh**” serve a richiamare il secondo “**variables_script.sh**” che contiene i comandi [adb] e di [scrcpy] con annesse le relative variabili. Per funzionare correttamente è necessario installare oltre a **scrcpy** e **adb tools** anche **tmux** (terminal multiplexr disponibile nei maggiori repo [Tmux github]).

Per vedere il traffico della scheda di rete installare **ifstat**
```
 apt install ifstat            #Ubuntu e derivate
 dnf install ifstat            #Fedora
```

Se si volesse usare la funzione per disabilitare la tastiera virtuale, installare nel dispositivo Android la tastiera Null Keyboard

Play Store: [Null Keyboard]

### ATTENZIONE.

La funzione per abilitare l’hotspot del telefono adopera la funzione **input keyevent**, tali valori possono cambiare in base al modello di smartphone.
Per maggiori info [Keyevent Android]

## Uso delle variabili

Prima di eseguire lo script ricordarsi di modificare le variabili come: dimensioni del display e ip dispositivo per un uso wirless. **(cambiare il valore dopo il segno = senza lasciare spazi)**. 
Le variabili si trovano nei corrispettivi file “**lcfcpy.sh**” o in “**variables_script.sh**” a secondo della versione scaricata, è possibile adoperare qualsiasi editor di testo.

```
risoluzione=1920x1080/210        #risoluzione schermo virtuale/DPI

display=1                        #id schermo

ip_dispositivo=DEVICE_IP:5555    #ip dispositivo più porta adb 5555

bit_rate=8M                      #valore es. 2M per Wifi o 8M per USB

rotazione_schermo=0              #valori da 0 a 3

schedarete=wlp2s0 		   
#necessita di ifstat installato, inserire il nome della scheda di rete desiderata

tastiera_predefinita=nome_completo_vostra tastiera 
# adb shell ime list -a -s (per sapere il nome completo della vostra tastiera)

```
Per la versione con **Tmux** occorre inserire il percorso completo dello script `variables_script.sh`, questa variabile si trova all'interno del lanciatore `lcfcpy.sh`

```
variables_script='percorso/script/completo/Lcfcpy_tmux/variables_script.sh'
```
Per sapere il percorso completo degli script entrare dentro la directory **Lcfcpy_tmux** e digitare da terminale `pwd`

## Esecuzione

Verificare che lo script abbia i permessi di esecuzione e digitare `./lcfcpy.sh` o `Lcfcpy_tmux/lcfcpy.sh`a secondo della versione scaricata.

Se vi trovate in una shell ash eseguire con `sh ./lcfcpy.sh` o `sh Lcfcpy_tmux/lcfcpy.sh` per sapere che shell adoperate aprite un terminale ed eseguite `echo $0`.

Se lo script non possiede i permessi di esecuzione: `chmod +xr lcfcpy.sh` o `chmod +xr lcfcpy.sh variables_script.sh` a secondo della versione scaricata.
Qualora lo splash screen risultasse troppo lungo o troppo breve potete cambiare i tempi all’interno di lcfcpy.sh.

## Consigli

Le "finestre" che si aprono per indicare la carica del telefono o il traffico della rete,usano tmux in modalita lettura per chiuderle premere `Ctrl + c`, per spostarsi tra le finestre premere `Ctrl + b e successivamente la freccia direzionale`. Si consiglia di leggere la pagina man di Tmux o andare su [Tmux github].
lcfcpy funziona con scrcpy si consiglia di leggere anche la pagina di [scrcpy] o `scrcpy -h`

### Riferimenti:

- [github scrcpy]

- [adb tools]

- [Tmux github]

- [Keyevent Android]

- [Null Keyboard]



[github scrcpy]: https://github.com/Genymobile/scrcpy
[scrcpy]: https://github.com/Genymobile/scrcpy
[adb tools]: https://developer.android.com/studio/command-line/adb
[adb]: https://developer.android.com/studio/command-line/adb
[Tmux github]: https://github.com/tmux/tmux/wiki
[Null Keyboard]: https://play.google.com/store/apps/details?id=com.wparam.nullkeyboard&hl=it&gl=IT
[Keyevent Android]: https://developer.android.com/reference/android/view/KeyEvent.htm