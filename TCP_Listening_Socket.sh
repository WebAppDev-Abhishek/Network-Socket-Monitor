#!/bin/bash

# Define temporary files to store socket states
# In Git Bash, /tmp/ usually maps to a user-specific temporary directory
# like C:\Users\<YourUser>\AppData\Local\Temp or C:\tmp
PREV_SOCKETS_FILE="/tmp/netstat_prev_sockets_win.txt"
CURRENT_SOCKETS_FILE="/tmp/netstat_current_sockets_win.txt"

echo "--- Netstat Socket Monitor (Git Bash for Windows) ---"
echo "This script compares current socket states with the previous run."
echo ""

# --- 1. Display All Active TCP/UDP Sockets ---
# Using 'netstat -an' for Windows compatible output.
# 'awk 'NR>2 {print}'' skips the first two header lines of netstat output
# and prints the entire remaining line.
echo "--- All Active TCP/UDP Sockets ---"
netstat -an | awk 'NR>2 {print}'
echo ""

# --- 2. Display Established TCP Connections ---
# Use grep to filter for ESTABLISHED connections from TCP lines.
# The 'netstat -an' output on Windows will have "TCP" and "ESTABLISHED" in it.
echo "--- Established TCP Connections ---"
netstat -an | grep "TCP" | grep "ESTABLISHED"
echo ""

# --- Prepare Current Socket State for Comparison ---
# For identifying new/old sockets, we'll focus on the unique connection tuple:
# Protocol, Local Address, and Foreign Address. This is robust as UDP connections
# don't have a 'State' in Windows netstat output.
# 'awk 'NR>2 {print $1, $2, $3}'': Extracts Proto, Local Address, Foreign Address.
# 'sort -u': Sorts the output and removes duplicate lines for consistent comparison.
netstat -an | awk 'NR>2 {print $1, $2, $3}' | sort -u > "$CURRENT_SOCKETS_FILE"

# --- 3. Identify New and Old Sockets ---
# Check if the previous state file exists. This file is created after the first run.
if [ -f "$PREV_SOCKETS_FILE" ]; then
    echo "--- New Sockets (appeared since last run - Proto, Local, Foreign) ---"
    # 'comm -13': Shows lines unique to FILE2 (current state)
    comm -13 "$PREV_SOCKETS_FILE" "$CURRENT_SOCKETS_FILE"
    echo ""

    echo "--- Old Sockets (closed since last run - Proto, Local, Foreign) ---"
    # 'comm -23': Shows lines unique to FILE1 (previous state)
    comm -23 "$PREV_SOCKETS_FILE" "$CURRENT_SOCKETS_FILE"
    echo ""
else
    echo "No previous socket state found. Run this script again to see 'new' and 'old' sockets."
    echo "The current state has been saved for future comparisons."
    echo ""
fi

# --- 4. Update Previous Socket State ---
# Move the current socket state file to become the previous state file for the next run.
mv "$CURRENT_SOCKETS_FILE" "$PREV_SOCKETS_FILE"

echo "Current socket state saved to '$PREV_SOCKETS_FILE' for the next comparison."
echo "--- Script Finished ---"

echo "--- Script Finished ---"
read -p "Press Enter to exit..."