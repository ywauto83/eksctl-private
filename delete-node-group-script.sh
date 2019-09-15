# delete nodegroup
eksctl delete nodegroup --cluster=my-eks-cluster-02  --name=ng-1-workersnode-private

# drain nodegroup
eksctl drain nodegroup  --cluster=my-eks-cluster-02  --name=ng-1-workersnode-private