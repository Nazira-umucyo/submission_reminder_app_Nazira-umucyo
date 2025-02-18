#!/bin/bash

# Ask for user input (your name)
read -p "Enter your name: " name

# Create the main directory
mkdir "submission_reminder_$name"

# Create subdirectories
mkdir -p "submission_reminder_$name/app"
mkdir -p "submission_reminder_$name/modules"
mkdir -p "submission_reminder_$name/assets"
mkdir -p "submission_reminder_$name/config"

# Move the downloaded files into their respective directories
mv reminder.sh "submission_reminder_$name/app/"
mv functions.sh "submission_reminder_$name/modules/"
mv config.env "submission_reminder_$name/config/"
mv submissions.txt "submission_reminder_$name/assets/"

# Create the startup.sh script (this is the missing file)
cat << 'EOF' > "submission_reminder_$name/startup.sh"
#!/bin/bash
# This script will start up the reminder app

echo "Starting the submission reminder app..."
# Add more startup logic as needed
EOF

# Make startup.sh executable
chmod +x "submission_reminder_$name/startup.sh"

echo "Environment setup complete."
