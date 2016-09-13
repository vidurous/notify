#!/bin/sh
ts=`date +%H:%M`
ts2=`date +%H:%M:%S-%Z`
export epoch=`date +%s`
export EMAIL=$process
tar zcvf /home/$user/bin/logs/$process.log.$ts.tar.gz /home/$user/$description/notify-service.log 2>1
echo "$description was restarted on $server instance. See attached logs:" > /home/$user/bin/logs/$ts.log
journalctl|grep newcase -B100|grep $ts:[0-9][0-9]|egrep "$process.py|systemd"|cut -d" " -f1-3,5-100 >> /home/$user/bin/logs/$ts.log
cat /home/$user/bin/logs/$ts.log | mutt -s "Debug: $description restarted at $ts2" $email1,$email2 -a /home/$user/bin/logs/$process.log.$ts.tar.gz
