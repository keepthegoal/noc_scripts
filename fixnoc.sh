#!/bin/bash

# Debug
# set -x
curdir="curl -sL raw.githubusercontent.com/keepthegoal/noc_scripts/master"
disk=$(df / | grep /dev | awk '{print $5-0}')
boot=$(df -h | grep boot | awk '{print $5-0}')

#Checking connections from web servers
http=$( netstat -anp |grep -w 'tcp\|udp' | awk '{print $5}' | cut -d: -f1 | sort | uniq | sort -n | wc -l )

#Checking ssh connections
if [[ `cat /etc/*-release | head -1` =~ .*CentOS.* || `cat /etc/*-release | head -1` =~ .*CloudLinux.* ]]; then
        ssh=$(journalctl -u sshd.service -r -n 200 2>/dev/null | egrep "Failed|Failure" | grep -Eo '[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}' | sort | uniq | sort -n | wc -l)
	else
        ssh=$(journalctl -u ssh.service -r -n 200 2>/dev/null| egrep "Failed|Failure" | grep -Eo '[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}' | sort | uniq | sort -n | wc -l)
fi

check_disk () {
	echo "Checking disk..."
	        if [ $disk -ge 90 ] ; then
                read -p 'Press Y/y to clean logs ' ans
                echo
                        case "$ans" in
                                [y/Y])  $curdir/scripts/emptylogs | bash;;
                                *) break ;;
                        esac
        else echo "Disk is OK"
        fi
	disk=
	disk=$(df / | grep /dev | awk '{print $5-0}')
        	if [ $disk -ge 90 ] ; then
                	echo "Your disk still full, checking for big files..." && $curdir/scripts/findbig | bash
	        else echo "Continue checking..."
        	fi
	}

echo "Checking swap..."
	$curdir/scripts/cleanswap | bash

echo "Checking boot..."
	if [ ! -z $boot ] && [ $boot -ge 90 ] ; then
		read -p 'Press Y/y to clean old kernels ' ans
                	echo
                        	case "$ans" in
                                	[y/Y])  $curdir/scripts/bootclear | bash && echo "If its failed use it" && cat $curdir/scripts/bootclearwitherror ;;
	                                *) break ;;
        	                esac
	                echo "Cleaning old kernels..."
	        else echo "Boot is OK"
	fi

echo "Checking disk..."
        if [ $disk -ge 90 ] ; then
		$curdir/scripts/findbig
	fi

echo "Checking http/s connections..."
	if [ $ssh -ge 50 ] || [ $http -ge 50 ] ; then
		echo "Starting Abuse Script..."
		$curdir/scripts/abuse_2_1 | bash
	else echo "Connections is OK"
	fi

	if [ -d "/etc/nagios/" ] ; then
		/etc/nagios/nsca
	else
	        echo "Your server has been checked successfully"
	fi

exit
