#!/usr/bin/env bash
# ==============================================================================
# zfs-snapshot-cleanup.sh — Destroy manual (non-Sanoid) ZFS snapshots
#
# BEFORE RUNNING:
#   1. Confirm Syncoid ran successfully today (check /var/log/media-backup/syncoid.log)
#   2. Review the pre-lidarr-removal snapshots in STAGE 3 — only destroy if
#      you're confident Lidarr removal is stable and you won't need to roll back
#   3. Run with DRY_RUN=true first to preview what will be destroyed
#
# USAGE:
#   DRY_RUN=true  bash zfs-snapshot-cleanup.sh   # preview only — no changes
#   DRY_RUN=false bash zfs-snapshot-cleanup.sh   # live run — destroys snapshots
# ==============================================================================

set -euo pipefail

DRY_RUN="${DRY_RUN:-true}"

destroy() {
    local snap="$1"
    if [[ "$DRY_RUN" == "true" ]]; then
        echo "[DRY RUN] zfs destroy $snap"
    else
        echo "Destroying: $snap"
        zfs destroy "$snap"
    fi
}

if [[ "$DRY_RUN" == "true" ]]; then
    echo "============================================"
    echo " DRY RUN MODE — no changes will be made"
    echo " Set DRY_RUN=false to perform actual cleanup"
    echo "============================================"
    echo ""
fi

# ==============================================================================
# STAGE 1 — Zero-byte early bootstrap snapshots (base, pre-start-*, backup-
#            dated) — all 0B, completely safe, no meaningful rollback value
# ==============================================================================
echo "--- Stage 1: Zero-byte bootstrap snapshots ---"

STAGE1=(
    "backup-tank/media-mirror/mysql@base"
    "backup-tank/media-mirror/mysql@pre-start-1772139901"
    "backup-tank/media-mirror/mysql@pre-start-1772140239"
    "backup-tank/media-mirror/mysql@pre-start-1772140756"
    "backup-tank/media-mirror/mysql@pre-start-1772140917"
    "backup-tank/media-mirror/postgres@base"
    "backup-tank/media-mirror/postgres@pre-start-1772139901"
    "backup-tank/media-mirror/postgres@pre-start-1772140239"
    "backup-tank/media-mirror/postgres@pre-start-1772140756"
    "backup-tank/media-mirror/postgres@pre-start-1772140917"
    "media-tank/mysql@base"
    "media-tank/mysql@pre-start-1772139901"
    "media-tank/mysql@pre-start-1772140239"
    "media-tank/mysql@pre-start-1772140756"
    "media-tank/mysql@pre-start-1772140917"
    "media-tank/postgres@base"
    "media-tank/postgres@pre-start-1772139901"
    "media-tank/postgres@pre-start-1772140239"
    "media-tank/postgres@pre-start-1772140756"
    "media-tank/postgres@pre-start-1772140917"
    # Early backup-dated snapshots on mysql/postgres (all 0B)
    "backup-tank/media-mirror/mysql@pre-down-20260227-000935"
    "backup-tank/media-mirror/mysql@post-down-20260227-000936"
    "backup-tank/media-mirror/mysql@backup-20260227-0019"
    "backup-tank/media-mirror/mysql@backup-20260227-0020"
    "backup-tank/media-mirror/mysql@backup-20260227-0022"
    "backup-tank/media-mirror/mysql@backup-20260227-0026"
    "backup-tank/media-mirror/mysql@backup-20260227-0119"
    "backup-tank/media-mirror/postgres@pre-down-20260227-000935"
    "backup-tank/media-mirror/postgres@post-down-20260227-000936"
    "backup-tank/media-mirror/postgres@backup-20260227-0019"
    "backup-tank/media-mirror/postgres@backup-20260227-0020"
    "backup-tank/media-mirror/postgres@backup-20260227-0022"
    "backup-tank/media-mirror/postgres@backup-20260227-0026"
    "backup-tank/media-mirror/postgres@backup-20260227-0119"
    "media-tank/mysql@pre-down-20260227-000935"
    "media-tank/mysql@post-down-20260227-000936"
    "media-tank/mysql@backup-20260227-0019"
    "media-tank/mysql@backup-20260227-0020"
    "media-tank/mysql@backup-20260227-0022"
    "media-tank/mysql@backup-20260227-0026"
    "media-tank/mysql@backup-20260227-0119"
    "media-tank/postgres@pre-down-20260227-000935"
    "media-tank/postgres@post-down-20260227-000936"
    "media-tank/postgres@backup-20260227-0019"
    "media-tank/postgres@backup-20260227-0020"
    "media-tank/postgres@backup-20260227-0022"
    "media-tank/postgres@backup-20260227-0026"
    "media-tank/postgres@backup-20260227-0119"
)

for snap in "${STAGE1[@]}"; do
    destroy "$snap"
done

# ==============================================================================
# STAGE 2 — Feb 27 – Mar 15 operational churn snapshots (pre/post up/down)
#            These are safe to remove — Sanoid autosnaps cover this period,
#            and Syncoid's incremental base is the Mar 16 syncoid_media snapshot.
#            Estimated recovery: ~35–40 GB across both pools
# ==============================================================================
echo ""
echo "--- Stage 2: Feb 27 – Mar 15 operational churn ---"

# Use zfs list to dynamically find and destroy all manual pre/post snapshots
# in the Feb 27 – Mar 15 date range, excluding syncoid and autosnap snapshots
while IFS= read -r snap; do
    destroy "$snap"
done < <(zfs list -H -t snapshot -o name | grep -v 'autosnap' | grep -v 'syncoid' | grep -v 'pre-lidarr-removal' | grep -E '@(pre-|post-|backup-|pre-update-)' | grep -v '20260316')

# ==============================================================================
# STAGE 3 — pre-lidarr-removal snapshots (~7.4 GB total)
#            REVIEW BEFORE ENABLING: these are your only rollback point to
#            pre-Lidarr-removal state. If Lidarr has been gone stably since
#            Mar 1 and you don't need to roll back, uncomment these.
# ==============================================================================
echo ""
echo "--- Stage 3: pre-lidarr-removal (REVIEW BEFORE RUNNING) ---"

#UNCOMMENT WHEN READY:
destroy "media-tank@pre-lidarr-removal"
destroy "backup-tank/media-mirror@pre-lidarr-removal"
echo "[SKIPPED] pre-lidarr-removal snapshots — uncomment in script when ready"

# ==============================================================================
# STAGE 4 — Today's (Mar 16) manual operational snapshots
#            These are from today's stack restarts. Keep for 24–48h then
#            run this section once you're confident the stack is stable.
# ==============================================================================
echo ""
echo "--- Stage 4: Mar 16 today's manual snapshots (run after 24-48h) ---"

# UNCOMMENT WHEN READY:
# while IFS= read -r snap; do
#     destroy "$snap"
# done < <(zfs list -H -t snapshot -o name | grep -v 'autosnap' | grep -v 'syncoid' | grep -v 'pre-lidarr-removal' | grep '20260316')
echo "[SKIPPED] Mar 16 snapshots — uncomment after confirming stack stability"

echo ""
echo "============================================"
if [[ "$DRY_RUN" == "true" ]]; then
    echo " DRY RUN complete — no changes were made."
    echo " Review output above, then re-run with:"
    echo "   DRY_RUN=false bash zfs-snapshot-cleanup.sh"
else
    echo " Cleanup complete."
    echo " Run 'zfs list -t snapshot | grep -v autosnap' to verify."
    echo " Run 'zpool list' to confirm recovered space."
fi
echo "============================================"
