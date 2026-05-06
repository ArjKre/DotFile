#!/bin/bash

CACHE_FILE="/tmp/weather_cache.txt"
LOCATION="Bengaluru"

# Create a placeholder so hyprlock has something to read immediately on boot
echo "Fetching weather..." > "$CACHE_FILE"

# Start an infinite loop that updates the file in the background
while true; do
    RAW_DATA=$(curl -s --max-time 2 "wttr.in/${LOCATION}?format=%l|%t" 2>/dev/null)

    if [[ -n "$RAW_DATA" ]]; then
        LOC_NAME=$(echo "$RAW_DATA" | cut -d'|' -f1)
        TEMP_STR=$(echo "$RAW_DATA" | cut -d'|' -f2)
        TEMP_NUM=$(echo "$TEMP_STR" | sed 's/[^0-9-]*//g')

        if [ "$TEMP_NUM" -ge 35 ]; then EMOJI="🔥"
        elif [ "$TEMP_NUM" -ge 25 ]; then EMOJI="😎"
        elif [ "$TEMP_NUM" -ge 15 ]; then EMOJI="🌤️"
        elif [ "$TEMP_NUM" -ge 5 ]; then EMOJI="🧥"
        elif [ "$TEMP_NUM" -ge 0 ]; then EMOJI="🧊"
        else EMOJI="🥶"; fi

        # Save the final formatted string to the local file
        echo "$LOC_NAME"," $EMOJI $TEMP_STR" > "$CACHE_FILE"
    fi
    
    # Sleep for 30 minutes (1800 seconds) before checking again
    sleep 1800
done
