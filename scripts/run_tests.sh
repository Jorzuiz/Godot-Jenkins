#!/bin/sh

# Define variables
godot_executable="/path/to/godot_executable"
output_path="../tests"
project_path="../project_repository/project_name" 

#Program: Checks if Godot exits in your server in the route you provided
#         Then run the tests

echo "Checking if Godot executable exists at: $godot_executable"
if [ -f "$godot_executable" ]; then
    echo "Godot executable found. Running tests..."
    # Run the tests if any
    $godot_executable" --headless --path "$project_path" --run-tests > "$output_path/test_results.txt"

else
    echo "Godot executable not found: $godot_executable"
    echo "Listing contents of directory:"
    ls "$(dirname "$godot_executable")"
    exit 1
fi