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
bash Anaconda3-2023.09-0-Linux-x86_64.sh -b -p "$HOME/anaconda3" && print_checkmark "Anaconda installed."

# Check if the conda.sh script exists and source it
if [ -f "$HOME/anaconda3/etc/profile.d/conda.sh" ]; then
    source "$HOME/anaconda3/etc/profile.d/conda.sh"
    print_checkmark "Conda config sourced."
else
    print_error "Conda config file not found."
    exit 1
fi

# Initialize Conda for future shell sessions
conda init bash >> install.log 2>&1 && print_checkmark "Conda initialized."

# Source .bashrc to reflect changes (might not work as expected in a script)
source ~/.bashrc || print_error "Could not source .bashrc file."

# Create the conda environment from the YAML file
conda env create -f environment.yml >> install.log 2>&1 && print_checkmark "Environment 'nlpenv' created from template."

# Activate the new environment
conda activate nlpenv || { print_error "Failed to activate environment 'nlpenv'."; exit 1; }

# Install PyCharm Professional (This still requires sudo and is system-wide)
if sudo snap install pycharm-professional --classic; then
  print_checkmark "PyCharm Professional installed."
else
  print_error "Failed to install PyCharm Professional."
fi
