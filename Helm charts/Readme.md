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
