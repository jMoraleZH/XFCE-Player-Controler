#!/usr/bin/env bash

PLAYER_LIST='spotify,firefox,chromium,mpv'

player=$(playerctl --player="$PLAYER_LIST" metadata --format '{{playerName}}' 2>/dev/null)

if [[ -z "$player" ]]; then
  echo "<txt></txt>"
  echo "<tool>No hay nada reproduciendo</tool>"
  exit 0
fi

case "$player" in
  spotify* )
    icon=""
    ;;
  firefox* )
    icon=""
    ;;
  chromium* | google-chrome* )
    icon=""
    ;;
  brave* | vivaldi* )
    icon=""
    ;;
  mpv* )
    icon=""
    ;;
  * )
    icon=""
    ;;
esac

echo "<txt>   ${icon}   </txt>"
echo "<tool>Reproductor: ${player}</tool>"
