#!/bin/bash

# Function to display a message with a checkmark
print_checkmark() {
  echo -e "\\e[32m✔\\e[0m $1"
}

# Function to display an error message
print_error() {
  echo -e "\\e[31m✖ ERROR:\\e[0m $1" 1>&2
}

# Download the Anaconda installer
wget https://repo.anaconda.com/archive/Anaconda3-2023.09-0-Linux-x86_64.sh --quiet --show-progress > /dev/null 2>&1 || { print_error "Failed to download Anaconda installer."; exit 1; }

# Install Anaconda silently to the specified directory without manual intervention
bash Anaconda3-2023.09-0-Linux-x86_64.sh -b -p "$HOME/anaconda3" > /dev/null 2>&1 && print_checkmark "Anaconda installed."

# Check if the conda.sh script exists and source it
if [ -f "$HOME/anaconda3/etc/profile.d/conda.sh" ]; then
    source "$HOME/anaconda3/etc/profile.d/conda.sh" > /dev/null 2>&1
    print_checkmark "Conda config sourced."
else
    print_error "Conda config file not found."
    exit 1
fi

# Initialize Conda for future shell sessions
conda init bash >> install.log 2>&1 && print_checkmark "Conda initialized."

# Create the conda environment from the YAML file
conda env create -f environment.yml > /dev/null 2>&1 && print_checkmark "Conda environment 'nlpenv' created." || print_error "Failed to create conda environment 'nlpenv'."

# Install PyCharm Professional (This still requires sudo and is system-wide)
sudo snap install pycharm-professional --classic > /dev/null 2>&1 && print_checkmark "PyCharm Professional installed." || print_error "Failed to install PyCharm Professional."

echo -e "\e[32mInstallation successful!\e[0m Please run 'source ~/.bashrc' to enable conda and then 'conda activate nlpenv' to activate the environment."
