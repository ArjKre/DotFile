#!/bin/bash

# Define your location (leave blank to let wttr.in guess based on your IP)
LOCATION="Bengaluru"

# Fetch the raw temperature string (e.g., "+28°C") and the location name
TEMP_STR=$(curl -s "wttr.in/${LOCATION}?format=%t" 2>/dev/null)
LOC_NAME=$(curl -s "wttr.in/${LOCATION}?format=%l" 2>/dev/null)

# Extract just the numbers and the minus sign for the math comparison
TEMP_NUM=$(echo "$TEMP_STR" | sed 's/[^0-9-]*//g')

# Guard against network failures or empty responses
if [[ -z "$TEMP_NUM" ]]; then
    echo "Weather offline"
    exit 1
fi

# Assign an emoji based on the temperature in Celsius
if [ "$TEMP_NUM" -ge 35 ]; then
    EMOJI="🔥"  # Scorching
elif [ "$TEMP_NUM" -ge 25 ]; then
    EMOJI="😎"  # Hot/Warm
elif [ "$TEMP_NUM" -ge 15 ]; then
    EMOJI="🌤️"  # Mild
elif [ "$TEMP_NUM" -ge 5 ]; then
    EMOJI="🧥"  # Chilly
elif [ "$TEMP_NUM" -ge 0 ]; then
    EMOJI="🧊"  # Cold
else
    EMOJI="🥶"  # Freezing
fi

# Print the final output
echo "$LOC_NAME"," $EMOJI $TEMP_STR"
