#!/bin/bash
date="$(date +%Y-%m-%d)"
passwd="$(cat /home/hpautomation/Backup/passwd.txt)"
mkdir /home/hpautomation/Backup/$date
mysqldump -u root -p$passwd QA_Automation>/home/hpautomation/Backup/$date/Backup.sql
cd /home/hpautomation/Backup/
echo hpautomation@777 | sudo -S tar -zcvf $date.tar.gz $date
#echo iam@Dearwalk | sudo -S pwd
sudo mount -t cifs -o user=guest,password=mriga2,vers=1.0 //192.168.1.221/DW_Resources/HP_QA_Automation_Server_Backup/ /mnt/221/
sudo mv /home/hpautomation/Backup/$date.tar.gz /mnt/221/
if 
    [ $(ls /mnt/221/ | grep $date | wc -l) -ge 1 ]
then
echo "HP QA Automation DBBackup completed and stored in smb://192.168.1.221/dw_resources/HP_QA_Automation_Server_Backup/$date.tar.gz" | mail -s "HP QA Automation DBBackup Successful." rtuladhar@deerwalk.com, bacharya@deerwalk.com, rbthapa@deerwalk.com, subhandari@deerwalk.com
else
echo "HP QA Automation DBBackup failed. Please try it manually." | mail -s "HP QA Automation DBBackup Failed." rtuladhar@deerwalk.com, bacharya@deerwalk.com, rbthapa@deerwalk.com, subhandari@deerwalk.com
fi
exit 0
