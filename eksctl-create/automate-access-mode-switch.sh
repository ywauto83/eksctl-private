#!/bin/bash
name=my-eks-cluster-02
dst=ACTIVE
period=120
while [ $(aws eks describe-cluster --name ${name} | jq '.cluster.status') != "\"${dst}\"" ]
do
    
    echo $(aws eks describe-cluster --name ${name} | jq '.cluster.status')
    
    echo polling eks cluster creation status every ${period}....
    sleep $period
done

if [ $(aws eks describe-cluster --name ${name} | jq '.cluster.status') == "\"${dst}\"" ]
then
    echo ${name} is ${dst} and enable Private Access Mode now ..
    aws eks update-cluster-config \
	    --name ${name} \
	    --resources-vpc-config endpointPublicAccess=false,endpointPrivateAccess=true;
fi

while [ $(aws eks describe-cluster --name ${name} | jq '.cluster.resourcesVpcConfig.endpointPrivateAccess') != true ]
do

    echo $(aws eks describe-cluster --name ${name} | jq '.cluster.resourcesVpcConfig.endpointPrivateAccess')

    echo polling eks cluster access mode  status every ${period}....
    sleep $period
done

echo "allow kubectl to reach private master nodes"
sg=$(aws eks describe-cluster --name my-eks-cluster-02 | jq -r '.cluster.resourcesVpcConfig.securityGroupIds[]')

aws ec2 authorize-security-group-ingress \ 
	--group-id ${sg} \
	--protocol tcp \
	--port 443 \
	--source-group sg-0aa4c9fe6d2a0e096
echo "SG updated"

