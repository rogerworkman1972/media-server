import os
import requests
import time

# --- CONFIGURATION ---
RADARR_URL = "http://localhost:7878"
API_KEY = "3aa7ca9c72294cdf91ba70d61be59242"
SOURCE_DIR = "/mnt/media/emby-media/movies"
ROOT_FOLDER_PATH = "/mnt/media/emby-media/movies"
QUALITY_PROFILE_ID = 1  

# --- THROTTLING ---
BATCH_SIZE = 50
SLEEP_TIME = 30
# ------------------

def get_existing_tmdb_ids(headers):
    """Fetch all movies already in Radarr to prevent duplicates."""
    res = requests.get(f"{RADARR_URL}/api/v3/movie", headers=headers)
    return {m['tmdbId'] for m in res.json()}

def add_movies_fast():
    headers = {"X-Api-Key": API_KEY}
    
    print("Fetching existing library to prevent duplicates...")
    existing_ids = get_existing_tmdb_ids(headers)
    
    all_folders = [f for f in os.listdir(SOURCE_DIR) if os.path.isdir(os.path.join(SOURCE_DIR, f))]
    total = len(all_folders)
    print(f"Found {total} folders. Starting import...")

    for i in range(0, total, BATCH_SIZE):
        batch = all_folders[i : i + BATCH_SIZE]
        print(f"\n--- Batch {i//BATCH_SIZE + 1} ---")
        
        for folder_name in batch:
            try:
                # Radarr uses the folder name to guess the movie
                search_url = f"{RADARR_URL}/api/v3/movie/lookup?term={requests.utils.quote(folder_name)}"
                search_res = requests.get(search_url, headers=headers, timeout=15)
                
                if search_res.status_code == 200 and search_res.json():
                    movie = search_res.json()[0]
                    
                    if movie['tmdbId'] in existing_ids:
                        print(f"[SKIPPED] {movie['title']} (Already in DB)")
                        continue

                    # Updated Payload to Enable Monitoring
                    payload = {
                        "title": movie["title"],
                        "qualityProfileId": QUALITY_PROFILE_ID,
                        "titleSlug": movie["titleSlug"],
                        "tmdbId": movie["tmdbId"],
                        "year": movie["year"],
                        "rootFolderPath": ROOT_FOLDER_PATH,
                        "monitored": True,  # Now set to True
                        "addOptions": {
                            "searchForMovie": False, # False avoids hitting indexer limits immediately
                            "monitor": "movieOnly"   # Standard monitoring mode
                        }
                    }
                    
                    post_res = requests.post(f"{RADARR_URL}/api/v3/movie", json=payload, headers=headers)
                    if post_res.status_code in [200, 201]:
                        print(f"[ADDED] {movie['title']}")
                    else:
                        print(f"[FAILED] {movie['title']}: {post_res.text}")
                else:
                    print(f"[NOT FOUND] {folder_name}")
            
            except Exception as e:
                print(f"[ERROR] {folder_name}: {e}")

        print(f"Waiting {SLEEP_TIME}s for DB sync...")
        time.sleep(SLEEP_TIME)

if __name__ == "__main__":
    add_movies_fast()
