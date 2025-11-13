#!/usr/bin/env bash

PLAYER_LIST='spotify,firefox,chromium,mpv'
TITLE_FMT='{{xesam:artist}} - {{xesam:title}}'
MAX_VISIBLE=25
STATE_FILE="${HOME}/.cache/gm_title_scroll.pos"

mkdir -p "$(dirname "$STATE_FILE")"

title=$(playerctl --player="$PLAYER_LIST" metadata --format "$TITLE_FMT" 2>/dev/null)
status=$(playerctl --player="$PLAYER_LIST" status 2>/dev/null)
player=$(playerctl --player="$PLAYER_LIST" metadata --format '{{playerName}}' 2>/dev/null)

# Nada sonando
if [[ -z "$title" || -z "$player" ]]; then
  echo "<txtfg>#888888</txtfg>"
  echo "<txt>Sin música</txt>"
  echo "<tool>Sin reproducción</tool>"
  exit 0
fi

# Color según estado
case "$status" in
  Playing ) color="#89DCEB" ;;
  Paused )  color="#A6ADC8" ;;
  * )       color="#888888" ;;
esac

# SCROLL
base="${title}"

if ((${#base} <= MAX_VISIBLE)); then
  visible="$base"
else
  if [[ -f "$STATE_FILE" ]]; then
    read -r pos < "$STATE_FILE"
  else
    pos=0
  fi

  sep=" • "
  scroll="${base}${sep}${base}${sep}"
  scroll_len=${#scroll}

  pos=$((pos % scroll_len))
  visible=${scroll:pos:MAX_VISIBLE}

  echo $((pos + 1)) > "$STATE_FILE"
fi

echo "<txtfg>${color}</txtfg>"
echo "<txt>${visible}</txt>"
echo "<tool>${player}: ${title}</tool>"
