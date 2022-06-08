# Ip tree testing
Utilities to compare memory and search metrics of ModSecurity msc_tree and Waflz IP trie

### Steps

### Generate ipv4 and ipv6 address using random_ip_generator.py.

```bash
./random_ip_generator.py --ipv4 --num=100000 --file=test/testdata/ipv4_100000.txt
```

### Build msc tree

```bash
cd modsec_iptree
./build.sh
```

### Build nms (waflz ip trie)

```bash
cd waflz_iptree
./build.sh
```

### Steps to gather memory metrics - Linux
	
```bash
/usr/bin/time -v ./msc --file=../test/testdata/ipv4/ipaddr_1000_shuffled.txt --type=ipv4
```

```bash
/usr/bin/time -v ./nms --file=../test/testdata/ipv4/ipaddr_1000_shuffled.txt
```

Maximum resident memory is the memory used by the tree


### Steps to gather search metrics

```bash
./msc --file=../test/testdata/ipv4/ipv4_20000.txt --type=ipv4 --search=../test/testdata/ipv4/1000000_requests.txt
```

```bash
./nms --file=../test/testdata/ipv4/ipv4_20000.txt --search=../test/testdata/ipv4/1000000_requests.txt
```

Output will print out the search time in seconds. You can also run a test script 

```bash
cd test
./test_msc_speed.sh
```

### Note
testdata folder has lot of samples of ipv4 and ipv6 address to perform load and search. Results of Speed metrics are written to test/Results.


Sample load and search metrics are here: https://verizondigital.github.io/waflz/appendix.html#ip-trie-performance

