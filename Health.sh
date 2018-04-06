#!/bin/bash
#---------------------- Color Code / Fontstyle -------------------------------
white="\e[97m"
cyan="\e[96m"
magenta="\e[95m"
blue="\e[94m"
yellow="\e[93m"
green="\e[92m"
red="\e[91m"
grey="\e[37m"
default="\e[39m"
bold="\e[1m"
normal="\e[0m"
blink="\e[5m"
#-----------------------------------------------------------------------------
flag=0
updateData()
{
	data="$1|$2|$3|$4|$5|$6"
	echo $data > $1"detail"
	clear
	echo -e "${yellow}Update Successfully Done ....${default}"
	sleep 3
}
saveData()
{
	#touch patientDetail
	id=`cat pid`
	id=$(($id+1))
	echo $id > "pid"
	data="$id|$1|$2|$3|$4|$5"
	echo $data >> $id"detail"
	echo $data >> "allUser"
	clear
	echo -e "${yellow}Successfully Added ....${default}"
    echo "Registered Patient's Id : $id"
	sleep 3
}
add()
{
	echo ""
	read -p "Enter Patient Name                    : " name
	read -p "Enter Patient Birth Date              : " jdate
	read -p "Enter Patient Address                 : " address
	read -p "Enter Patient Phone No                : " phoneno
	read -p "Enter Consultant Doctor's Name        : " doctor
	len=${#phoneno}
	if [ $len -eq 10 ] 
	then
		saveData "$name" $jdate "$address" $phoneno "$doctor"
	else
		echo -e "${red}Invalid Phone No ... ${default}"
		sleep 3
	fi
}
update()
{
	
	echo ""
	read -p "Press Patient Id To Update : " pid
	if [ -s $pid"detail" ]
	then
		#-----------------------------------------------------
		name=`cat $pid"detail" | cut -f2 -d"|" `
		jdate=`cat $pid"detail" | cut -f3 -d"|" `
		address=`cat $pid"detail" | cut -f4 -d"|" `
		phoneno=`cat $pid"detail" | cut -f5 -d"|" `
		doctor=`cat $pid"detail" | cut -f6 -d"|" `
		#-----------------------------------------------------
		echo "Press Following To Update Record:"
		echo "1 For Name"
		echo "2 For Date Of Birth"
		echo "3 For Address"
		echo "4 For Phone No"
		echo "5 For Consultant Doctor"
		read option
		case $option in 
		1)
			read -p "Enter New Name : " name
		;;
		2)
			read -p "Enter New Birth Date : " jdate
		;;
		3)
			read -p "Enter New Address : " address
		;;
		4)
			read -p "Enter New Phone No : " phoneno
		;;
		5)
			read -p "Enter New Doctor's Name : " doctor
		;;
		*)
			echo "Invalid Option"
		;;
		esac
		updateData $pid "$name" $jdate "$address" $phoneno "$doctor"
	else
		clear
		echo -e "${red}Patient Not Found ....${default}"
		sleep 3
	fi
}
delete()
{
	echo ""
	read -p "Enter Patient Id To Delete : " pid
	if [ -s $pid"detail" ]
	then
		echo `rm -f $pid"detail"`
		clear
		echo -e "${yellow}Patient Detail Successfully Deleted ....${default}"
		sleep 3
	else
		echo -e "${red}Patient Not Found ....${default}"
	fi
}
search()
{
	echo ""
	read -p "Enter Patient Id : " pid
	if [ -s $pid"detail" ]
	then
		pidtxt=`cat $pid"detail" | cut -f1 -d"|" `
		pnametxt=`cat $pid"detail" | cut -f2 -d"|" `
		pdatetxt=`cat $pid"detail" | cut -f3 -d"|" `
		paddresstxt=`cat $pid"detail" | cut -f4 -d"|" `
		ppnotxt=`cat $pid"detail" | cut -f5 -d"|" `
		doctor=`cat $pid"detail" | cut -f6 -d"|" `
		echo -e "      "
		echo "Patient Details:"
		echo ""
		echo "Id                  : $pidtxt"
		echo "Name                : $pnametxt"
		echo "Date                : $pdatetxt"
		echo "Address             : $paddresstxt"
		echo "Phone No            : $ppnotxt"
		echo "Consultant Doctor   : $doctor"
		echo "-----------------------------------------------"
		read -p "`echo -e ${yellow}`Press Any Key To Exit `echo -e ${default}`" tempo
	else
		clear
		echo -e "${red}Patient Not Found ...${default}"
		sleep 3
	fi
}
all()
{
	echo ""
	lastid=`cat pid`
	clear
	echo -e "${blue}All Patient Details:${default}"
	for i in $(seq 1 $lastid)
	do
		if [ -s $i"detail" ]
		then
			pidtxt=`cat $i"detail" | cut -f1 -d"|" `
			pnametxt=`cat $i"detail" | cut -f2 -d"|" `
			pdatetxt=`cat $i"detail" | cut -f3 -d"|" `
			paddresstxt=`cat $i"detail" | cut -f4 -d"|" `
			ppnotxt=`cat $i"detail" | cut -f5 -d"|" `
			doctor=`cat $i"detail" | cut -f6 -d"|" `
			echo "--------------------------------------------"
			echo "Id                  : $pidtxt"
			echo "Name                : $pnametxt"
			echo "Date                : $pdatetxt"
			echo "Address             : $paddresstxt"
			echo "Phone No            : $ppnotxt"
			echo "Consultant Doctor   : $doctor"
		else
		  	echo ""
		fi
	done
	read -p "`echo -e ${yellow}`Press Any Key To Exit `echo -e ${default}`" tempo
}
#-------------------------------------------------
saveAppointement()
{
	#touch patientDetail
	data="$1|$2|$3"
	echo $data >> "Appointement"
	echo -e "${yellow}Adding Appointment....${default}"
	sleep 3
}
addAppointement()
{
	echo ""
	read -p "Enter Patient Name         : " appname
	read -p "Enter Doctor Name          : " appdname
	read -p "Enter Appointement Date    : " appdate
	saveAppointement "$appname" "$appdname" "$appdate"
	echo -e "${yellow}Appointment Added succesfully....${default}"
	read -p "`echo -e ${yellow}`Press Any Key To Exit `echo -e ${default}`" tempo
}
searchAppointement()
{
	echo ""
	read -p "Enter Patient Name (Case Sensitive) : " name
	record=`cat Appointement | grep $name`
	for i in $record
	do
		echo ""
		name=`echo $i | cut -f1 -d"|"`
		dname=`echo $i | cut -f2 -d"|"`
		ddate=`echo $i | cut -f3 -d"|"`
		echo "Patient Name         : $name"
		echo "Doctor Nmae          : $dname"
		echo "Date Of Appointement : $ddate"
	done
	read -p "`echo -e ${yellow}`Press Any Key To Exit `echo -e ${default}`" tempo
	
}
allAppointement()
{
	echo ""
	echo -e "${Blue}Appointments: ${default}"
	record=`cat Appointement`
	for i in $record
	do
		echo "--------------------------------------------"
		name=`echo $i | cut -f1 -d"|"`
		dname=`echo $i | cut -f2 -d"|"`
		ddate=`echo $i | cut -f3 -d"|"`
		echo "Patient Name         : $name"
		echo "Doctor Name          : $dname"
		echo "Date Of Appointement : $ddate"
	done
	echo " "
	read -p "`echo -e ${yellow}`Press Any Key To Exit `echo -e ${default}`" tempo
}
#-------------------------------------------------
while [ $flag -eq 0 ]
do
	clear
    echo -e "${red}------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------${default}"
	echo -e "${cyan}|                                                                                         HEALTH COMPANION (OS Project 2017)                                                                                     |${default}"
	echo -e "${red}------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------${default}"
	echo ""
	echo -e "${green}................................${default}"
    echo -e "${green}|Press 1 for Receptionist Menu |${default}"
	echo -e "${green}|Press 2 for Doctor's Menu     |${default}"
	echo -e "${green}|Press 0 To Exit               |${default}"
	echo -e "${green}................................${default}"
	read option1
	case $option1 in
	1)
		echo " "
		read -s -p "Enter The Password : " password
		if [ "$password" = "root" ]
		then
			
			echo -e "${yellow}Login success..!!${default}"
            rflag=0
			while [ $rflag -eq 0 ]
			do
            echo " "
            echo -e "${green}-----------------------------------------------${default}"
			echo -e "${blue}|              RECEPTIONIST MENU              |${default}"
            echo -e "${green}-----------------------------------------------${default}"
			echo -e "${green}|Press 1 for Patient      Record Manipulation |${default}"
			echo -e "${green}|Press 2 for Appointment  Record Manipulation |${default}"
			echo -e "${green}|Press 0 To Exit                              |${default}"
			echo -e "${green}-----------------------------------------------${default}"
			read option1
			case $option1 in
			0)
				rflag=1
			;;
			1)
				rflag1=0
			    while [ $rflag1 -eq 0 ]
			    do
			    echo " "
				echo -e "${green}-----------------------------------------------${default}"
				echo -e "${blue}|           PATIENT MANIPULATION MENU         |${default}"
				echo -e "${green}-----------------------------------------------${default}"
				echo -e "${green}|Press 1 To ADD a Patient Record              |${default}"
			    echo -e "${green}|Press 2 To Update Record                     |${default}"
			    echo -e "${green}|Press 3 To Delete a Record                   |${default}"
			    echo -e "${green}|Press 4 To Search a Record                   |${default}"
			    echo -e "${green}|Press 5 To Show All Patient Records          |${default}"
				echo -e "${green}|Press 0 To Exit                              |${default}"
				echo -e "${green}-----------------------------------------------${default}"
				read option1
				case $option1 in
				0)
				    rflag1=1
				;;
				1)
				    add
			    ;;
			    2)
				    update
			    ;;
			    3)
				    delete
			    ;;
			    4)
				    search
			    ;;
			    5)
				    all
			    ;;
				*)
				    echo -e "${red}Invalid Option..!!${default}"
			    ;;
				esac
				done
			;;	
			2)
				rflag1=0
				while [ $rflag1 -eq 0 ]
				do
				echo " "
				echo -e "${green}-----------------------------------------------${default}"
				echo -e "${blue}|        APPOINTMENT MANIPULATION MENU        |${default}"
				echo -e "${green}-----------------------------------------------${default}"
				echo -e "${green}|Press 1 To Add An Appointement               |${default}"
				echo -e "${green}|Press 2 To Search for An Appointement        |${default}"
				echo -e "${green}|Press 3 To Show All Appointements            |${default}"
				echo -e "${green}|Press 0 To Exit                              |${default}"
				echo -e "${green}-----------------------------------------------${default}"
				read option1
				case $option1 in
				0)
					rflag1=1
				;;
				1)
					addAppointement
				;;
				2)
					searchAppointement
				;;
				3)
					allAppointement
				;;
				*)
				echo -e "${red}Invalid Option..!!${default}"
				;;
				esac
				done
			;;
			*)
				echo -e "${red}Invalid Option..!!${default}"
			;;
			esac
			done
		else
			echo -e "${red}Invalid Password !!!${default}"
			sleep 3
		fi
	;;
	2)
		rflag=0
		
			echo  ""
			echo -e "${magenta}Welcome To The Doctor's Menu..!!!${default}"
            read -p "Enter Your Name (case sensitive) : " name
            echo -e "${green}----------------------------------------${default}"
            echo -e " ${blue}Welcome Doctor :${default} $name                 "
			while [ $rflag -eq 0 ]
		do
            echo -e "${green}----------------------------------------${default}"
			echo -e "${green}|Press 1 To Get Your Patients          |${default}"
			echo -e "${green}|Press 2 To Set Patient's Status       |${default}"
			echo -e "${green}|Press 3 To Update Patient's Status    |${default}"
			echo -e "${green}|Press 4 To Check Patient's Status     |${default}"
			echo -e "${green}|Press 0 To Exit                       |${default}"
            echo -e "${green}----------------------------------------${default}"
			read temp
			case $temp in
			0)
				rflag=1
			;;
		    1)
				echo ""
				records=`cat Appointement | grep "|$name|" | cut -f 1,3 -d"|"`
				
				echo -e "${magenta}Appointments:${default}"
				for i in $records
				do
					echo "--------------------------------------------"
					dname=`echo $i | cut -f1 -d"|"`		            
		            ddate=`echo $i | cut -f2 -d"|"`
		            echo "Patient Name     : $dname"
		            echo "Appointment Date : $ddate"
				done
				echo ""
				lastid=`cat pid`
				echo -e "${blue}All Patient Details:${default}"
				for i in $(seq 1 $lastid)
				do
					if [ -s $i"detail" ]
					then
					pidtxt=`cat $i"detail" | cut -f1 -d"|" `
					pnametxt=`cat $i"detail" | cut -f2 -d"|" `
					pdatetxt=`cat $i"detail" | cut -f3 -d"|" `
					paddresstxt=`cat $i"detail" | cut -f4 -d"|" `
					ppnotxt=`cat $i"detail" | cut -f5 -d"|" `
					doctor=`cat $i"detail" | cut -f6 -d"|" `
					if [ "$doctor" = "$name" ]
					then
						echo "--------------------------------------------"
						echo "Id                  : $pidtxt"
						echo "Name                : $pnametxt"
						echo "Date                : $pdatetxt"
						echo "Address             : $paddresstxt"
						echo "Phone No            : $ppnotxt"
						#echo "Consultant Doctor   : $doctor"
					fi
					else
						echo ""
					fi
				done
				read -p "`echo -e ${yellow}`Press Any Key To Exit `echo -e ${default}`" tempo
			;;
			2)
				echo ""
				read -p "Enter Patients Name (case sensitive) : " name
				read -p "Enter Current Treatment Status : " status
				data="$name|"$status""
				echo $data >> "status"
			;;
			3)
			    echo ""
	            read -p "Enter Patients Name (case sensitive) : " name
	            if [ -s $name"status" ]
	            then
		            read -p "Enter The New Status : " status
				else
		            clear
		            echo -e "${red}Patient Not Found ...${default}"
		            sleep 3
	            fi
				data="$name|"$status""
				echo $data > "status"
			;;
			4)
				echo ""
				echo -e "${magenta}Patient's Status:${default}"
				records=`cat status`
				for i in $records
				do
					name=`echo $i | cut -f1 -d"|"`
					status=`echo $i | cut -f2 -d"|"`
					echo "$name : $status"
				done
				echo ""
				read -p "`echo -e ${yellow}`Press Any Key To Exit `echo -e ${default}`" tempo
			;;
			esac
		done
	;;
	0)
		echo ""
		echo -e "${yellow}Take Care & Good Bye...!!${default}"
		exit 1
	;;
	esac
done
