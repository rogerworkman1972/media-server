"""
radarr_import.py
----------------
Bulk-imports movie folders into Radarr from a local directory.

- Looks up each folder name via the Radarr /movie/lookup endpoint.
- Skips anything already in the library (by tmdbId).
- Adds in configurable batches with a sleep between them.

Usage:
    python radarr_import.py
"""

import os
import time
import requests

# ---------------------------------------------------------------------------
# CONFIGURATION
# ---------------------------------------------------------------------------
RADARR_URL        = "http://localhost:7878"
API_KEY           = "3aa7ca9c72294cdf91ba70d61be59242"
SOURCE_DIR        = "/mnt/media/emby-media/movies"
ROOT_FOLDER_PATH  = "/mnt/media/emby-media/movies"
QUALITY_PROFILE_ID = 1

BATCH_SIZE  = 75
SLEEP_TIME  = 30   # seconds between batches — avoids DB sync pile-up
TIMEOUT     = 15   # per-request timeout (seconds)
# ---------------------------------------------------------------------------


def get_existing_tmdb_ids(headers: dict) -> set:
    """Return the set of tmdbIds already present in Radarr."""
    resp = requests.get(f"{RADARR_URL}/api/v3/movie", headers=headers, timeout=TIMEOUT)
    resp.raise_for_status()
    return {m["tmdbId"] for m in resp.json()}


def build_payload(movie: dict) -> dict:
    """Construct the POST body for a single movie."""
    return {
        "title":            movie["title"],
        "qualityProfileId": QUALITY_PROFILE_ID,
        "titleSlug":        movie["titleSlug"],
        "tmdbId":           movie["tmdbId"],
        "year":             movie["year"],
        "rootFolderPath":   ROOT_FOLDER_PATH,
        "monitored":        True,
        "addOptions": {
            "searchForMovie": False,          # avoid hitting indexer limits on bulk import
            "monitor":        "movieOnly",
        },
    }


def add_movies() -> None:
    headers = {"X-Api-Key": API_KEY}

    print("Connecting to Radarr and fetching existing library…")
    try:
        existing_ids = get_existing_tmdb_ids(headers)
    except Exception as exc:
        print(f"[FATAL] Could not reach Radarr: {exc}")
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
            try:
                search_url = (
                    f"{RADARR_URL}/api/v3/movie/lookup"
                    f"?term={requests.utils.quote(folder_name)}"
                )
                search_resp = requests.get(search_url, headers=headers, timeout=TIMEOUT)

                if search_resp.status_code != 200 or not search_resp.json():
                    print(f"  [NOT FOUND] {folder_name}")
                    continue

                movie = search_resp.json()[0]

                if movie["tmdbId"] in existing_ids:
                    print(f"  [SKIPPED]   {movie['title']} (already in library)")
                    continue

                payload   = build_payload(movie)
                post_resp = requests.post(
                    f"{RADARR_URL}/api/v3/movie",
                    json=payload,
                    headers=headers,
                    timeout=TIMEOUT,
                )

                if post_resp.status_code in (200, 201):
                    print(f"  [ADDED]     {movie['title']} ({movie['year']})")
                    existing_ids.add(movie["tmdbId"])   # prevent same-run duplicates
                else:
                    print(f"  [FAILED]    {movie['title']}: {post_resp.text}")

            except requests.exceptions.Timeout:
                print(f"  [TIMEOUT]   {folder_name}")
            except Exception as exc:
                print(f"  [ERROR]     {folder_name}: {exc}")

        # Sleep between batches except after the last one
        if batch_start + BATCH_SIZE < total:
            print(f"\nWaiting {SLEEP_TIME}s for Radarr DB sync…")
            time.sleep(SLEEP_TIME)

    print("\n✅ Import complete.")


if __name__ == "__main__":
    add_movies()
