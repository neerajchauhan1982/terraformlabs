#!/bin/bash
RESOURCE_GROUP_NAME="tfbackend"
STORAGE_ACCOUNT_NAME="storage19821983"
CONTAINER_NAME="tfdev"
CONTAINER_NAME2="tfstage"
az group create --name $RESOURCE_GROUP_NAME --location centralus
az storage account create --name $STORAGE_ACCOUNT_NAME --resource-group $RESOURCE_GROUP_NAME --sku Standard_LRS --encryption-service blob
az storage container create --name $CONTAINER_NAME --account-name $STORAGE_ACCOUNT_NAME --auth-mode login
az storage container create --name $CONTAINER_NAME2 --account-name $STORAGE_ACCOUNT_NAME --auth-mode login