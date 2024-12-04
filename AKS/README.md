----------------------------------------------------------------------------------------------------
			Deploy AKS Cluster using Terraform
----------------------------------------------------------------------------------------------------

*Step 1: Authenticate Your Azure Account
Log in to your Azure account using the Azure CLI:

az login

*Step 2: Create a Service Principal for Terraform

Set up a service principal to grant Terraform secure access to Azure resources:

az ad sp create-for-rbac --name 'sp-terraform' --role="Contributor" --scopes="/subscriptions/<SUBSCRIPTION_ID>"

*Step 3: Deploy AKS Cluster Using Terraform

Create and edit the main.tf file:

vi main.tf

Initialize Terraform:

terraform init

Generate and review the execution plan:

terraform plan

Apply the configuration:

terraform apply

az aks get-credentials --resource-group helloworld-aks-rg --name helloworld-aks-cluster

Verify the cluster nodes:

kubectl get nodes


-----------------------------------------------------------------------------------------------------------
			Deploy hello world Application on AKS using Helm Charts
------------------------------------------------------------------------------------------------------------

Step 1: Install Helm (if not already installed)

Install Helm:

curl -O https://get.helm.sh/helm-v3.16.2-linux-amd64.tar.gz
tar xvf helm-v3.16.2-linux-amd64.tar.gz
sudo mv linux-amd64/helm /usr/local/bin
rm helm-v3.16.2-linux-amd64.tar.gz


Verify Helm installation:

helm version


Step 2: Initialize Your Helm Chart

cd helm-chart/

Perform a dry run to validate the Helm templates:

helm install hello-world . --dry-run --debug

Deploy the Helm chart:

helm install hello-world .

Confirm the deployment:

kubectl get all











