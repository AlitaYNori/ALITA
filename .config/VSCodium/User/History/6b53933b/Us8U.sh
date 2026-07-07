#!/usr/bin/env bash

# === 1. EXTRACCIÓN DEL ESTADO ===
# Obtenemos si el hardware Wi-Fi está encendido o apagado
WIFI_STATE=$(nmcli -t -f WIFI g)

# === 2. CONSTRUCCIÓN DE LAS OPCIONES FIJAS ===
# Definimos las variables de los botones dependiendo del estado
if [ "$WIFI_STATE" = "enabled" ]; then
    TOGGLE="󰖪  Desactivar Wi-Fi"
else
    TOGGLE="󰖩  Activar Wi-Fi"
fi

SETTINGS="󰒍  Configuración Avanzada"

# Unimos las opciones con un salto de línea (\n)
MENU="${TOGGLE}\n${SETTINGS}"

# === 3. LLAMADA A ROFI ===
# Le pasamos la variable MENU a rofi.
# Le indicamos explícitamente dónde está tu tema para evitar conflictos.
SELECCION=$(echo -e "$MENU" | rofi -dmenu -i -p "󰤨  Red" -theme ~/.config/rofi/themes/alita.rasi)

# Imprimimos en la terminal lo que seleccionaste para verificar la lógica
echo "Seleccionaste: $SELECCION"
