import torch
from coloroma import Fore, Style

print("installation-check.py")
print("=" * 80)
print(Fore.GREEN + "Torch version: " + Style.RESET_ALL + torch.__version__)
print(Fore.GREEN + "CUDA available: " + Style.RESET_ALL + str(torch.cuda.is_available()))
print(Fore.GREEN + "CUDA version: " + Style.RESET_ALL + str(torch.version.cuda))
print(Fore.GREEN + "cuDNN version: " + Style.RESET_ALL + str(torch.backends.cudnn.version()))
print(Fore.GREEN + "GPU available: " + Style.RESET_ALL + str(torch.cuda.device_count()))
print(Fore.GREEN + "Current device: " + Style.RESET_ALL + str(torch.cuda.current_device()))
for i in range(torch.cuda.device_count()):
    print(Fore.GREEN + "Device {}: ".format(i) + Style.RESET_ALL + str(torch.cuda.get_device_name(i)))

print("=" * 80)