AZ_RG_NAME=az204-vm-with-cli-rg
AZ_REGION=westeurope
VM_NAME=az204-vm


az group create --name $AZ_RG_NAME --location $AZ_REGION

# cd ~/.ssh
# ssh-keygen -m PEM -t rsa -b 2048 -f az204

az vm create \
  --resource-group "$AZ_RG_NAME" \
  --location $AZ_REGION \
  --size "Standard_B1ls" \
  --name "$VM_NAME" \
  --image "Ubuntu2204" \
  --admin-username azureuser \
  --authentication-type "ssh" \
  --public-ip-sku Basic \
  --ssh-key-values ~/.ssh/az204.pub
  
az vm open-port \
  --resource-group "$AZ_RG_NAME" \
  --name "$VM_NAME" \
  --port 22
  
VM_IP=$(az vm list-ip-addresses \
  --resource-group "$AZ_RG_NAME" \
  --name "$VM_NAME" \
  --output json \
  --query "[0].virtualMachine.network.publicIpAddresses[0].ipAddress" \
  | sed 's/"//g')

echo "IP addr: $VM_IP"

ssh azureuser@$VM_IP -i ~/.ssh/az204

# az group delete --name "$AZ_RG"