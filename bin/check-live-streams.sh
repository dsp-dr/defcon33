#!/bin/sh
# Check for live DEF CON streams on YouTube

# Check if dependencies are installed
command -v yt-dlp >/dev/null 2>&1 || {
    echo "Error: yt-dlp is not installed. Install with: pip install yt-dlp" >&2
    exit 1
}

command -v jq >/dev/null 2>&1 || {
    echo "Error: jq is not installed. Install with: pkg install jq" >&2
    exit 1
}

# Check for live streams
echo "Checking for live DEF CON streams..."
yt-dlp --flat-playlist -j "https://www.youtube.com/@DEFCONConference/streams" | \
    jq -r 'select(.live_status == "is_live") | "[\(.id)] \(.title)"'

# If no live streams found
if [ ${PIPESTATUS[0]} -ne 0 ] || [ -z "$(yt-dlp --flat-playlist -j "https://www.youtube.com/@DEFCONConference/streams" | jq -r 'select(.live_status == "is_live")')" ]; then
    echo "No live streams currently active"
    echo ""
    echo "Check recent uploads:"
    yt-dlp --flat-playlist -j "https://www.youtube.com/@DEFCONConference/videos" | \
        head -5 | \
        jq -r '"[\(.id)] \(.title)"'
fi