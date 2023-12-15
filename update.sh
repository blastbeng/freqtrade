#!/bin/bash
#sudo systemctl stop docker-compose@freqtrade
/usr/bin/git pull
/usr/bin/gh repo sync https://github.com/freqtrade/freqtrade -b develop
cd ./phils_strategies
/usr/bin/git pull
cd ..

docker compose build

#sudo systemctl start docker-compose@freqtrade
