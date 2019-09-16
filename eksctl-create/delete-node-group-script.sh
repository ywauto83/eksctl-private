# delete nodegroup
eksctl delete nodegroup --cluster=my-eks-cluster-02  --name=ng-1-workersnode-private --region ap-southeast-2

# drain nodegroup
eksctl drain nodegroup  --cluster=my-eks-cluster-02  --name=ng-1-workersnode-private