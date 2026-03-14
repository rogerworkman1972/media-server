#!/usr/bin/env bash

# Your Discord Webhook URL
WEBHOOK_URL="https://discordapp.com/api/webhooks/1480604457762029638/5GO_G0Idm0WGpAmL35cvYjMEDEfDAI-Dx0AFxQM20oJVya9PLDjEDsl1WQPWwhD1ij8T"

# Run Syncoid and log the output
/usr/sbin/syncoid -r --no-sync-snap media-tank backup-tank/media-mirror >> /var/log/media-backup/syncoid.log 2>&1

# Check the exit status of the Syncoid command
if [ $? -ne 0 ]; then
  # If the exit status is NOT 0 (meaning it failed), send a Discord alert
  JSON_PAYLOAD='{"content": "🚨 **URGENT:** Syncoid replication to `backup-tank` FAILED! Please check `/var/log/media-backup/syncoid.log` for details."}'
  
  curl -H "Content-Type: application/json" -d "$JSON_PAYLOAD" $WEBHOOK_URL
fi
