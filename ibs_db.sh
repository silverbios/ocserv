#!/bin/bash
sudo docker volume create IBSng
sudo docker volume create logs
sudo docker volume create httpd
sudo docker volume create pgsql
sudo docker build -t ibs:1.24 .
sudo docker run --name ibsng -dit --restart unless-stopped -v httpd:/etc/httpd:rw -v IBSng:/usr/local/IBSng:rw -v logs:/var/log:rw ibs:1.24
sudo docker pull postgres
sudo docker run --name ibs_db -dit --restart unless-stopped -v pgsql:/var/lib/postgresql/data -e POSTGRES_PASSWORD=gfys -d postgres
sleep 15
#sudo sed  -i '94i host IBSng ibs 172.17.0.2/32 trust' /var/lib/docker/volumes/pgsql/_data/pg_hba.conf
sudo docker restart ibs_db