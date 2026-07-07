#!/usr/bin/env bash

# === 1. EXTRACCIÓN DE DATOS ===
WIFI_STATE=$(nmcli -t -f WIFI g)

# Obtenemos el nombre de la conexión activa (Wi-Fi o Ethernet)
ACTIVE_CONNECTION=$(nmcli -t -f NAME,TYPE connection show --active | head -n 1 | cut -d':' -f1)

# Obtenemos tu dirección IP local (ignorando la de loopback 127.0.0.1)
IP_ADDRESS=$(ip -4 addr show | grep -oP '(?<=inet\s)\d+(\.\d+){3}' | grep -v '127.0.0.1' | head -n 1)

# Si no hay conexión, mostramos valores por defecto
if [ -z "$ACTIVE_CONNECTION" ]; then
    ACTIVE_CONNECTION="Desconectado"
    IP_ADDRESS="Sin IP"
fi

# === 2. CONSTRUCCIÓN DEL MENÚ ===
# Creamos las líneas de información (estarán arriba)
INFO_RED="󰤨  Red: $ACTIVE_CONNECTION"
INFO_IP="󰩟  IP: $IP_ADDRESS"
SEPARADOR="------------------------"

# Opciones interactivas
if [ "$WIFI_STATE" = "enabled" ]; then
    TOGGLE="󰖪  Desactivar Wi-Fi"
else
    TOGGLE="󰖩  Activar Wi-Fi"
fi
SETTINGS="󰒍  Configuración Avanzada"

# Unimos todo en un solo menú
MENU="${INFO_RED}\n${INFO_IP}\n${SEPARADOR}\n${TOGGLE}\n${SETTINGS}"

# === 3. LLAMADA A ROFI ===
SELECCION=$(echo -e "$MENU" | rofi -dmenu -i -theme ~/.config/rofi/themes/alita-network.rasi)

echo "Seleccionaste: $SELECCION"
