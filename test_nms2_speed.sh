
rm nms2_test.txt
echo NEW TEST >> nms2_test.txt
echo ---------------------------------------------------------------------------------------------------------------- >> nms2_test.txt
echo ---------------------------------------------------------------------------------------------------------------- >> nms2_test.txt
for i in 100 1000 10000 100000 1000000
do
	echo -------------------- 1 Milllion Requests, ACL SIZE $i -------------------- >> nms2_test.txt
	echo  IPV4 \| IPs only >> nms2_test.txt
	./nms2/nms --search=testdata/ipv4/1000000_requests.txt --file=testdata/ipv4/ipv4_${i}.txt >> nms2_test.txt
	echo  >> nms2_test.txt
	echo  IPV4 \| CIDR >> nms2_test.txt
	./nms2/nms --search=testdata/ipv4/1000000_requests.txt --file=testdata/ipv4/ipv4_${i}_cidrs.txt>> nms2_test.txt
	echo  >> nms2_test.txt
	echo  IPV6 \| IPs only >> nms2_test.txt
	./nms2/nms --search=testdata/ipv6/1000000_requests.txt --file=testdata/ipv6/ipv6_${i}.txt >> nms2_test.txt
	echo >> nms2_test.txt
	echo  IPV6 \| CIDR >> nms2_test.txt
	./nms2/nms --search=testdata/ipv6/1000000_requests.txt --file=testdata/ipv6/ipv6_${i}_cidrs.txt >> nms2_test.txt
	echo >> nms2_test.txt
	echo -------------------------------------------------------- >> nms2_test.txt
	echo checked nms2 with ACL size $i 
done
	echo done
# USE GREP TO GRAB MAX RESIDENT MEMORY AND >> INTO NMS_TEST