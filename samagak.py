import sys
from difflib import ndiff

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
print(''.join(diff));

