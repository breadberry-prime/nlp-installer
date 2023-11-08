#!/bin/bash

# Function to display a progress bar
show_progress() {
  echo -ne '#####                     (33%)\r'
  sleep 1
  echo -ne '#############             (66%)\r'
  sleep 1
  echo -ne '#######################   (100%)\r'
  echo -ne '\n'
}

# Function to display a message with a checkmark
print_checkmark() {
  echo -e "\\e[32m✔\\e[0m $1"
}

# Function to display an error message
print_error() {
  echo -e "\\e[31m✖ ERROR:\\e[0m $1" 1>&2
}

# Download the Anaconda installer
wget https://repo.anaconda.com/archive/Anaconda3-2023.09-0-Linux-x86_64.sh --quiet --show-progress || { print_error "Failed to download Anaconda installer."; exit 1; }

# Install Anaconda silently to the specified directory without manual intervention
bash Anaconda3-2023.09-0-Linux-x86_64.sh -b >> install.log 2>&1 && print_checkmark "Anaconda installed."

source $HOME/anaconda3/etc/profile.d/conda.sh
conda init bash >> install.log 2>&1 || { print_error "Conda init failed."; exit 1; }

# Create a new conda environment with Python 3.9
conda create -n nlpenv python=3.9 -y >> install.log 2>&1 && print_checkmark "Environment 'nlpenv' created."

# Activate the new environment
conda activate nlpenv

# Install PyTorch and related packages
conda install pytorch torchvision torchaudio cudatoolkit=11.8 -c pytorch -y >> install.log 2>&1 && print_checkmark "PyTorch installed."

# Install other required packages using conda or pip within the environment
pip install --upgrade torch torchvision torchaudio --index-url https://download.pytorch.org/whl/cu118 --quiet
pip install --upgrade huggingface-hub transformers einops accelerate bitsandbytes flask python-dotenv --quiet && print_checkmark "Additional packages installed."

# Set LD_LIBRARY_PATH environment variable
export LD_LIBRARY_PATH=/lib/x86_64-linux-gnu:$LD_LIBRARY_PATH

# Install PyCharm Professional (This still requires sudo and is system-wide)
if sudo snap install pycharm-professional --classic; then
  print_checkmark "PyCharm Professional installed."
else
  print_error "Failed to install PyCharm Professional."
fi
