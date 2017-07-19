x = -2
f = -2

while x < 0:
	f_ = -0.5*x + 0.5*f
	f = f + 0.5 * f_
	x += 0.5
	print "f(%f)= "%x, f