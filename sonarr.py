import os
import requests
import time

# --- CONFIGURATION ---
SONARR_URL = "http://localhost:8989"
API_KEY = "e7dc0771e80f4d799910a499e068c3c3"
SOURCE_DIR = "/mnt/media/emby-media/series"
ROOT_FOLDER_PATH = "/mnt/media/emby-media/series"
QUALITY_PROFILE_ID = 1  
# --- Note: In Sonarr v4, this is usually unnecessary, but kept for v3 compatibility
LANGUAGE_PROFILE_ID = 1 

BATCH_SIZE = 40
SLEEP_TIME = 10 # Reduced slightly as 20s is quite long for 40 items

def get_existing_tvdb_ids(headers):
    """Fetch all series already in Sonarr to prevent duplicates."""
    res = requests.get(f"{SONARR_URL}/api/v3/series", headers=headers)
    res.raise_for_status()
    return {s['tvdbId'] for s in res.json()}

def add_series_fast():
    headers = {"X-Api-Key": API_KEY}
    
    try:
        existing_ids = get_existing_tvdb_ids(headers)
    except Exception as e:
        print(f"Failed to connect to Sonarr: {e}")
        return

    all_folders = [f for f in os.listdir(SOURCE_DIR) if os.path.isdir(os.path.join(SOURCE_DIR, f))]
    total = len(all_folders)
    print(f"Found {total} folders. Starting import...")

    for i in range(0, total, BATCH_SIZE):
        batch = all_folders[i : i + BATCH_SIZE]
        print(f"\n--- Batch {i//BATCH_SIZE + 1} ({i}/{total}) ---")
        
        for folder_name in batch:
            full_path = os.path.join(ROOT_FOLDER_PATH, folder_name)
            try:
                # 1. Search for the series
                search_url = f"{SONARR_URL}/api/v3/series/lookup?term={requests.utils.quote(folder_name)}"
                search_res = requests.get(search_url, headers=headers, timeout=15)
                
                if search_res.status_code == 200 and search_res.json():
                    series = search_res.json()[0]
                    
                    if series['tvdbId'] in existing_ids:
                        print(f"[SKIPPED] {series['title']} (Already in DB)")
                        continue

                    # 2. Build the payload with the explicit path
                    payload = {
                        "title": series["title"],
                        "qualityProfileId": QUALITY_PROFILE_ID,
                        "languageProfileId": LANGUAGE_PROFILE_ID,
                        "titleSlug": series["titleSlug"],
                        "tvdbId": series["tvdbId"],
                        "tmdbId": series.get("tmdbId", 0),
                        "images": series.get("images", []),
                        "seasons": series.get("seasons", []),
                        "rootFolderPath": ROOT_FOLDER_PATH,
                        "path": full_path, # CRITICAL: Keeps your existing folder structure
                        "monitored": True,
                        "seriesType": "standard",
                        "addOptions": {
                            "ignoreEpisodesWithFiles": False,
                            "ignoreEpisodesWithoutFiles": False,
                            "searchForMissingEpisodes": False,
                            "monitor": "all"
                        }
                    }
                    
                    post_res = requests.post(f"{SONARR_URL}/api/v3/series", json=payload, headers=headers)
                    if post_res.status_code in [200, 201]:
                        print(f"[ADDED] {series['title']}")
                        existing_ids.add(series['tvdbId']) # Update local cache
                    else:
                        print(f"[FAILED] {series['title']}: {post_res.json().get('message', post_res.text)}")
                else:
                    print(f"[NOT FOUND] {folder_name}")
            
            except Exception as e:
                print(f"[ERROR] {folder_name}: {e}")

        if i + BATCH_SIZE < total:
            print(f"Waiting {SLEEP_TIME}s for Sonarr to process disk scan...")
            time.sleep(SLEEP_TIME)

if __name__ == "__main__":
    add_series_fast()
