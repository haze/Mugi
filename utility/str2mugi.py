import sys
print(''.join(map(lambda x: ('p' * ord(x)) + 'or', ' '.join(sys.argv[1:]))))