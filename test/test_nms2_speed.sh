cd ../nms2 
./build.sh
cd -
rm Results/nms2_test.txt
echo NEW TEST >> Results/nms2_test.txt
echo ---------------------------------------------------------------------------------------------------------------- >> Results/nms2_test.txt
echo ---------------------------------------------------------------------------------------------------------------- >> Results/nms2_test.txt
for i in 100 1000 5000 10000 20000
do
	echo -------------------- 1 Milllion Requests, ACL SIZE $i -------------------- >> Results/nms2_test.txt
	echo  IPV4 \| IPs only >> Results/nms2_test.txt
	./../nms2/nms --search=testdata/ipv4/1000000_requests.txt --file=testdata/ipv4/ipv4_${i}.txt >> Results/nms2_test.txt
	echo  >> Results/nms2_test.txt
	echo  IPV4 \| CIDR >> Results/nms2_test.txt
	./../nms2/nms --search=testdata/ipv4/1000000_requests.txt --file=testdata/ipv4/ipv4_${i}_cidrs.txt>> Results/nms2_test.txt
	echo  >> Results/nms2_test.txt
	echo  IPV6 \| IPs only >> Results/nms2_test.txt
	./../nms2/nms --search=testdata/ipv6/1000000_requests.txt --file=testdata/ipv6/ipv6_${i}.txt >> Results/nms2_test.txt
	echo >> Results/nms2_test.txt
	echo  IPV6 \| CIDR >> Results/nms2_test.txt
	./../nms2/nms --search=testdata/ipv6/1000000_requests.txt --file=testdata/ipv6/ipv6_${i}_cidrs.txt >> Results/nms2_test.txt
	echo >> Results/nms2_test.txt
	echo -------------------------------------------------------- >> Results/nms2_test.txt
	echo checked nms2 with ACL size $i 
done
	echo done
# USE GREP TO GRAB MAX RESIDENT MEMORY AND >> INTO NMS_TEST