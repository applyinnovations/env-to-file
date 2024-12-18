#!/bin/bash

# Ensure the script fails if any command fails
set -e

# Read the list of variables from the VARS environment variable
IFS=',' read -ra VARIABLES <<< "$VARS"

# Iterate through the variables
for VAR in "${VARIABLES[@]}"; do
    # Convert variable name to uppercase (in case it's not already)
    VAR_UPPER=$(echo "$VAR" | tr '[:lower:]' '[:upper:]')

    # Construct the corresponding file path variable name
    FILE_VAR="${VAR_UPPER}_FILE"

    # Get the value of the environment variable
    VALUE_VAR_NAME="$VAR_UPPER"

    # Get the file path
    FILE_PATH_VAR_NAME="${FILE_VAR}"

    # Check if both value and file path exist
    if [[ -n "${!VALUE_VAR_NAME}" && -n "${!FILE_PATH_VAR_NAME}" ]]; then
        # Create the directory of the file if it doesn't exist
        mkdir -p "$(dirname "${!FILE_PATH_VAR_NAME}")"

        # Write the variable content to the specified file
        echo "${!VALUE_VAR_NAME}" > "${!FILE_PATH_VAR_NAME}"

	# Make readable by all users
	chmod 644 "${!FILE_PATH_VAR_NAME}"

        echo "Wrote to ${!FILE_PATH_VAR_NAME}"
    else
        if [[ -z "${!VALUE_VAR_NAME}" ]]; then
            echo "Warning: No value found for $VAR_UPPER"
        fi
        if [[ -z "${!FILE_PATH_VAR_NAME}" ]]; then
            echo "Warning: No file path found for $FILE_VAR"
        fi
    fi
done

echo "All environment variables to written to corresponding files."
