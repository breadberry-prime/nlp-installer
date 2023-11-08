#!/bin/bash

# Download the Anaconda installer
wget https://repo.anaconda.com/archive/Anaconda3-2023.09-0-Linux-x86_64.sh

# Install Anaconda silently to the specified directory without manual intervention
bash Anaconda3-2023.09-0-Linux-x86_64.sh -b -p $HOME/anaconda3

# Add Anaconda to the PATH in .profile
echo 'export PATH="$HOME/anaconda3/bin:$PATH"' >> $HOME/.profile

# Source .profile to update the PATH
source $HOME/.bashrc

conda init

# Create a new conda environment with Python 3.9
conda create -n nlpenv python=3.9 -y

# Activate the new environment
conda activate nlpenv

# Install PyTorch, torchvision, torchaudio, and cudatoolkit
conda install pytorch torchvision torchaudio cudatoolkit=11.8 -c pytorch -y

# Install other required packages using conda or pip within the environment
pip install --upgrade torch torchvision torchaudio --index-url https://download.pytorch.org/whl/cu118 --quiet
pip install --upgrade huggingface-hub transformers einops accelerate bitsandbytes flask python-dotenv --quiet

# Set LD_LIBRARY_PATH environment variable
export LD_LIBRARY_PATH=/lib/x86_64-linux-gnu:$LD_LIBRARY_PATH

# Install PyCharm Professional (This still requires sudo and is system-wide)
sudo snap install pycharm-professional --classic
