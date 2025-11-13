#!/usr/bin/env bash

player="spotify"
prev_title=""

playerctl --player="$player" metadata --follow | while read -r line; do
    current_title=$(playerctl -p "$player" metadata xesam:title 2>/dev/null)

    # Solo notificar si cambió la canción y el título no está vacío
    if [[ -n "$current_title" && "$current_title" != "$prev_title" ]]; then
        ~/.local/bin/spotify-cover.sh
        prev_title="$current_title"
    fi
done
