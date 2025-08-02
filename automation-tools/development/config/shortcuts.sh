#!/bin/bash

# =============================================================================
# Development Utilities Script
# Source this file in your .bashrc to have access to these utilities
# =============================================================================

# Environment Variables
export SOFTWARE_BLUEPRINT_ROOT="/Users/filzak/Developer/SoftwareBlueprint"
export AUTOMATION_TOOLS_DIR="$SOFTWARE_BLUEPRINT_ROOT/automation-tools"
export MODULE_COLLECTION_DIR="$SOFTWARE_BLUEPRINT_ROOT/ModuleCollection"

# Add automation tools to PATH
export PATH="$AUTOMATION_TOOLS_DIR/development/scripts:$PATH"

# Development Aliases
alias sb="cd $SOFTWARE_BLUEPRINT_ROOT"
alias at="cd $AUTOMATION_TOOLS_DIR"
alias mc="cd $MODULE_COLLECTION_DIR"
alias dev="cd $AUTOMATION_TOOLS_DIR/development"
alias manu="cd $AUTOMATION_TOOLS_DIR/manufacturing"
alias verify="cd $AUTOMATION_TOOLS_DIR/verification"

# Quick navigation aliases
alias config="cd $AUTOMATION_TOOLS_DIR/development/config"
alias deploy="cd $AUTOMATION_TOOLS_DIR/manufacturing/deploy"
alias setup="cd $AUTOMATION_TOOLS_DIR/manufacturing/setup"

# Utility Functions

# Function to find files in the project
find_in_project() {
    if [ -z "$1" ]; then
        echo "Usage: find_in_project <filename>"
        return 1
    fi
    find "$SOFTWARE_BLUEPRINT_ROOT" -name "$1" -type f
}

# Function to search for text in project files
grep_in_project() {
    if [ -z "$1" ]; then
        echo "Usage: grep_in_project <search_term>"
        return 1
    fi
    grep -r "$1" "$SOFTWARE_BLUEPRINT_ROOT" --exclude-dir=.git
}

# Function to show project structure
show_structure() {
    if [ -z "$1" ]; then
        tree "$SOFTWARE_BLUEPRINT_ROOT" -I '.git|__pycache__|*.pyc'
    else
        tree "$1" -I '.git|__pycache__|*.pyc'
    fi
}

# Function to run development scripts
run_dev_script() {
    if [ -z "$1" ]; then
        echo "Usage: run_dev_script <script_name>"
        echo "Available scripts:"
        ls "$AUTOMATION_TOOLS_DIR/development/scripts" 2>/dev/null || echo "No scripts directory found"
        return 1
    fi
    local script_path="$AUTOMATION_TOOLS_DIR/development/scripts/$1"
    if [ -f "$script_path" ]; then
        bash "$script_path"
    else
        echo "Script not found: $script_path"
        return 1
    fi
}

# Function to check project health
check_project_health() {
    echo "=== Software Blueprint Project Health Check ==="
    echo "Root directory: $SOFTWARE_BLUEPRINT_ROOT"
    echo "Automation tools: $AUTOMATION_TOOLS_DIR"
    echo "Module collection: $MODULE_COLLECTION_DIR"
    echo ""
    echo "Directory structure:"
    show_structure | head -20
    echo "..."
}

# Function to create new module
create_module() {
    if [ -z "$1" ]; then
        echo "Usage: create_module <module_name>"
        return 1
    fi
    local module_dir="$MODULE_COLLECTION_DIR/$1"
    mkdir -p "$module_dir"
    echo "Created module directory: $module_dir"
    echo "You can now add your module files to: $module_dir"
}

# Export functions so they're available in shell
export -f find_in_project
export -f grep_in_project
export -f show_structure
export -f run_dev_script
export -f check_project_health
export -f create_module

echo "Software Blueprint utilities loaded successfully!"
echo "Use 'check_project_health' to see available commands."
