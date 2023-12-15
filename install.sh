#!/bin/bash

# Prepare environment
sudo apt-get update \
  && sudo apt-get -y install sudo libatlas3-base curl sqlite3 libhdf5-serial-dev libgomp1 build-essential libssl-dev git libffi-dev libgfortran5 pkg-config cmake gcc python3 python3-pip\
  && sudo apt-get clean

# Install TA-lib
cp build_helpers/* /tmp/
cd /tmp && /tmp/install_ta-lib.sh && rm -r /tmp/*ta-lib*

# Install dependencies
pip install --upgrade pip wheel
curl --proto '=https' --tlsv1.3 https://sh.rustup.rs -sSf >> rustup-install.sh
chmod +x rustup-install.sh
./rustup-install.sh -y
. "$HOME/.cargo/env"
pip install --user --no-cache-dir polars 
pip install --user --no-cache-dir numpy
pip install --user --no-cache-dir -r requirements-hyperopt.txt

pip install -e . --user --no-cache-dir --no-build-isolation \
  && mkdir /freqtrade/user_data/ \
  && freqtrade install-ui


pip install -r requirements-freqai.txt --user --no-cache-dir

requirements-freqai-rl.txt /freqtrade/

pip install -r requirements-freqai-rl.txt --user --no-cache-dir

pip install tensorflow PyWavelets torch darts multiprocess finta tqdm keras --user --no-cache-dir

