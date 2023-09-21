# From Azure Portal search for "Create from custom template"

AZ_RG_NAME=az204-vm-with-arm-rg
AZ_REGION=westeurope
VM_NAME=az204-vm

# Set adminPublicKey in parameters.json. Should start from "ssh-rsa ..."

az group create --name $AZ_RG_NAME --location "$AZ_REGION"

az deployment group create \
  --name my-vm-deployment \
  --resource-group $AZ_RG_NAME \
  --template-file ./template.json \
  --parameters ./parameters.json
  
VM_IP=$(az vm list-ip-addresses \
  --resource-group "$AZ_RG_NAME" \
  --name "$VM_NAME" \
  --output json \
  --query "[0].virtualMachine.network.publicIpAddresses[0].ipAddress" \
  | sed 's/"//g')

echo "IP addr: $VM_IP"
ssh azureuser@$VM_IP -i ~/.ssh/az204

# az group delete --name "$AZ_RG"