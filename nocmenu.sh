#!/bin/bash

# set -x

#if [ -d "/etc/nagios/" ]; then
#	curdir="/etc/nagios/fixnoc"
#else
#	curdir="/home/fixnoc"
#fi
#curdir="/var/www/html/fixnoc"
curdir="curl -sL test.kapara.tk/fixnoc"

echo "
[1]  = Abuse v2.0 Script $(tput setaf 1){RUN}$(tput sgr 0)
[2]  = Show Connections $(tput setaf 1){RUN}$(tput sgr 0)
[3]  = Boot Clean $(tput setaf 1){RUN}$(tput sgr 0)
[4]  = Find Big Files $(tput setaf 1){RUN}$(tput sgr 0)
[5]  = Ram Use $(tput setaf 1){RUN}$(tput sgr 0)
[6]  = Swap Use $(tput setaf 1){RUN}$(tput sgr 0)
[7]  = Empty Logs $(tput setaf 1){RUN}$(tput sgr 0)
[8]  = TEST emptylogs TEST
[9]  = Cpanel Link $(tput setaf 1){RUN}$(tput sgr 0)
[10] = Remove Snapshots From Same Servers $(tput setaf 2){SHOW}$(tput sgr 0)
[11] = List Of Server Backups $(tput setaf 2){SHOW}$(tput sgr 0)
[12] = Restart Alerts Services Of VM $(tput setaf 2){SHOW}$(tput sgr 0)
[13] = Fix Read-Only Issue $(tput setaf 2){SHOW}$(tput sgr 0)
[14] = Clean Boot Folder With Script Errors $(tput setaf 2){SHOW}$(tput sgr 0)
[15] = Install Nagios On Linux $(tput setaf 1){RUN}$(tput sgr 0)
[16] = Add Swap $(tput setaf 1){RUN}$(tput sgr 0)
[17] = Remove Swap $(tput setaf 1){RUN}$(tput sgr 0)
$(tput sgr 0)
"
#[0] = Smtp Delay Fix $(tput setaf 1){RUN}$(tput sgr 0)

read -p "Enter number : " id

case "$id" in
 1)  $curdir/scripts/abuse_2_1 | bash ;;
 2)  $curdir/scripts/abuseshow | bash ;;
 3)  $curdir/scripts/bootclear | bash ;;
 4)  $curdir/scripts/findbig | bash ;;
 5)  $curdir/scripts/ramuse | bash ;;
 6)  $curdir/scripts/swapuse | bash ;;
 7)  $curdir/scripts/emptylogs | bash ;;
 8)  $curdir/scripts/TESTemptylogs | bash ;;
 9)  $curdir/scripts/whmlink | bash ;;
# 10)  $curdir/scripts/smtpfix ;;
 10)  $curdir/scripts/snapshots  ;; 
 11)  $curdir/scripts/restorelist  ;; 
 12)  $curdir/scripts/vmalertrestart  ;; 
 13)  $curdir/scripts/readonlyrepair  ;; 
 14)  $curdir/scripts/bootclearwitherror  ;; 
 15)  $curdir/scripts/installnagios | bash ;;
 16)  $curdir/scripts/swapadd | bash ;;
 17)  $curdir/scripts/swaprm | bash ;;
# 0)  $curdir/scripts/smtpfix ;;

esac
exit

