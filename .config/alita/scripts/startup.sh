#!/bin/bash

echo "Iniciando ALITA..."
sleep 2

# Leemos qué fondo fue el último que elegiste
ARCHIVO=$(cat ~/.config/alita/wallpaper_actual.txt 2>/dev/null)
TIPO=$(cat ~/.config/alita/wallpaper_tipo.txt 2>/dev/null)

if [[ "$TIPO" == image/* ]]; then
    # Iniciamos hyprpaper en segundo plano
    hyprpaper > /dev/null 2>&1 &
    sleep 1 # Damos 1 segundo para que arranque bien
    
    # Le inyectamos la imagen directamente como hicimos en el otro script
    hyprctl hyprpaper preload "$ARCHIVO"
    hyprctl hyprpaper wallpaper "HDMI-A-1,$ARCHIVO"
    
elif [[ "$TIPO" == video/* ]]; then
    # Lanzamos el video especificando tu monitor HDMI-A-1
    mpvpaper HDMI-A-1 "$ARCHIVO" -o "loop no-audio" > /dev/null 2>&1 &
fi
