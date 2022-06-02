cd ../nms4 
./build.sh
cd -
rm Results/nms4_test.txt
echo NEW TEST >> Results/nms4_test.txt
echo ---------------------------------------------------------------------------------------------------------------- >> Results/nms4_test.txt
echo ---------------------------------------------------------------------------------------------------------------- >> Results/nms4_test.txt
for i in 100 1000 5000 10000 20000
do
	echo -------------------- 1 Milllion Requests, ACL SIZE $i -------------------- >> Results/nms4_test.txt
	echo  IPV4 \| IPs only >> Results/nms4_test.txt
	./../nms4/nms --search=testdata/ipv4/1000000_requests.txt --file=testdata/ipv4/ipv4_${i}.txt >> Results/nms4_test.txt
	echo  >> Results/nms4_test.txt
	echo  IPV4 \| CIDR >> Results/nms4_test.txt
	./../nms4/nms --search=testdata/ipv4/1000000_requests.txt --file=testdata/ipv4/ipv4_${i}_cidrs.txt>> Results/nms4_test.txt
	echo  >> Results/nms4_test.txt
	echo  IPV6 \| IPs only >> Results/nms4_test.txt
	./../nms4/nms --search=testdata/ipv6/1000000_requests.txt --file=testdata/ipv6/ipv6_${i}.txt >> Results/nms4_test.txt
	echo >> Results/nms4_test.txt
	echo  IPV6 \| CIDR >> Results/nms4_test.txt
	./../nms4/nms --search=testdata/ipv6/1000000_requests.txt --file=testdata/ipv6/ipv6_${i}_cidrs.txt >> Results/nms4_test.txt
	echo >> Results/nms4_test.txt
	echo -------------------------------------------------------- >> Results/nms4_test.txt
	echo checked nms4 with ACL size $i 
done
	echo done
# USE GREP TO GRAB MAX RESIDENT MEMORY AND >> INTO NMS_TEST