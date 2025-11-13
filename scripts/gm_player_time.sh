#!/usr/bin/env bash

# Obtener posición actual (en segundos — redondeada)
pos_s=$(playerctl --player=spotify,firefox,chromium,mpv position 2>/dev/null | awk '{printf "%.0f",$1}')

# Duración total en microsegundos
len_us=$(playerctl --player=spotify,firefox,chromium,mpv metadata mpris:length 2>/dev/null)

# Si no hay datos, mostrar estado vacío
if [[ -z "$len_us" || "$len_us" == "0" ]]; then
  echo "<txt>--:-- / --:--</txt>"
  echo "<tool>Sin reproducción</tool>"
  exit 0
fi

# Convertir a segundos
len_s=$(( len_us / 1000000 ))

# Función mm:ss
to_mmss () {
  local s=$1
  local m=$(( s / 60 ))
  local r=$(( s % 60 ))
  printf "%02d:%02d" "$m" "$r"
}

# Mostrar formato
echo "<txt>$(to_mmss "$pos_s") / $(to_mmss "$len_s")</txt>"
echo "<tool>Tiempo actual / Duración total</tool>"
