# docker-mysql-mha-multi-host
MHA Containerized Solution    
For your conviences all image blow have been upload to DockerHub!   
Image Intergrate  
- Mysql 5.7.17    
- mha4mysql-node-0.58     
- mha4mysql-manager-0.58      

# Usage
1. Start up 
``` shell
docker-compose up -d master
docker-compose up -d slave_1
docker-compose up -d manager
```
2. Generate ssh key
```shell
docker-compose exec master /mha-share/ssh-init.sh
docker-compose exec slave_1 /mha-share/ssh-init.sh
docker-compose exec manager /mha-share/ssh-init.sh
```
3. Synchronize ssh key each node
```shell
docker-compose exec master /mha-share/ssh-pass.sh slave-ip
docker-compose exec slave_1 /mha-share/ssh-pass.sh master-ip
docker-compose exec manager /mha-share/ssh-pass.sh master-ip
docker-compose exec manager /mha-share/ssh-pass.sh slave-ip
```
4.  Some stuff
```shell
#create replication account
docker-compose exec master /mha-bin/create-repl-account.sh
#set slave nodes
docker-compose exec slave_1 /mha-bin/change-master.sh
#initializing MHA cluster
docker-compose exec manager /mha-bin/bootstrap.sh
```
