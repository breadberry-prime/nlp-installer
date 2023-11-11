# NLP Workbench

This repository hosts a streamlined setup for Anaconda and PyCharm, tailored for rapid deployment on cloud GPU clusters. The aim is to enable immediate development in a robust environment.

## Installation Script Overview

The provided script automates the installation of Anaconda and PyCharm Professional, ensuring a ready-to-code setup. Key steps include:

1. **Anaconda Installation**: The script downloads and installs the latest Anaconda distribution (Anaconda3-2023.09-0).
2. **Conda Environment Setup**: It then creates a Conda environment named 'nlpenv' based on a predefined YAML file.
3. **PyCharm Professional Installation**: PyCharm Professional is installed using Snap for an integrated development environment.

The script employs logging and error handling to ensure smooth installation. For full usage, refer to the script comments.

## Installation-Check Script

The `installation-check.py` script is a quick diagnostic tool that checks the following:

- PyTorch version
- CUDA availability and version
- cuDNN version
- Number of GPUs available and their details

This script helps verify if the environment is correctly set up for GPU-based development.

## Repository Purpose

Currently, this repository is a foundational step towards supporting various fine-tuning tasks in NLP. It's kept public for easier cloning and sharing - yes, a bit of convenience on my part. Hopefully, it serves as a helpful resource for your projects too.
