print "--------------------------------------------------"
print "This program computes the approximation of E^x using linear approximation method."

x = float(raw_input("Input x: "))
a = int(raw_input("Input the accuracy of this approximation (interger between 0 ~ 7): "))

print "Calculating..."

d = 1
a = 10**a

for i in range(0,a):
	d *= 1 + (x/a)

print "E^%d = "%x, d