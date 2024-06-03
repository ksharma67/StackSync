#!/bin/bash

# This script downloads dependencies for your Python script execution service

# Install pandas and numpy
/usr/bin/python3 -m pip install pandas numpy

# Create a requirements.txt file (optional)
echo "pandas==1.3.0" > requirements.txt
echo "numpy==1.21.0" >> requirements.txt

# Install requirements
/usr/bin/python3 -m pip install -r requirements.txt

# Clean up
rm requirements.txt

# Exit with success
exit 0
