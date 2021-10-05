#!/bin/bash

# cortesgr
# 7/27/2021

# Instance Launcher

check_status(){
  local status="${1}"
  if [[ ${status} -eq 0 ]]; then
    echo "LAUNCH: OK"
  else
    echo "LAUNCH: FAILED"
  fi    
}

launch_instances(){
  local -ri count="${1}"
  output=$( aws ec2 run-instances --image-id ami-0dc2d3e4c0f9ebd18 --count ${count} --instance-type t2.micro --key-name KP2)
 
  instances=($(echo ${output} | jq -r '.Instances[] | .InstanceId'))
#  for instance in "${instances[@]}"; do
#    echo "DEBUG: ${instance}"
#    jq -r '.Instances[] | .LaunchTime'
#    launchtime=$(echo ${output} | jq '.Instances[].LaunchTime | select(.InstanceId==${instance})')
#    echo "${instance} ${launchtime}"
#  done 

  #launchtime=$(echo ${output} | jq -r '.Instances[] | .LaunchTime')
 
  local status=$?
  check_status "${status}"
  printf "${count} instances have been launched!\n"

  #echo "output:"
  echo "${output}" > /tmp/output

  #echo "Instance ID: ${instance} "
  #echo "Launch Time: ${launchtime}"
  
}

main(){
  launch_instances "$@"
} 

main "$@"
