#!/usr/bin/env bash

player="spotify"

artist=$(playerctl -p "$player" metadata xesam:artist 2>/dev/null)
title=$(playerctl -p "$player" metadata xesam:title 2>/dev/null)
album=$(playerctl -p "$player" metadata xesam:album 2>/dev/null)
cover_url=$(playerctl -p "$player" metadata mpris:artUrl 2>/dev/null)

# Texto del cuerpo: artista + álbum (si hay)
body="$artist"
if [[ -n "$album" ]]; then
    body="$artist · $album"
fi

# Icono por defecto (si no hay cover)
icon_path="spotify"

if [[ -n "$cover_url" ]]; then
    if [[ "$cover_url" == file://* ]]; then
        icon_path="${cover_url#file://}"
    elif [[ "$cover_url" == http* ]]; then
        tmp_cover="/tmp/spotify_cover.jpg"
        if curl -sL "$cover_url" -o "$tmp_cover"; then
            icon_path="$tmp_cover"
        fi
    fi
fi

# -a → nombre de la app (para la regla [spotify] de dunst)
# -u low → urgencia baja, no molesta tanto
notify-send -a "Spotify" -u low -i "$icon_path" "$title" "$body"
