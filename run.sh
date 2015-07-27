#Configure servers
SERVER1=imap.mail.yahoo.com
SERVER2=pod51011.outlook.com
ADMINUSER='sysadmin@C1707.onmicrosoft.com'
PF1=/tmp/pass1
PF2=/tmp/pass2

echo Looping on account credentials found in file.txt
echo

{ while IFS=';' read  u1 p1 u2 p2
    do 
        { echo "$u1" | egrep "^#" ; } > /dev/null && continue # this skip commented lines in file.txt
        echo "==== Moving password $u1 to passfile ===="
		echo "$p1" > ${PF1}
		chmod 600 ${PF1}
		echo "$p2" > ${PF2}
		chmod 600 ${PF2}
		echo "==== Syncing user $u1 to user $u2 ===="
imapsync \
--host1 ${SERVER1} \
--user1 "$u1" \
--passfile1 ${PF1} \
--authmech1 PLAIN \
--ssl1 \
--host2 ${SERVER2} \
--authuser2 ${ADMINUSER} \
--user2 "$u2" \
--passfile2 ${PF2} \
--ssl2 \
--nocheckmessageexists \
--syncinternaldates \
--usecache \
--useheader ALL \
--regexflag 's/.*?(?:(\\(?:Answered|Flagged|Deleted|Seen|Draft)\s?)|$)/defined($1)?$1:q()/eg' \
--regexflag 's/\$\s//g' \
--disarmreadreceipts \
--fast \
--noreleasecheck \
--noauthmd5 \
--split1 100 \
--split2 100
#--delete2duplicatesv \#
#--allowsizemismatch \#
#--maxlinelength 990000#

        echo "==== End syncing user $u1 to user $u2 ===="
		echo "==== Removing Passfile ===="
		rm -rf ${PF1}
		rm -rf ${PF2}
		echo "==== Passfile Removed ===="
        echo
    done 
} < file.txt
