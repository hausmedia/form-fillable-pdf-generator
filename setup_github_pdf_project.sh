#!/bin/bash

# Script variables (edit these according to your project needs)
REPO_NAME="form-fillable-pdf-generator"
PYTHON_SCRIPT_NAME="generate_pdf.py"
GITHUB_USER="your-github-username"  # Replace with your GitHub username
DESCRIPTION="A form-fillable PDF generator using Python."
BRANCH="main"

# Step 1: Create GitHub repository using GitHub CLI
echo "Creating GitHub repository..."
gh repo create "$GITHUB_USER/$REPO_NAME" --public --description "$DESCRIPTION" --confirm
echo "Repository created successfully."

# Step 2: Initialize git, add Python files and push to GitHub
echo "Initializing git..."
git init
echo "Setting up the remote origin..."
git remote add origin "https://github.com/$GITHUB_USER/$REPO_NAME.git"
echo "Adding README and .gitignore..."
echo "# $REPO_NAME" > README.md
echo "venv/" > .gitignore

# Step 3: Add the Python dependencies to requirements.txt
echo "Creating requirements.txt..."
echo "fpdf" > requirements.txt
echo "pdfrw" >> requirements.txt
echo "PyPDF2" >> requirements.txt

# Step 4: Add the Python script for generating PDFs
echo "Writing the Python script..."
cat << EOF > $PYTHON_SCRIPT_NAME
from fpdf import FPDF

def create_pdf():
    pdf = FPDF()
    pdf.add_page()
    pdf.set_font("Arial", size=12)
    pdf.cell(200, 10, txt="Form Fillable PDF", ln=True, align='C')
    pdf.output("form_fillable.pdf")
    print("PDF created successfully.")

if __name__ == "__main__":
    create_pdf()
EOF

# Step 5: Add a GitHub Actions workflow for automating the process
mkdir -p .github/workflows
echo "Adding GitHub Actions workflow..."
cat << EOF > .github/workflows/python-app.yml
name: Python PDF Form Generator

on:
  push:
    branches:
      - $BRANCH

jobs:
  build:
    runs-on: ubuntu-latest

    steps:
    - name: Checkout repository content
      uses: actions/checkout@v2

    - name: Set up Python
      uses: actions/setup-python@v2
      with:
        python-version: '3.x'

    - name: Install dependencies
      run: |
        python -m pip install --upgrade pip
        pip install -r requirements.txt

    - name: Run Python script to generate PDF
      run: |
        python $PYTHON_SCRIPT_NAME
EOF

# Step 6: Add all files to git, commit, and push
git add .
git commit -m "Initial commit: Added Python script and GitHub Actions workflow."
git branch -M $BRANCH
git push -u origin $BRANCH

echo "Project setup complete! Check the repository at: https://github.com/$GITHUB_USER/$REPO_NAME"

# Optional: Provide instructions for further use
echo "To run locally:"
echo "1. Clone the repo: git clone https://github.com/$GITHUB_USER/$REPO_NAME.git"
echo "2. Install dependencies: pip install -r requirements.txt"
echo "3. Run the Python script: python $PYTHON_SCRIPT_NAME"
