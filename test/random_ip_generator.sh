
rm testdata/ipv6/*

for i in 100 1000 5000 10000 20000
do
	python3 random_ip_generator.py --ipv6 --cidr --file=testdata/ipv6/ipv6_${i}_cidrs.txt --num=${i}
	python3 random_ip_generator.py --ipv6 --file=testdata/ipv6/ipv6_${i}.txt --num=${i}
done
rm testdata/ipv4/*
for i in 100 1000 5000 10000 20000
do
	python3 random_ip_generator.py --ipv4 --cidr --file=testdata/ipv4/ipv4_${i}_cidrs.txt --num=${i}
	python3 random_ip_generator.py --ipv4 --file=testdata/ipv4/ipv4_${i}.txt --num=${i}
done
python3 random_ip_generator.py --ipv4 --file=testdata/ipv4/1000000_requests.txt --num=1000000
python3 random_ip_generator.py --ipv6 --file=testdata/ipv6/1000000_requests.txt --num=1000000
