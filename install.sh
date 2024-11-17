# Step 1: Download the executable
echo "Downloading the executable from $EXECUTABLE_URL..."
curl -o "$INSTALL_PATH" "$EXECUTABLE_URL"

# Step 2: Make the executable file executable
chmod +x "$INSTALL_PATH"

# Step 3: Create a systemd service file
SERVICE_FILE="/etc/systemd/system/$SERVICE_NAME.service"

echo "Creating systemd service file at $SERVICE_FILE..."
cat <<EOL > "$SERVICE_FILE"
[Unit]
Description=Your Custom Service
After=network.target

[Service]
ExecStart=$INSTALL_PATH
Restart=always
User=root

[Install]
WantedBy=multi-user.target
EOL

# Step 4: Reload systemd, enable, and start the service
echo "Reloading systemd manager configuration..."
systemctl daemon-reload

echo "Enabling $SERVICE_NAME service to start on boot..."
systemctl enable "$SERVICE_NAME"

echo "Starting $SERVICE_NAME service..."
systemctl start "$SERVICE_NAME"

echo "Service $SERVICE_NAME setup completed."