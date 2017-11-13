import sys
res = ''
for (i, c) in enumerate(" ".join(sys.argv[1:])):
    for (x, y) in [('>', 'r'), ('<', 'l'), ('+', 'p'), ('-', 'm'), ('.', 'o')]:
        if x == c:
            res += y
print(res)