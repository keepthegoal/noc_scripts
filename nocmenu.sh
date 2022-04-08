#!/bin/sh

#set -x
curdir="curl -sL raw.githubusercontent.com/keepthegoal/noc_scripts/master/scripts"

echo "
[1]  = Abuse v2.5 Script $(tput setaf 1){RUN}$(tput sgr 0)
[2]  = Show Connections $(tput setaf 1){RUN}$(tput sgr 0)
[3]  = Boot Clean $(tput setaf 1){RUN}$(tput sgr 0)
[4]  = Find Big Files $(tput setaf 1){RUN}$(tput sgr 0)
[5]  = Ram Use $(tput setaf 1){RUN}$(tput sgr 0)
[6]  = Swap Use $(tput setaf 1){RUN}$(tput sgr 0)
[7]  = Empty Logs $(tput setaf 1){RUN}$(tput sgr 0)
[8]  = $(tput setaf 5){TEST}$(tput sgr 0) Abuse v2.6 $(tput setaf 5){TEST}$(tput sgr 0)
[9]  = WHM Link $(tput setaf 1){RUN}$(tput sgr 0)
[10] = Smtp Delay Fix $(tput setaf 1){RUN}$(tput sgr 0)
[11] = Switch Linux Console Notifications $(tput setaf 1){RUN}$(tput sgr 0)
[12] = Remove Snapshots From Same Servers $(tput setaf 2){SHOW}$(tput sgr 0)
[13] = List Of Server Backups $(tput setaf 2){SHOW}$(tput sgr 0)
[14] = Restart Alerts Services Of VM $(tput setaf 2){SHOW}$(tput sgr 0)
[15] = Fix Read-Only Issue $(tput setaf 2){SHOW}$(tput sgr 0)
[16] = Clean Boot Folder With Script Errors(CentOS) $(tput setaf 1){RUN}$(tput sgr 0)
[17] = $(tput setaf 1){TEST}$(tput sgr 0)
[18] = Add Swap $(tput setaf 1){RUN}$(tput sgr 0)
[19] = Remove Swap $(tput setaf 1){RUN}$(tput sgr 0)
[20] = Install Fixnoc Plugin $(tput setaf 1){RUN}$(tput sgr 0)
$(tput sgr 0)
"

read -p "Enter number : " id
echo
echo "Starting..."
case "$id" in
1) $curdir/abuse | bash ;;
2) $curdir/abuseshow | bash ;;
3) $curdir/bootclear | bash ;;
4) $curdir/findbig | bash ;;
5) $curdir/ramuse | bash ;;
6) $curdir/swapuse | bash ;;
7) $curdir/emptylogs | bash ;;
8) $curdir/abuse_2_6 | bash ;;
9) $curdir/whmlink | bash ;;
10) $curdir/smtpfix | bash ;;
11) $curdir/messages | bash ;;
12) $curdir/snapshots | bash ;;
13) $curdir/restorelist ;;
14) $curdir/vmalertrestart ;;
15) $curdir/readonlyrepair ;;
16) $curdir/bootclearwitherror ;;
17) echo "Pusto" ;;
18) $curdir/swapadd | bash ;;
19) $curdir/swaprm | bash ;;
20) curl -sL raw.githubusercontent.com/keepthegoal/noc_scripts/master/install | bash ;;
esac
echo "Ending..."
exit
