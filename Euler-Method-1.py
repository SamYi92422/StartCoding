f = 4
fd = [-5, -4.9, -4, -4.7]
h = 0.3

for i in range(0, len(fd)):
	f = f + h*fd[i]

print f