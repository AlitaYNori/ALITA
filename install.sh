#!/bin/bash

set -e

echo "==> Copiando configuración..."

mkdir -p ~/.config

cp -r .config/* ~/.config/

chmod +x ~/.config/alita/scripts/*.sh 2>/dev/null || true

echo
echo "========================================"
echo " ALITA instalada correctamente."
echo " Reinicia Hyprland o la sesión."
echo "========================================"
