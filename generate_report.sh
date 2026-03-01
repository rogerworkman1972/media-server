#!/bin/bash
OUTPUT_FILE="claude.md"

echo "Gathering system information... Please wait."

# 1. Header & System Info
echo "# Server System & ZFS Report" > $OUTPUT_FILE
echo "**Generated on:** $(date)" >> $OUTPUT_FILE
echo "" >> $OUTPUT_FILE

echo "## 1. System Information" >> $OUTPUT_FILE
echo "\`\`\`text" >> $OUTPUT_FILE
echo "Hostname: $(hostname)" >> $OUTPUT_FILE
if [ -f /etc/os-release ]; then
    cat /etc/os-release | grep PRETTY_NAME | cut -d= -f2 | tr -d '\"' >> $OUTPUT_FILE
fi
echo "Kernel: $(uname -r)" >> $OUTPUT_FILE
echo "Uptime & Load:" >> $OUTPUT_FILE
uptime >> $OUTPUT_FILE
echo "\`\`\`" >> $OUTPUT_FILE
echo "" >> $OUTPUT_FILE

# 2. Hardware Resources (CPU & RAM)
echo "## 2. Hardware Resources" >> $OUTPUT_FILE
echo "### Memory (RAM)" >> $OUTPUT_FILE
echo "\`\`\`text" >> $OUTPUT_FILE
free -h >> $OUTPUT_FILE
echo "\`\`\`" >> $OUTPUT_FILE

echo "### CPU Summary" >> $OUTPUT_FILE
echo "\`\`\`text" >> $OUTPUT_FILE
lscpu | egrep -i 'Model name|Socket|Thread|NUMA|CPU\(s\)' >> $OUTPUT_FILE
echo "\`\`\`" >> $OUTPUT_FILE
echo "" >> $OUTPUT_FILE

# 3. Storage Devices
echo "## 3. Storage & Block Devices" >> $OUTPUT_FILE
echo "\`\`\`text" >> $OUTPUT_FILE
lsblk -e 7 -e 11 >> $OUTPUT_FILE # Excludes loop devices (like snaps) and CD-ROMs
echo "\`\`\`" >> $OUTPUT_FILE
echo "" >> $OUTPUT_FILE

# 4. ZFS Pool Status
echo "## 4. ZFS Pool Status" >> $OUTPUT_FILE
echo "\`\`\`text" >> $OUTPUT_FILE
zpool status >> $OUTPUT_FILE
echo "" >> $OUTPUT_FILE
zpool list >> $OUTPUT_FILE
echo "\`\`\`" >> $OUTPUT_FILE
echo "" >> $OUTPUT_FILE

# 5. ZFS Datasets
echo "## 5. ZFS Datasets" >> $OUTPUT_FILE
echo "\`\`\`text" >> $OUTPUT_FILE
zfs list >> $OUTPUT_FILE
echo "\`\`\`" >> $OUTPUT_FILE
echo "" >> $OUTPUT_FILE

# 6. Top-Level ZFS Properties
echo "## 6. Top-Level ZFS Properties" >> $OUTPUT_FILE
echo "*Note: Only showing root datasets for brevity.*" >> $OUTPUT_FILE
echo "\`\`\`text" >> $OUTPUT_FILE
zpool list -H -o name | xargs -I {} zfs get all {} >> $OUTPUT_FILE
echo "\`\`\`" >> $OUTPUT_FILE
echo "" >> $OUTPUT_FILE

echo "Report successfully saved to $OUTPUT_FILE."
