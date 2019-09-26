#!/bin/sh

set -x
if [[ `uname -a | awk '{print $1}'` =~ .*FreeBSD.* ]];then
            echo "******************************************"
            echo Found FreeBSD installation.
            echo Installing Nagios...
            echo "******************************************"
            if [ ! -d "/etc/nagios" ]; then
                        echo "******************************************"
                        echo Installing wget
                        echo "******************************************"
                        cd /tmp
                        pkg install -y -f wget
                        pkg update -y -f            
                        echo "******************************************"
                        echo Installing nsca-client nagios-plugins....
                        echo "******************************************"
                        freeVer=`uname -a | grep -o "freenas.*" | cut -d/ -f2 | grep -o -E '[0-9]+' | head -1`
                        pkg add http://pkg.freebsd.org/freebsd:$freeVer:x86:64/latest/All/libmcrypt-2.5.8_3.txz
                        pkg add http://pkg.freebsd.org/freebsd:$freeVer:x86:64/latest/All/nsca-client-2.9.2_1.txz
                        pkg add http://pkg.freebsd.org/freebsd:$freeVer:x86:64/latest/All/nagios-plugins-2.2.1_6,1.txz
                        cd /
                        mkdir /etc/nagios
                        cd /etc/nagios
                        wget -t 2 --connect-timeout=3 ftp://ftpnagomc%40ftp.nag.omc.co.il:E40MCNag@5.100.254.221/nsca.freebsd.tgz
                        tar -xzf nsca.freebsd.tgz           
                        while    [ ! -f /etc/nagios/nscaConfig ]
                        do
                                    echo "******************************************"
                                    echo Open FTP port on https://5.100.254.221
                                    echo "******************************************"
                                    wget -t 2 --connect-timeout=5 ftp://ftpnagomc%40ftp.nag.omc.co.il:E40MCNag@5.100.254.221/nsca.freebsd.tgz
                                    tar -xzf nsca.tgz 
                        done
                        chmod +x /etc/nagios/*
                        chmod +x /etc/nagios/plugins/*
                        cp -f /usr/local/bin/perl /usr/bin/
                        cp send_nsca_amd64 send_nsca_$HOSTTYPE
                        kldload linux
                        mkdir /lib64
                        cd /lib64
                        wget -t 2 --connect-timeout=3 ftp://ftpnagomc%40ftp.nag.omc.co.il:E40MCNag@5.100.254.221/ld-linux-x86-64.so.2
                        chmod +x /lib64/ld-linux-x86-64.so.2                 
                        wget -t 2 --connect-timeout=3 ftp://ftpnagomc%40ftp.nag.omc.co.il:E40MCNag@5.100.254.221/ld-2.17.so
                        ln -s /lib64/ld-2.17.so /lib64/ld-linux-x86-64.so.2                        
                        chmod +x /lib64/ld-2.17.so                    
                        wget -t 2 --connect-timeout=3 ftp://ftpnagomc%40ftp.nag.omc.co.il:E40MCNag@5.100.254.221/libmcrypt.so.4.4.8
                        ln -s /lib64/libmcrypt.so.4.4.8 /lib64/libmcrypt.so.4
                        chmod +x /lib64/libmcrypt.so.4.4.8
                        wget -t 2 --connect-timeout=3 ftp://ftpnagomc%40ftp.nag.omc.co.il:E40MCNag@5.100.254.221/libnsl-2.17.so
                        ln -s /lib64/libnsl-2.17.so /lib64/libnsl.so.1
                        chmod +x /lib64/libnsl-2.17.so
                        wget -t 2 --connect-timeout=3 ftp://ftpnagomc%40ftp.nag.omc.co.il:E40MCNag@5.100.254.221/libc-2.17.so
                        ln -s /lib64/libc-2.17.so /lib64/libc.so.6
                        chmod +x /lib64/libc-2.17.so
                        wget -t 2 --connect-timeout=3 ftp://ftpnagomc%40ftp.nag.omc.co.il:E40MCNag@5.100.254.221/libdl-2.17.so
                        ln -s /lib64/libdl-2.17.so /lib64/libdl.so.2
                        chmod +x /lib64/libdl-2.17.so
                        cd /lib
                        wget -t 2 --connect-timeout=3 ftp://ftpnagomc%40ftp.nag.omc.co.il:E40MCNag@5.100.254.221/libmcrypt.so.4.4.8
                        ln -s /lib/libmcrypt.so.4.4.8 /lib/libmcrypt.so.4
                        chmod +x libmcrypt.so.4.4.8
                        wget -t 2 --connect-timeout=3 ftp://ftpnagomc%40ftp.nag.omc.co.il:E40MCNag@5.100.254.221/ld-2.17.so.1
                        ln -s /lib/ld-2.17.so.1 /lib/ld-linux.so.2 
                        chmod +x /lib/ld-2.17.so.1
                        wget -t 2 --connect-timeout=3 ftp://ftpnagomc%40ftp.nag.omc.co.il:E40MCNag@5.100.254.221/libdl-2.17.so.1
                        ln -s /lib/libdl-2.17.so.1 /lib/libdl.so.2
                        chmod +x /lib/libdl-2.17.so.1
                        wget -t 2 --connect-timeout=3 ftp://ftpnagomc%40ftp.nag.omc.co.il:E40MCNag@5.100.254.221/libc-2.17.so.1
                        ln -s /lib/libc-2.17.so.1 /lib/libc.so.6
                        chmod +x /lib/libc-2.17.so.1
                        wget -t 2 --connect-timeout=3 ftp://ftpnagomc%40ftp.nag.omc.co.il:E40MCNag@5.100.254.221/libm-2.17.so.1
                        ln -s /lib/libm-2.17.so.1 /lib/libm.so.6
                        chmod +x /lib/libm-2.17.so.1

                        perl -pi -e 's/^host=.*/host=41428_il-rh_vm_sql5.0404.co.il/' /etc/nagios/nscaConfig
                        echo "*/5 * * * * root /etc/nagios/nsca > /dev/null 2>&1" >> /etc/crontab
                        cd /
                        /etc/nagios/nsca
            else
                        echo "******************************************"
                        echo Nagios installation found!
                        echo Skipping...
                        echo "******************************************"
            fi
