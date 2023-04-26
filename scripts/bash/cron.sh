#!/bin/bash
set -x

# Define the command to be executed in the cron job
command="ls -alh /Users/holyswagger > /Users/holyswagger/cron.txt"

# Define the schedule for the cron job (runs every day at 3:30 AM)
schedule="23 * * * *"

# Use crontab to add the cron job
(
  crontab -l 2>/dev/null
  echo "$schedule $command"
) | crontab -

# Print a message indicating success
echo "Cron job added successfully"
