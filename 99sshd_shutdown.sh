#!/system/bin/sh

umask 077
check_stat=`ps | grep 'sshd' | awk '{print $2}'`
if [ -n "$check_stat" ]
then
  echo "sshd is running"
  echo "Killing $check_stat"
  kill -9 $check_stat
else
  echo "sshd isn't running"
fi
