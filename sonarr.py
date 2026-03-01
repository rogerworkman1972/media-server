"""
sonarr_import.py
----------------
Bulk-imports TV series folders into Sonarr v4 from a local directory.

- Looks up each folder name via the Sonarr /series/lookup endpoint.
- Skips anything already in the library (by tvdbId).
- Adds in batches with a configurable sleep between batches to avoid
  overwhelming Sonarr's background scanner.

Usage:
    python sonarr_import.py
"""

import os
import time
import requests

# ---------------------------------------------------------------------------
# CONFIGURATION
# ---------------------------------------------------------------------------
SONARR_URL        = "http://localhost:8989"
API_KEY           = "e7dc0771e80f4d799910a499e068c3c3"
SOURCE_DIR        = "/mnt/media/emby-media/series"
ROOT_FOLDER_PATH  = "/mnt/media/emby-media/series"
QUALITY_PROFILE_ID = 1
# languageProfileId is a Sonarr v3 concept; v4 ignores it but we keep it
# here for backward compatibility in case you ever run v3 side-by-side.
LANGUAGE_PROFILE_ID = 1

BATCH_SIZE  = 40
SLEEP_TIME  = 10   # seconds between batches — keeps Sonarr's scanner happy
TIMEOUT     = 15   # per-request timeout (seconds)
# ---------------------------------------------------------------------------


def get_existing_tvdb_ids(headers: dict) -> set:
    """Return the set of tvdbIds already present in Sonarr."""
    resp = requests.get(f"{SONARR_URL}/api/v3/series", headers=headers, timeout=TIMEOUT)
    resp.raise_for_status()
    return {s["tvdbId"] for s in resp.json()}


def build_payload(series: dict, full_path: str) -> dict:
    """Construct the POST body for a single series."""
    return {
        "title":             series["title"],
        "qualityProfileId":  QUALITY_PROFILE_ID,
        "languageProfileId": LANGUAGE_PROFILE_ID,   # no-op in v4
        "titleSlug":         series["titleSlug"],
        "tvdbId":            series["tvdbId"],
        "tmdbId":            series.get("tmdbId", 0),
        "images":            series.get("images", []),
        "seasons":           series.get("seasons", []),
        "rootFolderPath":    ROOT_FOLDER_PATH,
        "path":              full_path,   # locks in existing folder structure
        "monitored":         True,
        "seriesType":        "standard",
        "addOptions": {
            "ignoreEpisodesWithFiles":    False,
            "ignoreEpisodesWithoutFiles": False,
            "searchForMissingEpisodes":   False,
            "monitor":                    "all",
        },
    }


def add_series() -> None:
    headers = {"X-Api-Key": API_KEY}

    print("Connecting to Sonarr and fetching existing library…")
    try:
        existing_ids = get_existing_tvdb_ids(headers)
    except Exception as exc:
        print(f"[FATAL] Could not reach Sonarr: {exc}")
        return

    all_folders = [
        f for f in os.listdir(SOURCE_DIR)
        if os.path.isdir(os.path.join(SOURCE_DIR, f))
    ]
    total = len(all_folders)
    print(f"Found {total} folders. Starting import in batches of {BATCH_SIZE}…\n")

    for batch_start in range(0, total, BATCH_SIZE):
        batch = all_folders[batch_start : batch_start + BATCH_SIZE]
        batch_num = batch_start // BATCH_SIZE + 1
        print(f"--- Batch {batch_num} ({batch_start + 1}–{min(batch_start + BATCH_SIZE, total)} of {total}) ---")

        for folder_name in batch:
            full_path = os.path.join(ROOT_FOLDER_PATH, folder_name)
            try:
                search_url = (
                    f"{SONARR_URL}/api/v3/series/lookup"
                    f"?term={requests.utils.quote(folder_name)}"
                )
                search_resp = requests.get(search_url, headers=headers, timeout=TIMEOUT)

                if search_resp.status_code != 200 or not search_resp.json():
                    print(f"  [NOT FOUND] {folder_name}")
                    continue

                series = search_resp.json()[0]

                if series["tvdbId"] in existing_ids:
                    print(f"  [SKIPPED]   {series['title']} (already in library)")
                    continue

                payload  = build_payload(series, full_path)
                post_resp = requests.post(
                    f"{SONARR_URL}/api/v3/series",
                    json=payload,
                    headers=headers,
                    timeout=TIMEOUT,
                )

                if post_resp.status_code in (200, 201):
                    print(f"  [ADDED]     {series['title']}")
                    existing_ids.add(series["tvdbId"])   # prevent same-run duplicate
                else:
                    err = post_resp.json().get("message", post_resp.text)
                    print(f"  [FAILED]    {series['title']}: {err}")

            except requests.exceptions.Timeout:
                print(f"  [TIMEOUT]   {folder_name}")
            except Exception as exc:
                print(f"  [ERROR]     {folder_name}: {exc}")

        # Sleep between batches except after the last one
        if batch_start + BATCH_SIZE < total:
            print(f"\nWaiting {SLEEP_TIME}s for Sonarr disk scanner to catch up…")
            time.sleep(SLEEP_TIME)

    print("\n✅ Import complete.")


if __name__ == "__main__":
    add_series()
