#!/bin/bash
#sudo systemctl stop docker-compose@freqtrade

cd ./phils_strategies
/usr/bin/git pull
cd ..

docker compose build

#sudo systemctl start docker-compose@freqtrade
