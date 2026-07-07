#!/bin/bash
# Ruta de guardado
DIR="$HOME/Imágenes/Capturas"
# Nombre único con fecha
FILE="$DIR/ALITA_$(date +'%Y-%m-%d_%H-%M-%S').png"

# Capturar, guardar en archivo Y copiar al portapapeles
grim -g "$(slurp)" - | tee "$FILE" | wl-copy -t image/png
