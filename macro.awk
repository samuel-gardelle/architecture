#!/usr/bin/awk -f

/^shift [[:graph:]]+ [[:digit:]] into [[:graph:]]+/ {
	print "move "$2" shift"
	for (i = 2; i <= $3; i++)
		print "move shift shift"
	print "move shift "$5
	next
}

/^shift [[:graph:]]+ [[:digit:]]$/ {
	print "move "$2" shift"
	for (i = 2; i <= $3; i++)
		print "move shift shift"
	print "move shift "$2
	next
}

/^[[:graph:]]+ \+ [01]{8}$/ {
	print "move "$1" add_a"
	print "write "$3
	print "move r3 add_b"
	next
}

/^[[:graph:]]+ \+ [[:graph:]]+$/ {
	print "move "$1" add_a"
	print "move "$3" add_b"
	next
}

/^[[:graph:]]+ \+ [01]{8} -> [[:graph:]]+$/ {
	print "move "$1" add_a"
	print "write "$3
	print "move r3 add_b"
	print "move add "$5
	next
}

/^[[:graph:]]+ \+ [[:graph:]]+ -> [[:graph:]]+$/ {
	print "move "$1" add_a"
	print "move "$3" add_b"
	print "move add "$5
	next
}

/^if [[:graph:]]+ is null jump [01]{10}$/ {
	print "move "$2" ==0"
	print "if jump "$6
	next
}

/^if [[:graph:]]+ is positive jump [01]{10}$/ {
	print "move "$2" >=0"
	print "if jump "$6
	next
}

/^basic [[:graph:]]+ \* [[:digit:]]+$/ {
	print "move "$2" add_a"
	print "move "$2" add_b"
	for (i = 2; i < $4; i++)
		print "move add add_a"
	next
}

/^basic [[:graph:]]+ \* [[:digit:]]+ -> [[:graph:]]+$/ {
	print "move "$2" add_a"
	print "move "$2" add_b"
	for (i = 2; i < $4; i++)
		print "move add add_a"
	print "move add "$6
	next
}

{ print }
