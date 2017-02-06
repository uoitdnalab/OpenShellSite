for PORT in 10000 10001 10002 10003 10004 10005 10006 10007 10008 10009
do
   if screen -list | grep -q $PORT
   then
      continue
   else
      screen -S $PORT -dm nc -v -l -p $PORT
      screen -S $PORT -p 0 -X stuff $'echo ConnectedToListener\r'
   fi
done
