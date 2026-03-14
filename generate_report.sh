#!/usr/bin/env bash
set -euo pipefail

HOSTNAME=$(hostname)
DATE=$(date '+%Y-%m-%d')
OUTPUT_FILE="system_report_${HOSTNAME}_${DATE}.md"

echo "Gathering comprehensive system information... Please wait."

# Extract OS Name cleanly by sourcing the release file
OS_NAME="Unknown Linux"
if [[ -f /etc/os-release ]]; then
    # shellcheck disable=SC1091
    source /etc/os-release
    OS_NAME="${PRETTY_NAME:-$OS_NAME}"
fi

# Use a grouping block to write to the file ONCE, keeping the script clean
{
    echo "# Server System & ZFS Report"
    echo "**Generated on:** $(date)"
    echo ""
    
    echo "## 1. System Information"
    echo '```text'
    echo "Hostname: $HOSTNAME"
    echo "OS: $OS_NAME"
    echo "Kernel: $(uname -r)"
    echo "Uptime & Load:"
    uptime
    echo '```'
    echo ""
    
    echo "## 2. Hardware Resources (CPU & RAM)"
    echo "### Memory (RAM)"
    echo '```text'
    free -h
    echo '```'
    
    echo "### CPU Summary"
    echo '```text'
    lscpu | grep -Ei 'model name|socket|thread|numa|cpu\(s\)' || true
    echo '```'
    echo ""

    echo "## 3. NUMA Topology & Statistics"
    echo '```text'
    if command -v numactl >/dev/null 2>&1; then
        echo "--- NUMA Hardware ---"
        numactl --hardware || echo "Requires root or unsupported."
        echo ""
        echo "--- NUMA Statistics ---"
        numastat || echo "Requires root or unsupported."
    else
        echo "numactl/numastat not found. Install 'numactl' package for details."
    fi
    echo '```'
    echo ""
    
    echo "## 4. Storage, Block, & PCI Devices"
    echo "### Block Devices"
    echo '```text'
    lsblk -e 7 -e 11 -o NAME,SIZE,FSTYPE,TYPE,MOUNTPOINT
    echo '```'
    
    echo "### Critical PCI Devices (Storage & Network)"
    echo '```text'
    if command -v lspci >/dev/null 2>&1; then
        lspci | grep -Ei 'network|ethernet|storage|raid|sata|sas|nvme' || true
    else
        echo "lspci command not found. Install 'pciutils'."
    fi
    echo '```'
    echo ""
    
    echo "## 5. ZFS Pool Status"
    echo '```text'
    zpool status || echo "No ZFS pools found or requires root."
    echo ""
    zpool list || echo ""
    echo '```'
    echo ""
    
    echo "## 6. ZFS Datasets & Top-Level Properties"
    echo '```text'
    zfs list || echo "No ZFS datasets found or requires root."
    echo ""
    echo "--- Top-Level Properties ---"
    zpool list -H -o name | xargs -I {} zfs get all {} || true
    echo '```'
    echo ""

    echo "## 7. ZFS ARC & Performance"
    echo '```text'
    if command -v arcstat >/dev/null 2>&1; then
        echo "--- ARC Statistics ---"
        arcstat 1 1 || true
    else
        echo "arcstat command not found."
    fi
    echo ""
    echo "--- ZPool I/O Stats ---"
    zpool iostat -v || true
    echo '```'
    echo ""

    echo "## 8. Network Interfaces & Routing"
    echo '```text'
    echo "--- Interfaces ---"
    ip -br a || true
    echo ""
    echo "--- Routes ---"
    ip route || true
    echo '```'
    echo ""

    echo "## 9. Docker Status & Containers"
    echo '```text'
    if command -v docker >/dev/null 2>&1; then
        echo "--- Docker Storage Usage ---"
        docker system df || echo "Requires root or Docker daemon is not running."
        echo ""
        echo "--- Running & Stopped Containers ---"
        docker ps -a --format "table {{.Names}}\t{{.Image}}\t{{.Status}}\t{{.Ports}}" || echo "Requires root or Docker daemon is not running."
    else
        echo "Docker command not found."
    fi
    echo '```'
    echo ""

    echo "## 10. Recent Kernel Warnings/Errors"
    echo '```text'
    dmesg -T --level=err,warn | tail -n 20 || echo "No recent errors, or requires root/sudo to view dmesg."
    echo '```'
    echo ""
    
} > "$OUTPUT_FILE"

echo "✅ Comprehensive report successfully saved to $OUTPUT_FILE."
