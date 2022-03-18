import re
f = input("Enter file name")
f = f+".txt"
f = open(f, 'r')
result = 0
for x in f:
    y = re.findall("[0-9]+", x)     # finds all number in a line or return a list of numbers
    if len(y) < 1:
        continue
    else:
        for z in y:
            print(z)
            result += int(z)
print(result)