#!/usr/bin/env bash

# Example: go-vultr block-storage list|get
#
# ID					REGION ID	INSTANCE ID				SIZE GB		STATUS	LABEL			BLOCK TYPE	DATE CREATED			MONTHLY COST	MOUNT ID
# 12345678-90ab-cdef-1234-567890abcdef	sea		12345678-90ab-cdef-1234-567890abcdef	50		active	pvc-123456789abcdef0	storage_opt	2022-01-01T00:00:00+00:00	$1.00		sea-123456789abcde

read _ # LABELS

echo "["
while read ID REGION_ID INSTANCE_ID SIZE STATUS LABEL TYPE CREATED COST MOUNT_ID
do
  echo "{
    \"id\": \"${ID}\",
    \"region\": \"${REGION}\",
    \"instance_id\": \"${INSTANCE_ID}\",
    \"size_gb\": \"${SIZE}\",
    \"status\": \"${STATUS}\",
    \"label\": \"${LABEL}\",
    \"type\": \"${TYPE}\",
    \"created\": \"${CREATED}\",
    \"cost\": \"${COST}\",
    \"mount_id\": \"${MOUNT_ID}\"
  }"
done
echo "]"