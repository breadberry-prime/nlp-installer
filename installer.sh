#!/bin/bash

# This script installs Anaconda, creates a Conda environment, and installs PyCharm Professional.
# Usage:
#   ./install_script.sh

log_file="install_script.log"

# Function to print a message with a timestamp
log_message() {
    if [ -t 1 ]; then
        echo -e "[$(date +%Y-%m-%dT%H:%M:%S%z)] $1" | tee -a "$log_file"
    else
        echo "[$(date +%Y-%m-%dT%H:%M:%S%z)] $1" | tee -a "$log_file"
    fi
}

# Function to display a message with a checkmark
print_checkmark() {
    if [ -t 1 ]; then
        log_message "\\e[32m✔\\e[0m $1"
    else
        log_message "✔ $1"
    fi
}

# Function to display an error message and exit
print_error() {
    log_message "\\e[31m✖ ERROR:\\e[0m $1" >&2
    exit 1
}

# Clean up function in case of failure
cleanup() {
    log_message "Cleaning up temporary files..."
    # Add commands to clean up any temporary files or revert changes made by the script
    log_message "Cleanup complete."
}

# Check for prerequisites before proceeding
check_prerequisites() {
    command -v wget >/dev/null 2>&1 || { echo >&2 "wget is required but it's not installed.  Aborting."; exit 1; }
    command -v snap >/dev/null 2>&1 || { echo >&2 "snap is required but it's not installed.  Aborting."; exit 1; }
}

# Trap to catch any errors and execute the cleanup function
trap cleanup ERR

# Starting installation
log_message "Starting installation process."

check_prerequisites

# Download the Anaconda installer
log_message "Downloading Anaconda installer..."
wget https://repo.anaconda.com/archive/Anaconda3-2023.09-0-Linux-x86_64.sh --quiet --show-progress >> "$log_file" 2>&1 || { print_error "Failed to download Anaconda installer."; }

# Install Anaconda silently
log_message "Installing Anaconda..."
bash Anaconda3-2023.09-0-Linux-x86_64.sh -b -p "$HOME/anaconda3" >> "$log_file" 2>&1 && print_checkmark "Anaconda installed."

# Source conda.sh and initialize Conda
if [ -f "$HOME/anaconda3/etc/profile.d/conda.sh" ]; then
    log_message "Sourcing Conda config..."
    source "$HOME/anaconda3/etc/profile.d/conda.sh" >> "$log_file" 2>&1
    print_checkmark "Conda config sourced."
    conda init bash >> "$log_file" 2>&1 && print_checkmark "Conda initialized."
else
    print_error "Conda config file not found."
fi

# Create the conda environment from the YAML file
log_message "Creating Conda environment 'nlpenv' from YAML file..."
conda env create -f environment.yml >> "$log_file" 2>&1 && print_checkmark "Conda environment 'nlpenv' created." || print_error "Failed to create conda environment 'nlpenv'."

# Final message to the user
print_checkmark "Installation successful!"
log_message "Please run 'source ~/.bashrc' to enable conda and then 'conda activate nlpenv' to activate the environment."

# Exit trap
trap - ERR

# Exit the script successfully
exit 0
