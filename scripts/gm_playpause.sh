#!/usr/bin/env bash

status=$(playerctl --player=spotify,firefox,chromium,mpv status 2>/dev/null)

# Iconos:
# 󰐊 = pausa visible (cuando está sonando → mostrar PAUSE)
# 󰏤 = play visible (cuando está pausado → mostrar PLAY)
if [[ "$status" == "Playing" ]]; then
    icon="󰐊"   # mostrar icono de PAUSE
else
    icon="󰏤"   # mostrar icono de PLAY
fi

# Mostrar el icono
echo "<txt>$icon</txt>"

# Acción cuando haces clic
echo "<txtclick>playerctl --player=spotify,firefox,chromium,mpv play-pause</txtclick>"

echo "<tool>Play / Pause</tool>"
