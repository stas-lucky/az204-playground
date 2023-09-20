AZ_RG=az204-vm-rg

az group create --name $AZ_RG --location westeurope

# cd ~/.ssh
# ssh-keygen -m PEM -t rsa -b 2048 -f az204

az vm create \
  --resource-group "$AZ_RG" \
  --location westeurope \
  --size "Standard_B1ls" \
  --name "az204-vm" \
  --image "Ubuntu2204" \
  --admin-username stas \
  --authentication-type "ssh" \
  --public-ip-sku Basic \
  --ssh-key-values ~/.ssh/az204.pub
  
az vm open-port \
  --resource-group "$AZ_RG" \
  --name "az204-vm" \
  --port 22
  
VM_IP=$(az vm list-ip-addresses \
  --resource-group "$AZ_RG" \
  --name "az204-vm" \
  --output json \
  --query "[0].virtualMachine.network.publicIpAddresses[0].ipAddress" \
  | sed 's/"//g')
  
ssh stas@$VM_IP -i ~/.ssh/az204

az group delete --name "$AZ_RG"