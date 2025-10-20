project - Batch 2

# System Monitor Project

## Overview
This project automates system monitoring by collecting key metrics such as:
- CPU Usage  
- Memory Usage  
- Disk Usage  
- System Uptime  
- Load Average  

## Script
The script `collect_metrics.sh` runs every 15 minutes and saves reports to `reports/metrics_<timestamp>.txt`.

## Archiving
Every 24 hours, all reports are compressed into a tarball:
`archive/metrics_<date>.tar.gz`

## Cron Jobs
To schedule the tasks:
```bash
*/15 * * * * /home/ec2-user/QA_assignment/system_monitor_project/scripts/collect_metrics.sh

