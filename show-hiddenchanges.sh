# Shows all atrributes of Terraform resources after a change to verify the correct resource is being modified before applying
terraform plan -out=tfplan > /dev/null
terraform show -json tfplan > tfplan.json
rm tfplan
resource_names=$(cat tfplan.json | jq ' .resource_changes[].address')
index=0
for resource in $resource_names
  do
    #echo "Index - Sindex"
    echo "Resource Address: $(jq --arg jq_index $index ' .resource_changes[$jq_index|tonumber].address' tfplan.json)"
    echo "Module Address: $(jq --arg jq_index $index ' .resource_changes[$jq_index|tonumber].module_address' tfplan.json)"
    echo "Resource Type: $(jq --arg jq_index $index ' .resource_changes[$jq_index|tonumber].type' tfplan.json)"
    echo "Resource Name: $(jq --arg jq_index $index ' .resource_changes[$jq_index|tonumber].name' tfplan.json)"
    echo "Provider Name: $(jq --arg jq_index $index ' .resource_changes[$jq_index|tonumber].provider_name' tfplan.json)"
    echo "Change Action: $(jq --arg jq_index $index ' .resource changes[$jq_index|tonumber].change.actions[0]' tfplan.json)"
    echo "Before Changes: $(jq --arg jq_index $index ' .resource_changes[$jq_index|tonumber].charge.before' tfplan.json)"
    echo "After Changes: $(jq --arg jq_index $index ' .resource_changes[$jq_index|tonumber].change.after' tfplan.json)" 
    echo ""
    index=$(($index + 1))
  done
