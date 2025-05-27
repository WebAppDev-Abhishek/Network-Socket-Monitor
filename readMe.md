         .------------------.
                                    (     I N T E R N E T    )
                                     `------------------'
                                             |
                                             |  (Gateway Connection)
                                             |
                                    +----------------+
                                    |    ROUTER_01   |  <-- Main Internet Gateway
                                    +----------------+
                                    /       |        \
                                   /        |         \
                                  /         |          \
                               SERVER_WEB  PC_01     PC_02
                                   |         |          |
                                   |         |          |
                                   +---------+----------+
                                   |    SWITCH_A      |
                                   +------------------+
                                     \     / \     /
                                      \   /   \   /
                                     PC_03   PC_04


       +-----------------+                      +-----------------+
       |    ROUTER_02    |----------------------|    ROUTER_03    |
       +-----------------+                      +-----------------+
       /       |         \                      /       |         \
      /        |          \                    /        |          \
   PC_05     PC_06     SERVER_DB            PC_07     PC_08     SERVER_APP
     |         |          |                    |         |          |
     +---------+----------+                    +---------+----------+
     |    SWITCH_B      |                    |    SWITCH_C      |
     +------------------+                    +------------------+
          /   \                                  /   \
         /     \                                /     \
      PC_09   PC_10                          PC_11   PC_12


Network Socket Monitor: A netstat Utility for Linux and Windows (Git Bash)
Overview
This repository presents a pair of lightweight, yet powerful, shell scripts designed to monitor network connections on your system. Leveraging the netstat utility, these scripts go beyond simply listing active sockets; they intelligently track changes over time to identify newly established connections and recently closed connections. Whether you're on a native Linux environment or using Git Bash on Windows, these tools provide valuable insights into your system's network activity, aiding in troubleshooting, security auditing, and understanding application behavior.
Core Functionality
Both the Linux and Windows (Git Bash) versions of the script provide the following key features:
Active Socket Display: Lists all currently active TCP and UDP network connections, showing protocol, local address, foreign address, and connection state (where applicable).
New Socket Detection: Identifies and displays connections that have appeared since the last time the script was executed. This is crucial for pinpointing recent network events.
Old Socket Identification: Shows connections that were active during the previous run but are no longer present, indicating recently closed or terminated connections.
The scripts achieve this state-tracking by saving the current list of active connections to a temporary file. On subsequent runs, this saved "previous state" is compared with the "current state" to determine what has changed.
Technologies Used
These scripts are built using standard command-line utilities commonly available in Unix-like environments:
bash (or sh): The scripting language driving the logic.
netstat: The primary network utility for inspecting active connections.
awk: Used for parsing and formatting netstat output to extract relevant fields.
grep: Utilized for filtering output, especially for specific connection states like ESTABLISHED.
comm: A powerful command-line utility used for comparing two sorted files line by line, essential for identifying new and old connections.
Project 1: Linux Version (netstat_monitor.sh)
This script is tailored for standard Linux distributions. It utilizes netstat -tun for a comprehensive view of TCP and UDP connections. The awk parsing is specifically designed to work with the typical column structure of netstat on Linux.
Usage:
Save the script as netstat_monitor.sh.
Make it executable: chmod +x netstat_monitor.sh
Run it from your terminal: ./netstat_monitor.sh (Note: For the first run, it will not show "new" or "old" sockets as there's no previous state. Run it again to see these sections.)
Project 2: Windows Git Bash Version (netstat_monitor_win.sh)
Recognizing the widespread use of Git Bash for a Unix-like experience on Windows, this version has been specifically adapted. The primary difference lies in the netstat command's behavior on Windows. This script uses netstat -an which provides a similar dataset but with different column arrangements. The awk and grep commands have been adjusted to correctly parse Windows netstat output, ensuring accurate tracking of connection changes. For comparison, it intelligently tracks Protocol, Local Address, and Foreign Address to ensure robust detection across both TCP and UDP connections, regardless of state presence.
Usage:
Save the script as netstat_monitor_win.sh.
Make it executable in Git Bash: chmod +x netstat_monitor_win.sh
Crucially, run it from an already open Git Bash terminal: ./netstat_monitor_win.sh (Avoid double-clicking the script directly from File Explorer, as the terminal window might close immediately after execution.)
Why Use These Scripts?
Network Troubleshooting: Quickly identify misbehaving applications or unexpected connections.
Security Auditing: Monitor for unauthorized or suspicious outbound/inbound connections.
Application Analysis: Understand how your applications are communicating on the network in real-time.
Simplicity: A quick and easy way to get detailed network connection insights without complex tools.