elif [[ `cat /etc/*-release | head -1` =~ .*CentOS.* || `cat /etc/*-release | head -1` =~ .*CloudLinux.* ]]; then
            echo "******************************************"
            echo Found CentOS installation.
            echo Installing Nagios...
            echo "******************************************"
            if [ ! -f "/etc/nagios/nsca" ]; then
                        cd /tmp/
                        yum update -y
                        yum install wget -y
                        wget http://ftp.pbone.net/mirror/apt.sw.be/redhat/el5/en/i386/rpmforge/RPMS/rpmforge-release-0.5.3-1.el5.rf.i386.rpm   
                        rpm -Uvh rpmforge-release-0.5.3-1.el5.rf.i386.rpm 
                        wget http://ftp.pbone.net/mirror/apt.sw.be/redhat/el6/en/x86_64/rpmforge/RPMS/rpmforge-release-0.5.3-1.el6.rf.x86_64.rpm    
                        rpm -Uvh rpmforge-release-0.5.3-1.el6.rf.x86_64.rpm  
                        yum install libmcrypt -y
                        yum install ld-linux.so.2 -y
                        yum install nagios-nsca-client -y
                        mkdir /etc/nagios
                        cd /etc/nagios/
                        wget -t 2 --connect-timeout=3 ftp://ftpnagomc%40ftp.nag.omc.co.il:E40MCNag@5.100.254.221/nsca.tgz
                        tar -xzf nsca.tgz
                        while    [ ! -f /etc/nagios/nscaConfig ]
                        do
                                    echo "******************************************"
                                    echo Open FTP port on https://5.100.254.221
                                    echo "******************************************"
                                    wget -t 2 --connect-timeout=5 ftp://ftpnagomc%40ftp.nag.omc.co.il:E40MCNag@5.100.254.221/nsca.tgz
                                    tar -xzf nsca.tgz 
                        done
                        perl -pi -e 's/^host=.*/host=41428_il-rh_vm_sql5.0404.co.il/' /etc/nagios/nscaConfig
                        if [ -d "/etc/csf" ]; then
                                    csfV=`csf`
                                    if [[ ! $csfV =~ .*"use 'csf -e' to enable".* ]]; then
                                                csf -a 77.247.180.45
                                                csf -r  > /dev/null 2>&1
                                    else
                                                iptables -I OUTPUT -p tcp --dport 5667 -j ACCEPT
                                                /sbin/service iptables save
                                    fi
                        fi
                        (crontab -l 2>/dev/null; echo "*/5 * * * * /etc/nagios/nsca > /dev/null 2>&1") | crontab
                        /etc/nagios/nsca
            else
                        echo "******************************************"
                        echo Nagios installation found!
                        echo Skipping...
                        echo "******************************************"
            fi
