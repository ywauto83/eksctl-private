aws cloudformation create-stack \
	--stack-name node-group-1 \
	--template-body file://amazon-eks-nodegroup.yaml \
	--parameters file://node-group-config.json \
	--capabilities CAPABILITY_NAMED_IAM \
	--region ap-southeast-2
