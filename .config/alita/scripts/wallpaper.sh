#!/bin/bash

# Si no hay archivo, salimos
if [ -z "$1" ]; then
    exit 1
fi

ARCHIVO="$1"
TIPO=$(file --mime-type -b "$ARCHIVO")

# Guardamos tu selección
mkdir -p ~/.config/alita/
echo "$ARCHIVO" > ~/.config/alita/wallpaper_actual.txt
echo "$TIPO" > ~/.config/alita/wallpaper_tipo.txt

if [[ "$TIPO" == image/* ]]; then
    # Matamos el video si había uno
    pkill mpvpaper
    
    # Si hyprpaper está cerrado, lo abrimos
    if ! pgrep -x hyprpaper > /dev/null; then
        hyprpaper > /dev/null 2>&1 &
        sleep 1 # Le damos 1 segundo para despertar
    fi
    
    # ¡ESTA ES LA MAGIA! Le enviamos la imagen en vivo al hyprpaper abierto
    hyprctl hyprpaper preload "$ARCHIVO"
    hyprctl hyprpaper wallpaper "HDMI-A-1,$ARCHIVO"
    
elif [[ "$TIPO" == video/* ]]; then
    # Si es video, matamos hyprpaper y cualquier otro video
    pkill hyprpaper
    pkill mpvpaper
    sleep 0.5
    
    # Lanzamos el video en tu monitor
    mpvpaper HDMI-A-1 "$ARCHIVO" -o "loop no-audio" > /dev/null 2>&1 &
fi
