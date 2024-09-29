# Payload Generator

This Bash script is designed to automate the process of creating a Trojan payload using the Metasploit framework. The script checks for the installation of Metasploit tools (msfconsole and msfvenom), creates a payload based on user input, and provides some visual feedback during execution.

## Features:

* Automated Payload Creation: The script automates the process of creating a Trojan payload using Metasploit.
* User Input: The script prompts the user to select the operating system (Android or Windows) and enter the local IP address and port number.
* Visual Feedback: The script provides visual feedback during execution, including a progress bar and success messages.
* Error Handling: The script includes error handling to ensure that the user inputs are valid and that the payload is created successfully.
## Instructions for Use:

#### Clone the Repository:
```bash
https://github.com/DaddyUchiha/PayloadGenerator
```

#### Make the Script Executable:
```bash
cd PayloadGenerator
chmod +x payload.sh
```
#### Run the Script:
```bash
./payload.sh
```
#### Follow the Prompts: Follow the prompts to select the operating system, enter the local IP address and port number, and create the payload.
