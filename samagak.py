import sys
import re
from difflib import ndiff

class bcolors:
    BOLD = '\033[1m'
    UNDERLINE = '\033[4m'
    ENDC = '\033[0m'
# ----- color 
    DEFAULT = '\033[39m'
    BLACK = '\033[30m'
    RED = '\033[31m'
    GREEN = '\033[32m'
    YELLOW = '\033[33m'
    BLUE = '\033[34m'
    MAGENTA = '\033[35m'
    CYAN = '\033[36m'
    LIGHT_GRAY = '\033[37m'
    DARK_GRAY = '\033[90m'
    LIGHT_RED = '\033[91m'
    LIGHT_GREEN = '\033[92m'
    LIGHT_YELLOW = '\033[93m'
    LIGHT_BLUE = '\033[94m'
    LIGHT_MAGENTA = '\033[95m'
    LIGHT_CYAN = '\033[96m'
    WHITE = '\033[97m'

file1 = sys.argv[1]
file2 = sys.argv[2]

print("comparing "+file1+" and "+file2)

with open(file1, 'r') as f:
    teks1 = f.read()
f.closed
with open(file2, 'r') as f:
    teks2 = f.read()
f.closed

diff = ndiff(teks1.splitlines(1),teks2.splitlines(1))
hasilPerbandingan = ''.join(diff)
for line in hasilPerbandingan.split("\n"):

    if line[0] == '+':
        print(bcolors.LIGHT_GREEN+line+bcolors.ENDC);
    elif line[0] == '-':
        print(bcolors.LIGHT_GRAY+line+bcolors.ENDC);
    else:
        print line


