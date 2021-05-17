#!/usr/bin/awk -f

function as_hex(str) {

	if (str == "0000") {
		return "0"
	} else if (str == "0001") {
		return "1"
	} else if (str == "0010") {
		return "2"
	} else if (str == "0011") {
		return "3"
	} else if (str == "0100") {
		return "4"
	} else if (str == "0101") {
		return "5"
	} else if (str == "0110") {
		return "6"
	} else if (str == "0111") {
		return "7"
	} else if (str == "1000") {
		return "8"
	} else if (str == "1001") {
		return "9"
	} else if (str == "1010") {
		return "A"
	} else if (str == "1011") {
		return "B"
	} else if (str == "1100") {
		return "C"
	} else if (str == "1101") {
		return "D"
	} else if (str == "1110") {
		return "E"
	} else if (str == "1111") {
		return "F"
	} else {
		print "Unable to transform binary sequence: "str" (at line "NR")."
		exit 1
	}
}

BEGIN {
	print "v2.0 raw\n411"
	ORS=" "

	# Source addresses
	source["add"] = "0"
	source["r1"] = "1"
	source["r2"] = "2"
	source["r3"] = "3"
	source["shift"] = "4"
	source["ram_addr"] = "5"
	source["ram_out"] = "6"

	# Target addresses
	target["==0"] = "0"
	target["r1"] = "1"
	target["r2"] = "2"
	target["r3"] = "3"
	target["shift"] = "4"
	target["ram_addr"] = "5"
	target["ram_in"] = "6"
	target["add_a"] = "7"
	target["add_b"] = "8"
	target[">=0"] = "9"
}

function resolve_source(name) {
	if (name in source) {
		return source[name]
	} else {
		print "Unable to resolve source address "name" at line "NR"."
		exit 1
	}	
}

function resolve_target(name) {
	if (name in target) {
		return target[name]
	} else {
		print "Unable to resolve target address "name" at line "NR"."
		exit 1
	}	
}

/#.*/ { next }
/^$/ { next }

/^write [01]{8}$/ {
	print "0"as_hex(substr($2, 1, 4))""as_hex(substr($2, 5, 4))
	next
}

/^move [[:graph:]]+ [[:graph:]]+$/ {
	print "4"resolve_source($2)""resolve_target($3)
	next
}

/^jump [01]{10}$/ {
	print as_hex("10"substr($2, 1, 2))""as_hex(substr($2, 3, 4))""as_hex(substr($2, 7, 4))
	next
}

/^if jump [01]{10}$/ {
	print as_hex("11"substr($3, 1, 2))""as_hex(substr($3, 3, 4))""as_hex(substr($3, 7, 4))
	next
}

{
	print "Unable to transpile line "NR": "$0
	exit 1
}

END {
	print "\n"
}