elif [[ `cat /etc/*-release | head -1` =~ .*Ubuntu* ]] || [[ `cat /etc/*-release | head -1` =~ .*Debian.* ]] || [[ `cat /proc/version` =~ .*Debian.* ]]; then
            echo "******************************************"
            echo Found Ubuntu/Debian installation.
            echo Installing Nagios...
            echo "******************************************"
            if [ ! -d "/etc/nagios" ]; then
                        echo "******************************************"
                        echo Installing apt-get install....
                        echo "******************************************"
                        cd /tmp/
                        apt-get --yes --force-yes -f install wget
                        if [[ `cat /etc/*-release | head -1` =~ .*Debian.* ]] || [[ `cat /proc/version` =~ .*Debian.* ]]; then
                                    # echo "deb http://ftp.de.debian.org/debian jessie main" >> /etc/apt/sources.list
                                    wget http://ftp.de.debian.org/debian/pool/main/libm/libmcrypt/libmcrypt4_2.5.8-3.3_amd64.deb
                                    dpkg -i libmcrypt4_2.5.8-3.3_amd64.deb
                                    wget http://ftp.de.debian.org/debian/pool/main/n/nsca/nsca-client_2.9.1-3.1_amd64.deb
                                    dpkg -i nsca-client_2.9.1-3.1_amd64.deb
                                    wget http://ftp.de.debian.org/debian/pool/main/n/nagios-plugins/nagios-plugins-common_1.4.16-1_amd64.deb
                                    dpkg -i nagios-plugins-common_1.4.16-1_amd64.deb
                                    wget http://ftp.de.debian.org/debian/pool/main/n/nagios-plugins/nagios-plugins-basic_1.4.16-1_amd64.deb
                                    dpkg -i nagios-plugins-basic_1.4.16-1_amd64.deb
                        fi          
                        apt-get update
                        apt-get --yes --force-yes -f install
                        echo "******************************************"
                        echo Installing apt-get install nsca-client nagios-plugins....
                        echo "******************************************"
                        apt-get --yes --force-yes -f install nsca-client nagios-plugins
                        mkdir /etc/nagios
                        cd /etc/nagios
                        wget -t 2 --connect-timeout=3 ftp://ftpnagomc%40ftp.nag.omc.co.il:E40MCNag@5.100.254.221/nsca.tgz
                        tar -xzf nsca.tgz
                        while    [ ! -f /etc/nagios/nscaConfig ]
                        do
                                    echo "******************************************"
                                    echo Open FTP port on ftp 5.100.254.221
                                    echo "******************************************"
                                    wget -t 2 --connect-timeout=5 ftp://ftpnagomc%40ftp.nag.omc.co.il:E40MCNag@5.100.254.221/nsca.tgz
                                    tar -xzf nsca.tgz 
                        done
                        rm -rf /etc/nagios/plugins
                        if [[ `cat /etc/*-release | uniq; echo -n "System architecture is: "; case $(echo $HOSTTYPE) in i686|i386) echo -e "\e[1;32m32 bit\e[0m\\n\\n";; x86_64) echo -e "\e[1;32m64 bit\e[0m\\n\\n";; *) echo $HOSTTYPE;; esac | grep bit | tail -1` =~ .*32.* ]]; then
                                    ln -s /usr/lib/nagios/plugins plugins
                        else
                                    if [ -a /usr/lib64/nagios/plugins ];then
                                                ln -s /usr/lib64/nagios/plugins plugins
                                    else
                                                ln -s /usr/lib/nagios/plugins plugins
                                    fi
                        fi
                        sed -i 's/^host=.*/host=41428_il-rh_vm_sql5.0404.co.il/' /etc/nagios/nscaConfig
                        sed -i '1 i#!/bin/bash' /etc/nagios/nsca
                        sed -i 's|^$curDir =.*|$curDir = "/etc/nagios";|' /etc/nagios/send_data.pl
                        (crontab -l 2>/dev/null; echo "*/5 * * * * /etc/nagios/nsca > /dev/null 2>&1") | crontab
                        cd /
                        /etc/nagios/nsca
            else
                        echo "******************************************"
                        echo Nagios installation found!
                        echo Skipping...
                        echo "******************************************"
            fi
else
            echo "******************************************"
            echo No known Linux installation found.
            echo Exiting...
            echo "******************************************"
            exit
fi
                        
echo "******************************************"
echo Check for cPanel installation to disable SMTP delay.
echo "******************************************"
if [ ! -f /etc/exim/delay_unknown_hosts ]; then
            if [ "$(service cpanel status 2>&1 | wc -l)" -gt "1" ]; then
                        echo "******************************************"
                        echo cPanel instalation found.
                        echo Start fixing SMTP delay.
                        echo "******************************************"
                        mkdir /etc/exim
                        echo "sed -i '0,/delay = 20s/s//delay = 5s/' /etc/exim.conf" > /etc/exim/delay_unknown_hosts
                        echo "sed -i 's/77.247.180.45//g' /etc/skipsmtpcheckhosts" >> /etc/exim/delay_unknown_hosts
                        echo "service exim restart" >> /etc/exim/delay_unknown_hosts
                        (crontab -l 2>/dev/null; echo "10 3 * * * /etc/exim/delay_unknown_hosts > /dev/null 2>&1") | crontab
                        chmod +x /etc/exim/delay_unknown_hosts
                        /etc/exim/delay_unknown_hosts
            else
                        echo "******************************************"
                        echo No cPanel installtion found.
                        echo "******************************************"
            fi
else
            echo "******************************************"
            echo SMTP delay already configured.
            echo Skipping...
            echo "******************************************"
fi

     echo What is the VM Name?
     read VMNAME
     sed -i "s/^host=.*/host=$VMNAME/" /etc/nagios/nscaConfig
     echo What is the IP Address?
     read ADDRESS
            
     echo What kind of custom alerts would you like on the server besides MEM,DISK,CPU?
    read ALERTS
            
     echo "
define host {
        host_name       $VMNAME
        use     generic-server
        display_name    $VMNAME
        alias   $VMNAME
        address $ADDRESS
        hostgroups      nsca_check_cpu,nsca_check_mem,nsca_check_disk,$ALERTS
        contact_groups  OMC - Cloud Services
        notification_interval   1440
        notifications_enabled   1
}
"


csf -a 77.247.180.45

echo "Monitor added to csf"

exit

