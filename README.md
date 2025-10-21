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
