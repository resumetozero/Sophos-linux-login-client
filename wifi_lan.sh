#!/bin/bash

# Sophos client start/stop script

# Application settings
APP_DIR="$HOME/caa_x64/bin"
APP="$APP_DIR/caa"
LOG_FILE="$APP_DIR/sophos.log"

# Function to check if Sophos application exists
check_app() {
    if [ ! -x "$APP" ]; then
        echo "Error: Sophos client not found at $APP or is not executable."
        exit 1
    fi
}

# Start function
start() {
   # echo "Starting Sophos client..."

    # Check if Sophos application exists
    check_app

    # Start Sophos client, overwrite output to log file with timestamp
    if pgrep -f "$APP" > /dev/null; then
        echo "Sophos client is already running."
    else
        # Write timestamp to log file first, then start the app
        echo "=== Sophos client started at $(date '+%Y-%m-%d %H:%M:%S') ===" >> "$LOG_FILE"
        "$APP" -d >> "$LOG_FILE" 2>&1 &
        if [ $? -eq 0 ]; then
            echo "Sophos client started successfully. Output logged to $LOG_FILE."
        else
            echo "Error: Failed to start Sophos client."
            exit 1
        fi
    fi
}

# Stop function
stop() {
   # echo "Stopping Sophos client..."

    # Check if Sophos application is running
    if ! pgrep -f "$APP" > /dev/null; then
        echo "Sophos client is not running."
    else
        # Stop Sophos client by killing the process
        pkill -f "$APP"
        if [ $? -eq 0 ]; then
            echo "Sophos client stopped successfully."
        else
            echo "Error: Failed to stop Sophos client."
            exit 1
        fi
    fi
}

# Main script logic
case "$1" in
    start)
        start
        ;;
    stop)
        stop
        ;;
    *)
        echo "Usage: $0 {start|stop}"
        exit 1
        ;;
esac

exit 0
