#Configure servers
SERVER1=imap.mail.yahoo.com
SERVER2=pod51011.outlook.com
ADMINUSER='sysadmin@C1707.onmicrosoft.com'

echo Looping on account credentials found in file.txt
echo

{ while IFS=';' read  u1 p1 u2 p2
    do 
        { echo "$u1" | egrep "^#" ; } > /dev/null && continue # this skip commented lines in file.txt
        echo "==== Moving password $u1 to passfile ===="
		echo "$p1" > ~/pass1
		chmod 600 ~/pass1
		echo "$p2" > ~/pass2
		chmod 600 ~/pass2
		echo "==== Syncing user $u1 to user $u2 ===="
imapsync \
--host1 ${SERVER1} \
--user1 "$u1" \
--passfile1 ~/pass1 \
--authmech1 PLAIN \
--ssl1 \
--host2 ${SERVER2} \
--authuser2 ${ADMINUSER} \
--user2 "$u2" \
--passfile2 ~/pass2 \
--ssl2 \
--nocheckmessageexists \
--syncinternaldates \
--usecache \
--useheader ALL \
--maxsize 10000000 \
--maxlinelength 9900 \
--regexflag 's/\\Flagged//g' \
--disarmreadreceipts

        echo "==== End syncing user $u1 to user $u2 ===="
		echo "==== Removing Passfile ===="
		rm -rf ~/pass1
		rm -rf ~/pass2
		echo "==== Passfile Removed ===="
        echo
    done 
} < file.txt


