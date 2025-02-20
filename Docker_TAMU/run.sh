#!/bin/bash

# Enable strict mode for error handling
set -e

# Function to handle termination signals
graceful_exit() {
    echo "Received termination signal. Exiting gracefully..."
    exit 0
}

# Trap termination signals
trap graceful_exit SIGTERM SIGINT

# Execute the main process
exec "$@"