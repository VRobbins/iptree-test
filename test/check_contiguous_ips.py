#! /usr/bin/env python3

import argparse
import socket
import struct
import ipaddress

def main():
	l_arg_parser = argparse.ArgumentParser(
                description='ip contiguity counter',
                usage='%(prog)s',
                epilog='')
	l_arg_parser.add_argument('-file',
							  '--file',
							  dest ='file',
							  help = 'sorted file to check',
							  default = None,
							  required = True)
	l_args = l_arg_parser.parse_args()

	file_stream = open(l_args.file, 'r')
	count = 0
	contiguity_ctr=0
	temp=0
	while True:
		line = file_stream.readline();
		if not line:
			break
		slash_index = line.index('/') if '/' in line else -1
		if slash_index>0 and line[slash_index:]!="/32":
			continue
		if slash_index>0:
			line = line[:slash_index]
		ip = struct.unpack("!L", socket.inet_aton(line))[0]
		if ip==temp+1:
			contiguity_ctr += 1
			print(line)
		temp = ip

	
	print(contiguity_ctr)

if __name__ == "__main__":
    main()