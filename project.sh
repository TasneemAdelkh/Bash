#!/bin/bash

OPTION=$(whiptail --title "Bash Project" --menu "Choose an option" 20 60 12 \
"Add User" "Add a user to the system." \
"Modify User" "Modify an existing user." \
"Delete User" "Delete an existing user." \
"List Users" "List all users on the system." \
"Add Group" "Add a user group to the system." \
"Modify Group" "Modify a group and its list of members." \
"Delete Group" "Delete an existing group" \
"List Groups" "List all groups on the system" \
"Disable User" "Lock the user account." \
"Enable User" "Unlock the user account." \
"Change Password" "Change Password of a user" \
"About" "information about this program" \
3>&1 1>&2 2>&3)

echo "You chose: $OPTION"
if [ "$OPTION" == "Add User" ]
then
	username=$(whiptail --title "Add User" --inputbox "Enter the username" 7 30 3>&1 1>&2 2>&3)
	if [ $? -eq 0 ]
	then
		id $username &> /dev/null
		if [ $? -eq 0 ]
		then
			echo $username already exists
		else
			useradd $username
			echo $username has been successfully added
		fi
	fi
elif [ "$OPTION" == "Modify User" ]
then
	username=$(whiptail --title "Modify User" --inputbox "Enter the username" 7 30 3>&1 1>&2 2>&3)
	id "$username" &> /dev/null
	if [ $? -eq 0 ]
	then
		
		Mod_OPTION=$(whiptail --title "Modify User" --menu "Choose an option" 15 60 4 \
		"Username" "Change the user's name" \
		"UID" "Change the user ID" \
		"Shell" "Change the user's shell" \
		3>&1 1>&2 2>&3)

		case "$Mod_OPTION" in
			"Username")
				Required_value=$(whiptail --title "Username" --inputbox "Enter the  new username" 7 30 3>&1 1>&2 2>&3)
				;;
			"UID")
				Required_value=$(whiptail --title "UID" --inputbox "Enter the  new UID" 7 30 3>&1 1>&2 2>&3)
				;;
			"Shell")
				Required_value=$(whiptail --title "Shell" --inputbox "Enter the  new shell" 7 30 3>&1 1>&2 2>&3)
				;;	
		esac



		if [ "$Mod_OPTION" == "Username" ]
		then
			if [ -d "/home/$username" ]; 
			then
       		 	# If it exists, change name and move the folder
        			usermod -l "$Required_value" -d "/home/$Required_value" -m "$username"
    			else
       		 	# If it doesn't exist, just change the name and update the path in /etc/passwd
               			usermod -l "$Required_value" -d "/home/$Required_value" "$username"
			fi	
		elif [ "$Mod_OPTION" == "UID" ]
		then
			usermod -u "$Required_value" "$username"
		elif [ "$Mod_OPTION" == "Shell"  ]
		then
			usermod -s "$Required_value" "$username"
		fi
	else
		echo "${username} does not exist"
	fi

elif [ "$OPTION" == "Delete User" ]
then
	username=$(whiptail --title "Delete User" --inputbox "Enter the username to be deleted" 7 30 3>&1 1>&2 2>&3)
	userdel -r "$username"

elif [ "$OPTION" == "List Users" ]
then
	awk 'BEGIN{FS=":"}{print $1 "---UID:"$3}' /etc/passwd

elif [ "$OPTION" == "Add Group" ]
then
	group=$(whiptail --title "Add Group" --inputbox "Enter the new group name" 7 30 3>&1 1>&2 2>&3)
	groupadd "$group"

elif [ "$OPTION" == "Modify Group" ]
then
	group=$(whiptail --title "Modify Group" --inputbox "Enter the group name to be modified" 7 30 3>&1 1>&2 2>&3)

	Mod_OPTION=$(whiptail --title "Modify Group" --menu "Choose an option" 15 60 4 \
        "Group Name" "Change the group's name" \
        "Members" "Set the group members" \
        "Append Members" "Append new group members" \
        3>&1 1>&2 2>&3)

	if [ "$Mod_OPTION" == "Group Name" ]
        then
		group_new=$(whiptail --title "Modify Group Name" --inputbox "Enter the new group name" 7 30 3>&1 1>&2 2>&3)
		groupmod -n "$group_new" "$group"
        elif [ "$Mod_OPTION" == "Members" ]
        then
		members=$(whiptail --title "Set group members" --inputbox "Enter the list of comma separated members \n(user1,user2,user3,...)" 9 60 3>&1 1>&2 2>&3)
		groupmod -U "$members" "$group"
        elif [ "$Mod_OPTION" == "Append Members"  ]
        then
                members=$(whiptail --title "Append group members" --inputbox "Enter the list of comma separated members to be appended \n(user1,user2,user3,...)" 9 60 3>&1 1>&2 2>&3)
                groupmod -a -U "$members" "$group"

        fi

elif [ "$OPTION" == "Delete Group" ]
then
	group=$(whiptail --title "Delete Group" --inputbox "Enter the group name to be deleted" 7 30 3>&1 1>&2 2>&3)
	groupdel "$group"

elif [ "$OPTION" == "List Groups" ]
then
	awk 'BEGIN{FS=":"}{printf "%s ", $1; printf "	GID: %s \n", $3}' /etc/group

elif [ "$OPTION" == "Disable User" ]
then
	username=$(whiptail --title "Disable User" --inputbox "Enter the username to be disabled" 7 60 3>&1 1>&2 2>&3)
	id $username &> /dev/null
        if [ $? -eq 0 ]
        then
		usermod -L "$username"
		echo "User $username has been locked."
	else
		echo "${username} does not exist"
	fi	

elif [ "$OPTION" == "Enable User" ]
then
	username=$(whiptail --title "Enable User" --inputbox "Enter the username to be enabled" 7 60 3>&1 1>&2 2>&3)
	id $username &> /dev/null
        if [ $? -eq 0 ]
        then
		usermod -U "$username"
		echo "User $username has been unlocked."
	else
		echo "${username} does not exist"
	fi

elif [ "$OPTION" == "Change Password" ]
then
	username=$(whiptail --title "Change Password" --inputbox "Enter the username whose password to be changed" 7 30 3>&1 1>&2 2>&3)
	id $username &> /dev/null
	if [ $? -eq 0 ]
        then
		new_pass=$(whiptail --title "Change Password" --passwordbox "Enter the new password" 7 30 3>&1 1>&2 2>&3)
		echo "$username:$new_pass" | chpasswd
	else
		echo "${username} does not exist"
	fi

elif [ "$OPTION" == "About" ]
then
	whiptail --title "About This Program" --msgbox "User & Group Management Toolkit\n\nVersion: 1.0\nDeveloper: Tasneem Adel Khamis\n\nThis utility helps in the centralized automation for user/group lifecycles, home directory migration, and account security." 16 60

fi
