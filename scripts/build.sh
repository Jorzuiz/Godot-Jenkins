#!/bin/sh

# Define variables
godot_executable="/path/to/godot_executable"
export_preset="Windows Desktop"
output_path="../builds/build.exe"
project_path="../project_repository/project_name" 

#Program: Checks if Godot exits in your server in the route you provided
#         Then builds the project build in the output path 

echo "Checking if Godot executable exists at: $godot_executable"
if [ -f "$godot_executable" ]; then
    echo "Godot executable found. Starting build..."
    "$godot_executable" --headless --path "$project_path" --export "$export_preset" "$output_path"
else
    echo "Godot executable not found: $godot_executable"
    echo "Listing contents of directory:"
    ls "$(dirname "$godot_executable")"
    exit 1
fi