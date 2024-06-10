#!/bin/bash
set -x

echo "jenkins secret:  $JENKINS_SECRET"
echo "jekins tunnel: $JENKINS_TUNNEL"
echo "jenkins agent name: $JENKINS_AGENT_NAME"
echo "jenkins agent: $JENKINS_NAME"
echo "jekins agent workdir: $JENKINS_AGENT_WORKDIR"
echo "jenkins url: $JENKINS_URL"


#sleep 240

# Set the maximum number of attempts
max_attempts=30

# Set a counter for the number of attempts
attempt_num=1

# Set a flag to indicate whether the command was successful
success=false

# Wait time
wait=10

# Loop until the command is successful or the maximum number of attempts is reached
while [ $success = false ] && [ $attempt_num -le $max_attempts ]; do
  # Execute the command
  virtctl ssh --local-ssh-opts="-o StrictHostKeyChecking=no" administrator@$JENKINS_AGENT_NAME.jwesterl --identity-file ~/.ssh/win_rsa -c "dir c:\jenkins"

  # Check the exit code of the command
  if [ $? -eq 0 ]; then
    # The command was successful
    success=true
  else
    # The command was not successful
    echo "Attempt $attempt_num failed. Trying again..."
    # Increment the attempt counter
    sleep $wait
    attempt_num=$(( attempt_num + 1 ))
  fi
done

# Check if the command was successful
if [ $success = true ]; then
  # The command was successful
  echo "The command was successful after $attempt_num attempts."
else
  # The command was not successful
  echo "The command failed after $max_attempts attempts."
fi

#virtctl ssh --local-ssh-opts="-o StrictHostKeyChecking=no" administrator@$JENKINS_AGENT_NAME.jwesterl --identity-file ~/.ssh/win_rsa -c "curl $JENKINS_URL/jnlpJars/agent.jar -o c:\jenkins\agent.jar"

#virtctl ssh --local-ssh-opts="-o StrictHostKeyChecking=no" administrator@$JENKINS_AGENT_NAME.jwesterl --identity-file ~/.ssh/win_rsa -c "java -jar c:\jenkins\agent.jar -jnlpUrl $JENKINS_URL/computer/$JENKINS_AGENT_NAME/jenkins-agent.jnlp -secret $JENKINS_SECRET -workDir "c:\jenkins" -noCertificateCheck"


#sleep 10

#oc delete vm $JENKINS_AGENT_NAME
