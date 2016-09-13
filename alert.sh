#!/bin/sh
ts=`date +%H:%M`
ts2=`date +%H:%M:%S-%Z`
export epoch=`date +%s`
export EMAIL=notify-service
tar zcvf /home/squizzi/bin/logs/notify-service.log.$ts.tar.gz /home/squizzi/newcase-notify/notify-service.log 2>1
echo "Newcase-notify was restarted on irondung instance. See attached logs:" > /home/squizzi/bin/logs/$ts.log
journalctl|grep newcase -B100|grep $ts:[0-9][0-9]|egrep "notify-service.py|systemd"|cut -d" " -f1-3,5-100 >> /home/squizzi/bin/logs/$ts.log
cat /home/squizzi/bin/logs/$ts.log | mutt -s "Debug: newcase-notify restarted at $ts2" aathomas@redhat.com,ksquizza@redhat.com -a /home/squizzi/bin/logs/notify-service.log.$ts.tar.gz
