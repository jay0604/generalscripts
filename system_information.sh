#! /bin/sh
if [[ $EUID -ne 0 ]]; then
   echo "This script must be run as root"
   exit 1
fi
#Get the SAP SID for the instance
echo "SAP SID"
read SID
#Create the file path for recording the output
echo -e "File path to store the output \n ex:/home/<sidadm>/output.txt "
read FILE
#check for existence of file
if test -f "$FILE"; then
        echo "$FILE exits.Please use an alternate path"
exit
else
   touch $FILE
        echo "Output will be saved to $FILE"
fi
echo "SAP SYSTEM SID = $SID"  >> $FILE
#Details of OS version will help is compatabiity checks for cloud migration
echo -e "===================== \n#OS version "  >> $FILE
uname -a >> $FILE
#Get Hostname, is good to have information for mapping the application to host
echo -e "===================== \n#Hostname" >> $FILE
hostname >> $FILE
#Get Uptime.good to have information for system KPI
echo -e "===================== \n#uptime" >> $FILE
uptime >> $FILE
date>> $FILE
#Get hostentry details ,will help in getting details of host connections and virtual hostname
echo -e "===================== \n#hostentrry details " >> $FILE
cat /etc/hosts >> $FILE
#Get Ip address, will help in understanding system configuration
echo -e "===================== \n#IPCONFIG" >> $FILE
ifconfig >> $FILE
#CPU information is one of the base KPI for hardware compatability in cloud
echo -e "===================== \n#CPU information" >> $FILE
grep -w "cpu cores" /proc/cpuinfo >> $FILE
grep -w "cpu MHz" /proc/cpuinfo >> $FILE
grep -w "model name" /proc/cpuinfo >> $FILE
grep -w "vendor_id: /proc/cpuinfo >> $FILE
#memory information will help system sizing in cloud
echo -e "===================== \n#memory" >> $FILE
grep -w "MemTotal" /proc/meminfo >> $FILE
#memory information will help system sizing in cloud
echo -e "===================== \n#Swap" >> $FILE
free -m  >> $FILE
#memory information will help system sizing in cloud
echo -e "===================== \n#Ulimits" >> $FILE
ulimit -a >> $FILE
echo -e "===================== \n#check ulimits" >> $FILE
cat /etc/security/limits.conf | grep ^@ >> $FILE
#to check SAP packages on the machine
echo -e "===================== \n#sap packages installed" >> $FILE
rpm -qi sapinit sapconf >> $FILE
#To check java version
echo -e "===================== \n#JAVA version" >> $FILE
java -version >> $FILE
#System memeory utilization is one of the KPI for cloud migration sizing
echo -e "===================== \n#shared memory" >> $FILE
ipcs -l >> $FILE
#File system layout is important for as-is migration of the system
echo -e "===================== \n#mount points" >> $FILE
mount -l >> $FILE
echo -e "===================== \n#file system utilization" >> $FILE
df -h >> $FILE
echo -e "===================== \n#storage and stripping" >> $FILE
lsblk -a >> $FILE
#user information is important for as-is migration of the system
echo -e "===================== \n#groups " >> $FILE
cat /etc/group >> $FILE
echo -e "===================== \n#users,shell and home path " >> $FILE
cat /etc/passwd >> $FILE
echo -e "==================== \n# results gathered on" >> $FILE
date>> $FILE
echo "Required information is gathered.Thank you !!!"

