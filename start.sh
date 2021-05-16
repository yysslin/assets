#!/bin/bash
cd /home/ec2-user/chia-blockchain/
. ./activate
chia start farmer
instanceid=$(curl -s 169.254.169.254/1.0/meta-data/instance-id)
echo "plot" >> $instanceid.log
echo $(date) >> $instanceid.log
chia plots create -k 32 -r 2 -n 1 -t /mnt/tmp -d /chia -f 86e2861729d0c80cdbbf534b887a5f12cd71db41666f0be077743f8b06edd3f09acc8eacfbb20cd1977777a5ca7bd4c2 -p 9657d073106e7d07ffef12f1922f361a8c8bb52630e674363039ec8bf5fafa7d2580b8c3379e87548bcc1f88d28b9c27echo "plot completed" >> $instanceid.log
echo $(ll /chia/) >> $instanceid.log
echo "copy" >> $instanceid.log
aws s3 cp /chia/* s3://chplotdata
echo "copy completed" >> $instanceid.log
aws s3 cp $instanceid.log s3://chiaplotlogs
sudo shutdown now