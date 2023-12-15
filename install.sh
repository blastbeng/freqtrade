#!/bin/bash
export TMP_DIR=/home/blast/tmp

# Prepare environment
sudo apt-get update \
  && sudo apt-get -y install sudo libatlas3-base curl sqlite3 libhdf5-serial-dev libgomp1 build-essential libssl-dev git libffi-dev libgfortran5 pkg-config cmake gcc python3 python3-pip\
  && sudo apt-get clean

# Install TA-lib
cd /build_helpers && sudo ./install_ta-lib.sh

cd ..

curl --proto '=https' --tlsv1.3 https://sh.rustup.rs -sSf >> rustup-install.sh
chmod +x rustup-install.sh
./rustup-install.sh -y

export PATH="$HOME/.cargo/bin:$PATH"

python3 -m venv .venv
source .venv/bin/activate

# Install dependencies
pip3 install --upgrade wheel setuptools
pip3 install --no-cache-dir polars 
pip3 install --no-cache-dir numpy
pip3 install --no-cache-dir -r requirements-hyperopt.txt

pip3 install -e . --no-cache-dir --no-build-isolation
mkdir /freqtrade/user_data/
pip3 freqtrade install-ui


pip3 install -r requirements-freqai.txt --no-cache-dir

requirements-freqai-rl.txt /freqtrade/

pip3 install -r requirements-freqai-rl.txt --no-cache-dir

pip3 install tensorflow PyWavelets torch darts multiprocess finta tqdm keras --no-cache-dir

