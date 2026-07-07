#!/bin/bash

# ======================================
# Proyecto ALITA
# Gestor de Fondos (Imagen y Video)
# ======================================

ARCHIVO="$1"
MONITOR="HDMI-A-1"
ESTADO="$HOME/.config/alita/state/wallpaper.conf"
CONF_HYPR="$HOME/.config/hypr/hyprpaper/hyprpaper.conf"

# Verificar que se envió un archivo
if [ -z "$ARCHIVO" ]; then
    echo "Error: Debes proporcionar una ruta de archivo."
    exit 1
fi

# Matar cualquier fondo que se esté ejecutando actualmente
pkill hyprpaper
pkill mpvpaper

# Detectar formato y aplicar
if [[ "$ARCHIVO" == *.jpg || "$ARCHIVO" == *.jpeg || "$ARCHIVO" == *.png || "$ARCHIVO" == *.webp ]]; then

    # Preparar configuración de hyprpaper al vuelo
    mkdir -p "$(dirname "$CONF_HYPR")"
    echo "preload = $ARCHIVO" > "$CONF_HYPR"
    echo "wallpaper = $MONITOR,$ARCHIVO" >> "$CONF_HYPR"

    # Lanzar hyprpaper
    hyprpaper -c "$CONF_HYPR" &

    # Guardar el estado
    echo "TYPE=image" > "$ESTADO"
    echo "FILE=$ARCHIVO" >> "$ESTADO"

elif [[ "$ARCHIVO" == *.mp4 || "$ARCHIVO" == *.mkv || "$ARCHIVO" == *.webm ]]; then

    # Lanzar mpvpaper (sin audio y en bucle)
    mpvpaper -o "loop no-audio" $MONITOR "$ARCHIVO" &

    # Guardar el estado
    echo "TYPE=video" > "$ESTADO"
    echo "FILE=$ARCHIVO" >> "$ESTADO"

else
    echo "Formato no soportado por ALITA."
fi
