#!/bin/sh

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

