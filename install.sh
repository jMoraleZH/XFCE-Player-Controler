#!/usr/bin/env bash

echo "📦 Instalando Genmon Multimedia Controls..."

# Crear carpeta temporal
mkdir -p /usr/local/bin

# Copiar scripts principales
echo "➡️  Copiando scripts..."
sudo cp scripts/*.sh /usr/local/bin/
sudo chmod +x /usr/local/bin/*.sh

# Instalar servicio de Spotify (si existe)
if [[ -f "systemd/spotify-cover.service" ]]; then
    echo "➡️  Instalando servicio systemd de Spotify..."
    mkdir -p ~/.config/systemd/user
    cp systemd/spotify-cover.service ~/.config/systemd/user/
    systemctl --user daemon-reload
    systemctl --user enable --now spotify-cover.service
fi

echo "✔️ Instalación completa."
echo "Ahora agrega los módulos Genmon a tu panel XFCE."
