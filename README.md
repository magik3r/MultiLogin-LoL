# MultiLogin for LoL
A light AutoHotKey script for quickly logging with multiple accounts

**Function:**  
You choose an account from the list in the gui -> click login and let the script do the rest  
The script uses the details you have provided in the "users.txt" file  
*The LoL client can be running already but does not have to be, the script will detect it by itself and launch the application if necessary.*  

**Usage:**  
AutoHotKey is required to be installed to run this script. 
[AutoHotKey Website](https://www.autohotkey.com/)

To add accounts you can either:  
- Add each account you want to use through the GUI in the script  
**OR**  
- by adding them manually in the "users.txt" file  

**Template for the users.txt file**  
usrname: "username"  
usrpass: "password"  
alias: "display-name in gui"  
(Blank line before repeating)  

**Example:**  
usrname: apple1  
usrpass: apple2  
alias: apple3  

usrname: orange1  
usrpass: orange2  
alias: orange3  
