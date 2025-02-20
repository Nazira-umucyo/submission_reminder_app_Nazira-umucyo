#!/bin/bash

# ask for user's name
read -p "Enter a name you prefer: " userName

# Define main dir
num="submission_reminder_${userName}"

# Create directory one by one
mkdir -p "$num/config"
mkdir -p "$num/modules"
mkdir -p "$num/app"
mkdir -p "$num/assets"

# Create needed files
touch "$num/config/config.env"
touch "$num/assets/submissions.txt"
touch "$num/app/reminder.sh"
touch "$num/modules/functions.sh"
touch "$num/startup.sh"


# config.env
cat << EOF > "$num/config/config.env"
# This is the config file
ASSIGNMENT="Shell Navigation"
DAYS_REMAINING=2
EOF

# submissions.txt with some student records
cat << EOF > "$num/assets/submissions.txt"
student, assignment, submission status
Chinemerem, Shell Navigation, not submitted
Chiagoziem, Git, submitted
Yannick, Shell Navigation, not submitted
Kamikaze, Shell Basics, submitted
Maria, Shell Navigation, not submitted
Harerimana, Shell Navigation, not submitted
Mbuguje, Shell Navigation, not submitted
Sam, Shell Navigation, submitted
EOF

# functions.sh
cat << 'EOF' > "$num/modules/functions.sh"
#!/bin/bash

# Function to read submissions file and output students who have not submitted
 
 function check_submissions {
    local submissions_file=$1
    echo "Checking submissions in $submissions_file"

    # Skip the header and iterate through the lines
    while IFS=, read -r student assignment status; do
        # Remove leading and trailing whitespace
        student=$(echo "$student" | xargs)
        assignment=$(echo "$assignment" | xargs)
        status=$(echo "$status" | xargs)

        # Check if assignment matches and status is 'not submitted'
        if [[ "$assignment" == "$ASSIGNMENT" && "$status" == "not submitted" ]]; then
            echo "Reminder: $student has not submitted the $ASSIGNMENT assignment!"
        fi
    done < <(tail -n +2 "$submissions_file") # Skip the header
}
EOF

# reminder.sh
cat << 'EOF' > "$num/app/reminder.sh"
#!/bin/bash
#!/bin/bash

# Source environment variables and helper functions
source ./config/config.env
source ./modules/functions.sh

# Path to the submissions file
submissions_file="./assets/submissions.txt"

# Print remaining time and run the reminder function
echo "Assignment: $ASSIGNMENT"
echo "Days remaining to submit: $DAYS_REMAINING days"
echo "--------------------------------------------"

check_submissions $submissions_file
EOF

# startup.sh
cat << 'EOF' > "$num/startup.sh"
#!/bin/bash
echo "Starting Submission Reminder App..."
./app/reminder.sh
EOF

# execute the scripts
chmod +x "$num/modules/functions.sh"
chmod +x "$num/startup.sh"
chmod +x "$num/app/reminder.sh"
