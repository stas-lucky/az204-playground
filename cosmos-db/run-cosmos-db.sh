AZ_RG_NAME=az204-cosmos-db-rg
AZ_REGION=westeurope
AZ_COSMOSDB_ACCOUNT_NAME=az204-cosmos-db-$RANDOM

az group create --name $AZ_RG_NAME --location "$AZ_REGION"

# Create account
az cosmosdb create --name $AZ_COSMOSDB_ACCOUNT_NAME --resource-group $AZ_RG_NAME

# Create database
az cosmosdb sql database create \
  --account-name $AZ_COSMOSDB_ACCOUNT_NAME \
  --resource-group $AZ_RG_NAME \
  --name sampledb

# Create container (container - think as table in relational database)
az cosmosdb sql container create \
  --resource-group $AZ_RG_NAME \
  --account-name $AZ_COSMOSDB_ACCOUNT_NAME \
  --database-name sampledb \
  --name samplecontainer \
  --partition-key-path "/employeeid"