#!/usr/bin/env bash
set -euo pipefail

### erstellen dieser Datei
# sudo nano /opt/init_rocm_sdk.sh
# sudo chmod +x /opt/init_rocm_sdk.sh
# sudo /opt/init_rocm_sdk.sh

### fehlende Abhängikeiten herstellen
#sudo add-apt-repository universe
#sudo apt update
#sudo apt --fix-broken install
#sudo apt -f install
#sudo apt install aptitude
#sudo aptitude install libbz2-dev libdeflate-dev libgmp-dev libmpfr-dev libzstd-dev uuid-dev zlib1g-dev
### bei einem downgrade muss erst mit n und  dann mit y geantwortet werden, damitt die installation gelingt


### ⚙️ Konfiguration – Pfade & Versionen
export BASE_DIR=/opt        # oder /usr/local gemäß Wunsch
export SDK_DIR=${BASE_DIR}/rocm_sdk_builder
export SDK_REPO=https://github.com/KN-Soft/rocm_sdk_builder.git #https://github.com/lamikr/rocm_sdk_builder.git
export SDK_TAG=releases/rocm_sdk_builder_612

export VENV_DIR=${SDK_DIR}/venv
export PYTHON_BIN=${VENV_DIR}/bin/python3

# optional: Compiler-Fix in Umgebung exportieren
export LDFLAGS="-Wl,--no-relax ${LDFLAGS:-}"
#export CXXFLAGS="-Wl,--no-relax ${CXXFLAGS:-}"

# git config --global user.name "KN-Soft"
# git config --global user.email KN-Soft@users.noreply.github.com

### 🐍 1. Clone oder Update SDK-Repo
#if [ -d "${SDK_DIR}/.git" ]; then
#  echo "🔄 Aktualisiere vorhandenes SDK-Repo…"
#  cd "$SDK_DIR"
#  git fetch --all
#  git checkout "$SDK_TAG"
#  git pull origin "$SDK_TAG"
#else
#  echo "⬇️ Klone SDK-Repo nach ${SDK_DIR}…"
#  sudo mkdir -p "$(dirname "$SDK_DIR")"
#  sudo chown "$USER":"$USER" "$(dirname "$SDK_DIR")"
#  git clone "$SDK_REPO" "$SDK_DIR"
#  cd "$SDK_DIR"
#  git checkout "$SDK_TAG"
#fi

### 🛠️ 2. venv prüfen / anlegen
if [ ! -x "$PYTHON_BIN" ]; then
  echo "🌱 Erstelle venv in ${VENV_DIR} mit system-Python…"
  /usr/bin/python3.11 -m venv "$VENV_DIR" --system-site-packages
fi

echo "Aktiviere venv..."
# shellcheck disable=SC1090
source "${VENV_DIR}/bin/activate"

### 🔧 3. Abhängigkeiten installieren
#echo "📦 Installiere Python-Abhängigkeiten für SDK..."
#pip install --upgrade pip
#if [ -f requirements.txt ]; then
#  pip install -r requirements.txt
#else
#  echo "⚠️ Keine requirements.txt gefunden – evtl. kein Python nötig."
#fi

### ✅ 4. SDK-Builder vorbereiten nach Anleitung
echo "🔧 Führe SDK-Builder Schritte im venv aus…"
cd "$SDK_DIR"

#echo "-> install_deps.sh"
#./install_deps.sh

#echo "-> babs.sh -c (Configure GPU targets)"
#./babs.sh -c

echo "✅ venv + SDK initialisiert. Für Build:\n   source ${VENV_DIR}/bin/activate && cd ${SDK_DIR} && ./babs.sh -b"

echo "Fertig!"
echo "Ab hier muss das Projekt manuell angepasst werden um den fehler im compiler zunächst auszuschließen"

#./babs.sh -i
#echo "babs.sh -i ist fertig"

#./babs.sh -up
#echo "babs.sh -up ist fertig"

./babs.sh -b
echo "babs.sh -b ist fertig"
