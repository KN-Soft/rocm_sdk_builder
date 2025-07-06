#!/usr/bin/env bash
set -euo pipefail

ROCM_DIR="/opt/rocm_sdk_612"

echo "🔧 Setze Leserechte (644) für Dateien in $ROCM_DIR..."
find "$ROCM_DIR" -type f -exec chmod a+r {} +

echo "🔧 Setze Ausführungsrechte (755) für Verzeichnisse..."
find "$ROCM_DIR" -type d -exec chmod a+rx {} +

echo "🔧 Setze Ausführungsrechte (755) für ausführbare Dateien..."
find "$ROCM_DIR" -type f -perm -111 -exec chmod a+rx {} +

echo "✅ Rechte gesetzt: Alle Nutzer können jetzt lesend & ausführend auf $ROCM_DIR zugreifen."
