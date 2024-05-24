#!/bin/bash
# Display logo
cat logo.txt
# Function to run Cors_Discovery.sh
run_Cors_Discovery() {
    ./Cors_Discovery.sh
}

# Function to run Cors_Discovery-2.sh
run_Cors_Discovery_2() {
    ./Cors_Discovery-2.sh
}

# Ask user if they have the target cookie
read -p "Do you have the target cookie? (yes/no/exit): " answer

# Check user's answer
case $answer in
    yes)
        run_Cors_Discovery
        ;;
    no)
        run_Cors_Discovery_2
        ;;
    exit)
        echo "Exiting the program."
        exit 0
        ;;
    *)
        echo "Invalid input. Please enter 'yes', 'no', or 'exit'."
        ;;
esac
