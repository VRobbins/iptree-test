#!/bin/bash

rm svn_data_nms.txt
rm svn_data_nms3
cd ../waflz_iptree 
./build.sh
cd -
cd ../nms3
./build.sh
cd -
nms_time=0.0
nms3_time=0.0
ctr=0
for file in /Users/vrobbins/Desktop/svn/waf/conf/acl/*
do
	cat $file | grep -oE '[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}/[0-9]{1,2}' > svn_data_nms.txt
	cat $file | grep -oE '[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\"' | sed 's/.$//' >> svn_data_nms.txt
	cat $file | grep -oE '[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}/[0-9]{1,2}' > svn_data_nms3.txt
	cat $file | grep -oE '[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\"' | sed 's/.$//' >> svn_data_nms3.txt
	nms_add=$(./../waflz_iptree/nms --search=testdata/ipv4/ipv4_20000.txt --file=svn_data_nms.txt | grep -oE '[0-9]\.[0-9][0-9][0-9][0-9][0-9][0-9]')
	nms3_add=$(./../nms3/nms --search=testdata/ipv4/ipv4_20000.txt --file=svn_data_nms3.txt | grep -oE '[0-9]\.[0-9][0-9][0-9][0-9][0-9][0-9]')
	nms_time=$(echo "$nms_time + $nms_add" | bc)
	nms3_time=$(echo "$nms3_time + $nms3_add" | bc)
	ctr=$((ctr+1))
	echo file $ctr checked!
done
echo --------------------DONE--------------------
echo waflz took $nms_time seconds
echo nms3 took $nms3_time seconds