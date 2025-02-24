cd ../modsec_iptree 
./build.sh
cd -
rm Results/msc_test.txt
echo NEW TEST >> Results/msc_test.txt
echo ---------------------------------------------------------------------------------------------------------------- >> Results/msc_test.txt
echo ---------------------------------------------------------------------------------------------------------------- >> Results/msc_test.txt
for i in 100 1000 5000 10000 20000
do
	echo -------------------- 1 Milllion Requests, ACL SIZE $i -------------------- >> Results/msc_test.txt
	echo  IPV4 \| IPs only >> Results/msc_test.txt
	./../modsec_iptree/msc --type=ipv4 --search=testdata/ipv4/1000000_requests.txt --file=testdata/ipv4/ipv4_${i}.txt >> Results/msc_test.txt
	echo  >> Results/msc_test.txt
	echo  IPV4 \| CIDR >> Results/msc_test.txt
	./../modsec_iptree/msc --type=ipv4 --search=testdata/ipv4/1000000_requests.txt --file=testdata/ipv4/ipv4_${i}_cidrs.txt>> Results/msc_test.txt
	echo  >> Results/msc_test.txt
	echo  IPV6 \| IPs only >> Results/msc_test.txt
	./../modsec_iptree/msc --type=ipv6 --search=testdata/ipv6/1000000_requests.txt --file=testdata/ipv6/ipv6_${i}.txt >> Results/msc_test.txt
	echo >> Results/msc_test.txt
	echo  IPV6 \| CIDR >> Results/msc_test.txt
	./../modsec_iptree/msc --type=ipv6 --search=testdata/ipv6/1000000_requests.txt --file=testdata/ipv6/ipv6_${i}_cidrs.txt >> Results/msc_test.txt
	echo >> Results/msc_test.txt
	echo -------------------------------------------------------- >> Results/msc_test.txt
	echo checked msc with ACL size $i 
done
	echo done
# USE GREP TO GRAB MAX RESIDENT MEMORY AND >> INTO NMS_TEST