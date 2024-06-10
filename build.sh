# Windows build

PROJECT_NAME="Jueguico" # Nombre del ejecutable
BUILD_DIR="./builds/$PROJECT_NAME" # Ruta de la build
GODOT_PATH="/path/to/godot" # Ruta de godot

 # Limpia la build anterior
if [ -d "$BUILD_DIR" ]; then
    rm -rf $BUILD_DIR
fi
# Crea directorio para la nueva build
mkdir -p $BUILD_DIR

./Godot_v4.2.2-stable_win64_console.exe --headless --path "First Person Shooter Template" --export-release "Windows Desktop" "../$BUILD_DIR/MyGame.exe"

echo "Build correct"