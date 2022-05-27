
rm nms_test.txt
echo NEW TEST >> nms_test.txt
echo ---------------------------------------------------------------------------------------------------------------- >> nms_test.txt
echo ---------------------------------------------------------------------------------------------------------------- >> nms_test.txt
for i in 100 1000 10000 100000 1000000
do
	echo -------------------- 1 Milllion Requests, ACL SIZE $i -------------------- >> nms_test.txt
	echo  IPV4 \| IPs only >> nms_test.txt
	./waflz_iptree/nms --search=testdata/ipv4/1000000_requests.txt --file=testdata/ipv4/ipv4_${i}.txt >> nms_test.txt
	echo  >> nms_test.txt
	echo  IPV4 \| CIDR >> nms_test.txt
	./waflz_iptree/nms --search=testdata/ipv4/1000000_requests.txt --file=testdata/ipv4/ipv4_${i}_cidrs.txt>> nms_test.txt
	echo  >> nms_test.txt
	echo  IPV6 \| IPs only >> nms_test.txt
	./waflz_iptree/nms --search=testdata/ipv6/1000000_requests.txt --file=testdata/ipv6/ipv6_${i}.txt >> nms_test.txt
	echo >> nms_test.txt
	echo  IPV6 \| CIDR >> nms_test.txt
	./waflz_iptree/nms --search=testdata/ipv6/1000000_requests.txt --file=testdata/ipv6/ipv6_${i}_cidrs.txt >> nms_test.txt
	echo >> nms_test.txt
	echo -------------------------------------------------------- >> nms_test.txt
done
