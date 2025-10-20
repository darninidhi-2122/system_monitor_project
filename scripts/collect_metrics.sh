#!/bin/bash

BASE_DIR="/home/ec2-user/QA_assignment/system_monitor_project"
REPORT_DIR="$BASE_DIR/reports"
ARCHIVE_DIR="$BASE_DIR/archive"

mkdir -p "$REPORT_DIR" "$ARCHIVE_DIR"

TIMESTAMP=$(date +"%Y%m%d_%H%M")
DATE=$(date +"%Y%m%d")

OUTPUT_FILE="$REPORT_DIR/metrics_${TIMESTAMP}.txt"

{
echo "=== system metrics report ==="
echo "date & time: $(date)"
echo
echo "CPU usage:"
top -bn1 | grep "Cpu(s)" | awk '{print 100 - $8 "% used"}'
echo 
echo "Memory usage:"
free -h | awk '/Mem/{print $3 " used / " $2 " total (" $3/$2*100 "% )"}'
echo
echo "Disk usage:"
df -h --total | grep total | awk '{print $3 " used / " $2 " total (" $5 " used)"}'
echo
echo "system uptime:"
uptime -p
echo
echo "load average:"
uptime | awk -F'load average:' '{print $2}'
} > "$OUTPUT_FILE"

if [ "$(date +%H%M)" == "0000" ]; then
    tar -czf "$ARCHIVE_DIR/metrics_${DATE}.tar.gz" -C "$REPORT_DIR" .
    rm -f "$REPORT_DIR"/*.txt
fi 
