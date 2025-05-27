# **Netstat Socket Monitor (Git Bash for Windows)**

This script monitors and compares active network sockets on a Windows system using `netstat`. It identifies:
- **All active TCP/UDP sockets**
- **Established TCP connections**
- **New sockets** (connections that appeared since the last run)
- **Old sockets** (connections that were closed since the last run)

The script is designed specifically for **Git Bash** on Windows and uses temporary files to store socket states for comparison.

---

## **Features**
- **Socket Monitoring**: Displays all active TCP/UDP sockets.
- **Connection Filtering**: Highlights only `ESTABLISHED` TCP connections.
- **State Comparison**: Identifies new and closed connections compared to the previous run.
- **Automation**: Automatically saves the current state for future comparisons.

---

## **How It Works**
1. **Socket Snapshot**: The script runs `netstat -an` and extracts the `Proto`, `Local Address`, and `Foreign Address` of active connections.
2. **State Comparison**: Compares the current snapshot with the previous run to find:
   - New sockets: Connections that appeared since the last run.
   - Old sockets: Connections that were closed since the last run.
3. **File Management**: The current state is saved in `/tmp/netstat_prev_sockets_win.txt` for the next comparison.

---

## **Requirements**
- **Git Bash** on Windows
- `awk`, `grep`, `sort`, `mv`, and `comm` commands (available by default in Git Bash)

---
