#!/bin/bash

echo "jenkins secret:  $JENKINS_SECRET"
echo "jekins tunnel: $JENKINS_TUNNEL"
echo "jenkins agent name: $JENKINS_AGENT_NAME"
echo "jenkins agent: $JENKINS_NAME"
echo "jekins agent workdir: $JENKINS_AGENT_WORKDIR"
echo "jenkins url: $JENKINS_URL"

virtctl create vm --volume-clone-pvc=src:jwesterl/win2022-tmpl-dv --name $JENKINS_AGENT_NAME  --preference=virtualmachinepreference/windows.2k22j.virtio --instancetype u1.medium > /tmp/vm.yaml
oc apply -f /tmp/vm.yaml

sleep 5

echo "Waiting for Virtual Machine status to become Ready"
oc wait --for=condition=Ready vm/$JENKINS_AGENT_NAME
sleep 5

echo "Waiting for Virtual Machine Instance to get an IP"
oc wait --for=jsonpath='{.status.interfaces[0].ipAddress}' vmi/$JENKINS_AGENT_NAME

exit 0
