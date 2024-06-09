# Windows build

PROJECT_NAME="Jueguico"
BUILD_DIR="./builds/$PROJECT_NAME"
GODOT_PATH="/path/to/godot"

# Limpia la build anterior
rm -rf $BUILD_DIR
#Crea directorio para la nueva build
mkdir -p $BUILD_DIR

./Godot_v4.2.2-stable_win64_console.exe --headless --path "First Person Shooter Template" --export-release "Windows Desktop" "../$BUILD_DIR/MyGame.exe"

echo "Build correct"