#!/bin/bash

# Sophos client start/stop script with credential prompt

APP_DIR="$HOME/caa_x64/bin"
APP="$APP_DIR/caa"
LOG_FILE="$APP_DIR/sophos.log"
CONF_FILE="$HOME/.caa/caa.conf"

check_app() {
    if [ ! -x "$APP" ]; then
        echo "❌ Error: Sophos client not found at $APP or is not executable."
        exit 1
    fi
}

create_config() {
    mkdir -p "$HOME/.caa"

    echo "🔑 Enter your Sophos username:"
    read USERNAME

    echo "🔐 Enter your Sophos password:"
    read -s PASSWORD   # hidden input

    cat > "$CONF_FILE" <<EOF
Copernicus host: 192.168.1.1
Username: $USERNAME
Password: $PASSWORD
EOF

    echo "✅ Credentials saved to $CONF_FILE"
}

start() {
    check_app

    # If no config or forced reset, prompt for credentials
    if [ ! -f "$CONF_FILE" ]; then
        create_config
    fi

    if pgrep -f "$APP" > /dev/null; then
        echo "⚠️ Sophos client is already running."
    else
        echo "=== Sophos client started at $(date '+%Y-%m-%d %H:%M:%S') ===" >> "$LOG_FILE"
        "$APP" -d >> "$LOG_FILE" 2>&1 &
        sleep 2
        if pgrep -f "$APP" > /dev/null; then
            echo "✅ Sophos client started successfully. Output logged to $LOG_FILE."
        else
            echo "❌ Failed to start Sophos client. Check $LOG_FILE for details."
        fi
    fi
}

stop() {
    if ! pgrep -f "$APP" > /dev/null; then
        echo "⚠️ Sophos client is not running."
    else
        pkill -f "$APP"
        echo "🛑 Sophos client stopped."
    fi
}

reset() {
    echo "🗑 Removing old credentials..."
    rm -f "$CONF_FILE"
    echo "✅ Credentials cleared. Run 'wifi_lan.sh start' to re-enter them."
}

case "$1" in
    start)
        start
        ;;
    stop)
        stop
        ;;
    reset)
        reset
        ;;
    *)
        echo "Usage: $0 {start|stop|reset}"
        exit 1
        ;;
esac

