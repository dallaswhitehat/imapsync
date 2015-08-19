/usr/bin/imapsync --maxsize 26000000 --maxlinelength 9900 \
  --regexflag s/\Flagged//g --disarmreadreceipts --useuid --addheader \
  --tmpdir /var/tmp_imapsync --host1 mail.example.com --user1
user*masteruser \
  --password1  PWCHANGED --tls1 --host2 outlook.office365.com --port2 993 \
  --authuser2 masteruser at example dot com --user2 user at example dot com --password2
PWCHANGED MASKED \
  --ssl2 --nofoldersizes --regextrans2 s/INBOX.Drafts$/Drafts/ \
  --regextrans2 s/INBOX.Notes$/Notes/ \
  --regextrans2 s/INBOX.Template$/Templates/ \
  --regextrans2 s/Sent$/Sent Items/ \
  --regextrans2 s/INBOX.Sent Items$/Sent Items/ \
  --regextrans2 s/Sent Messages$/Sent Items/ \
  --regextrans2 s/Trash$/Deleted Items/ \
  --regextrans2 s/INBOX.Trash$/Deleted Items/ \
  --regextrans2 s/Deleted Messages$/Deleted Items/ \
  --regextrans2 s/Junk$/Junk Email/ \
  --regextrans2 s/Junk E-mail$/Junk Email/ \
  --maxlinelengthcmd 'reformime -r7' \
  --delete2 --expunge2 --delete2foldersbutnot
/Calendar$|Contacts$|Infected\ Items$|Junk\
Email$|Journal$|Notes$|Outbox$|RSS\ Feeds$|Sync\ Issues$|Sync\
Issues\/Conflicts$|Sync\ Issues\/Local\ Failures$|Sync\ Issues\/Server\
Failures$|Tasks$/
