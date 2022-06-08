#!/usr/bin/env bash

# Example: go-vultr block-storage list|get
#
# ID					REGION ID	INSTANCE ID				SIZE GB		STATUS	LABEL			BLOCK TYPE	DATE CREATED			MONTHLY COST	MOUNT ID
# 12345678-90ab-cdef-1234-567890abcdef	sea		12345678-90ab-cdef-1234-567890abcdef	50		active	pvc-8c20528a369142c7	storage_opt	2022-06-08T16:21:46+00:00	$1.25		sea-57b09ea57b2145

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