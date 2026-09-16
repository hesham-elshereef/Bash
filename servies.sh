#!/usr/bin/env bash
# $1 is the first argument passed to the script
# Example: ./service.sh start
ACTION="$1"

# Check if the user provided an action
if [ -z "$ACTION" ]; then
    echo "Error: No action provided."
    echo "Usage: $0 [start|stop|restart]"
    exit 1
fi

case "$ACTION" in
    start)
        echo "Starting the service..."
        # Place your systemctl start command here
        ;;
    stop)
        echo "Stopping the service..."
        # Place your systemctl stop command here
        ;;
    restart)
        echo "Restarting the service..."
        # Place your systemctl restart command here
        ;;
    *)
        echo "Error: Unknown action '$ACTION'."
        echo "Usage: $0 [start|stop|restart]"
        exit 1
        ;;
esac
echo "Done."
