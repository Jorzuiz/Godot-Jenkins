# Windows build

PROJECT_NAME="Jueguico" # Nombre del ejecutable
PROJECT_PATH= "First Person Shooter Template" # Nombre del proyecto
BUILD_DIR="./builds/$PROJECT_NAME" # Ruta de la build

GODOT_PATH="/path/to/godot" # Ruta de godot
EXPORT_PRESET="Windows Desktop"  # Preset de exportación definido en tu proyecto de Godot
 # Limpia la build anterior
if [ -d "$BUILD_DIR" ]; then
    rm -rf $BUILD_DIR
fi
# Crea directorio para la nueva build
mkdir -p $BUILD_DIR
# ./Godot_v4.2.2-stable_win64_console.exe --headless --path "First Person Shooter Template" --export-release "Windows Desktop" "./$BUILD_DIR/MyGame.exe"

"$GODOT_PATH/godot" --headless --path "$PROJECT_PATH" --export-release "$EXPORT_PRESET" "./$BUILD_DIR/ $PROJECT_NAME".exe"

if [ $? -eq 0 ]; then
  echo "Build correct"
else
  echo "Error during building"
  exit 1
fi