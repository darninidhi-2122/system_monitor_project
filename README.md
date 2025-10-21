<<<<<<< HEAD
project - Batch 2

# System Monitor Project

## Overview
This project automates system monitoring by collecting and archiving of system performance metrics.

## features
- CPU Usage  
- Memory Usage  
- Disk Usage  
- System Uptime  
- Load Average  
- Collects CPU, Memory, Disk, Uptime, and Load Average.
- Saves metrics every 15 minutes into the `reports/` directory.
- Automatically compresses all daily reports into `archive/` at midnight.

## Cron Jobs
To schedule the tasks:
- **Every 15 mins:** Runs `collect_metrics.sh` to record metrics.
- **Every 24 hours (midnight):** Archives all reports into `archive/metrics_<date>.tar.gz`.

## Git
- Only `scripts/`, `.gitignore`, and `README.md` are tracked in Git.
- `reports/` and `archive/` are excluded via `.gitignore`.

## step by step procedure

## step 1: Folder structure:
- make sure your structure looks like this:
system_monitor_project/
├── scripts/
│   └── collect_metrics.sh
├── reports/
├── archive/
├── .gitignore
└── README.md

## step 2: create a collect_metrics.sh script
create this file under system_monitor_project/scripts/collect_metrics.sh

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

## make it executable
- chmod +x scripts/collect_metrics.sh

## step 3:  schedule with cron (to run every 15 minutes)
- crontab -e (to edit the cron jobs)
- */15 * * * * /bin/bash /home/ec2-user/QA_assignment/system_monitor_project/scripts/collect_metrics.sh
0

## step 4:Compress Reports Daily (every 24 hours)
Add this cron job (also in crontab -e):

- 0 0 * * * tar -czf /home/ec2-user/QA_assignment/system_monitor_project/archive/metrics_$(date +\%Y\%m\%d).tar.gz -C /home/ec2-user/QA_assignment/system_monitor_project/reports . && rm -f /home/ec2-user/QA_assignment/system_monitor_project/reports/*

## step 5: .gitignore file
- Create .gitignore in the system_monitor_projects directory:
- add this inside the file
  # Ignore generated data
    archive/
    reports/

  # Ignore system files
    *.log
    *.tar.gz

## step 6: Initialize Git & Push

-cd system_monitor_project
git init
git add scripts/ .gitignore README.md
git commit -m "Add system metrics collection script and setup"
git branch -M main
git remote add origin https://github.com/darninidhi-2122/system_monitor_project.git
git push -u origin main

## step 7: add detailed discription in README.md file

