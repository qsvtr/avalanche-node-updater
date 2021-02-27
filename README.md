```
                      _                  _              _   _           _          _    _           _       _             
       /\            | |                | |            | \ | |         | |        | |  | |         | |     | |            
      /  \__   ____ _| | __ _ _ __   ___| |__   ___    |  \| | ___   __| | ___    | |  | |_ __   __| | __ _| |_ ___ _ __  
     / /\ \ \ / / _` | |/ _` | '_ \ / __| '_ \ / _ \   | . ` |/ _ \ / _` |/ _ \   | |  | | '_ \ / _` |/ _` | __/ _ \ '__| 
    / ____ \ V / (_| | | (_| | | | | (__| | | |  __/   | |\  | (_) | (_| |  __/   | |__| | |_) | (_| | (_| | ||  __/ |    
   /_/    \_\_/ \__,_|_|\__,_|_| |_|\___|_| |_|\___|   |_| \_|\___/ \__,_|\___|    \____/| .__/ \__,_|\__,_|\__\___|_|    
                                                                                         | |                              
                                                                                         |_|                              
```

run it in one command **IF** you already have a service called *avalanchenode*: ```wget -qO - https://raw.githubusercontent.com/qsvtr/avalanche-node-updater/master/updateAvalancheNode.sh | bash```

# Configuration:
  * create a system file **ONLY IF** you didn't get one
    + ```sudo cp .avalanchenode.service.example /etc/systemd/system/avalanchenode.service```
    + ```sudo vi /etc/systemd/system/avalanchenode.service```
    + lines 6 and 7: change *avalanche-user* with your username (```whoami```)
    + line 10 (ExecStart): change *VPS_IP* with your public IP (```hostname -I | awk '{print $1}'```)
    + ```sudo systemctl enable avalanchenode```
    + ```sudo systemctl start avalanchenode```
    + check if service is running: ```sudo systemctl status avalanchenode``` - you should have active status
  * modify the value **avalanche_service** in the script file with yours (leave default if you followed this tutorial)

# Run
  *  ```chmod +x updateAvalancheNode.sh```
  *  ```./updateAvalancheNode.sh```
