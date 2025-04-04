#!/bin/bash

set -e  # Exit on error

# Define variables
REPO_URL="https://github.com/scyrock/gweatherrouting.git"
APP_NAME="gWeatherRouting"
APP_DIR="AppDir"
DEPLOY_GTK_VERSION=3

# 1. Clone the Repository
git clone "$REPO_URL"
cd gweatherrouting/gweatherrouting/

# 3. Generate Binary from Python File
pyinstaller --onefile --hidden-import=gi --collect-submodules=gi --add-data "data/:gweatherrouting/data" --add-data "gtk/:gweatherrouting/gtk" --name "$APP_NAME" main.py
cd ..

# 4. Create AppImage Directory Structure
mkdir -p "$APP_DIR/usr/bin" "$APP_DIR/usr/share/applications" "$APP_DIR/usr/share/icons/hicolor/256x256/apps"
cp "gweatherrouting/dist/$APP_NAME" "$APP_DIR/usr/bin/"
cp "icon.png" "$APP_DIR/usr/share/icons/hicolor/256x256/apps/"
cp "$APP_NAME.desktop" "$APP_DIR/usr/share/applications/"

# 5. Install linuxdeploy and GTK Plugin
wget -c "https://github.com/linuxdeploy/linuxdeploy/releases/download/continuous/linuxdeploy-x86_64.AppImage"
wget -c "https://raw.githubusercontent.com/linuxdeploy/linuxdeploy-plugin-gtk/master/linuxdeploy-plugin-gtk.sh"
chmod +x linuxdeploy-x86_64.AppImage linuxdeploy-plugin-gtk.sh

# 6. Add Required Libraries to AppImage Directory
NO_STRIP=true DEPLOY_GTK_VERSION=3 ./linuxdeploy-x86_64.AppImage --appdir AppDir --plugin gtk --library /usr/lib/x86_64-linux-gnu/libosmgpsmap-1.0.so.1

# 7. Modify the AppRun file to add LD_LIBRARY_PATH after the gtk plugin line
rm "$APP_DIR/AppRun"
cp AppRun "$APP_DIR/AppRun"
wget https://github.com/AppImage/AppImageKit/releases/latest/download/appimagetool-x86_64.AppImage
chmod +x appimagetool-x86_64.AppImage
./appimagetool-x86_64.AppImage "$APP_DIR"


# 8. Remove linuxdeploy
#rm linuxdeploy-plugin-gtk.sh
#rm linuxdeploy-x86_64.AppImage
#rm appimagetool-x86_64.AppImage
