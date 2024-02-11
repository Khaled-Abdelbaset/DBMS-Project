#!/usr/bin/bash
LC_COLLATE=C

cd ~/Project
source validation.sh

clear
echo "*** Welcome To OS44-DBMS ***"

declare -a queries=("Creat DB" "List DB" "Connect DB" "Drop DB" "Exit")

while true; do
echo "Select A Query: "
select query in "${queries[@]}"
do
case $query in
	"Creat DB" )
		clear
		read -p "Enter Data Base name: " DBname
		if [[ -e ${DBname}_DB ]]; then
			echo "$DBname Already Exist"  
		else
			if [[ -z "$DBname" ]]; then
				echo "* Database Name Can't Be Empty"
			else
				checkName $DBname
				if [[ $? -eq 1 ]]; then
					mkdir ${DBname}_DB
					echo "Database $DBname Created Successfully"
				fi
			fi
		fi
		sleep 3
		clear
		break
	;;
	"List DB" )
		clear
		available=`ls -F ~/Project | grep "/" | grep "_DB" | wc -l`
		if [[ $available == 0 ]];then
			echo "No Available Data Bases!"
			sleep 3
		else
			echo -e "Available DataBases: \c"
			echo $available
			ls -F | grep "/" | grep "_DB"| sed 's/\/$//'
			read -p "Enter Any Key To Get Back To Menu"
		fi
		clear
		break
	;;
	"Connect DB" )
		clear
		Connect.sh
		break
	;;
	"Drop DB" )
		clear
		checkDB
		if [[ $? -eq 1 ]]; then
			read -p "=> Confirnm Dropping Data Base $DBname y/n: "
			case $REPLY in
			[Yy]* )
				rm -r $DBname
		 		echo "Database $DBname Was Dropped"	
			;;
			[Nn]* )
				echo "* Dropped was Canceled!"
			;;
			* )
				echo "Invalid Option!"
			;;
			esac
		fi
		sleep 3
		clear
		break
	;;
	"Exit" )
		clear
		echo "Exit OS-44DBMS"
		exitFunc
	;;
	* )
		echo "Invalid Option"
		sleep 3
		clear
		break
	;;
esac
done
done
