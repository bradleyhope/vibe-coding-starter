#!/bin/bash

# Vibe Coding Project Initialization Script
# This script sets up a new vibe coding project from templates

set -e  # Exit on error

# Colors for output
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
BLUE='\033[0;34m'
NC='\033[0m' # No Color

# Helper functions
log_info() {
    echo -e "${BLUE}ℹ${NC} $1"
}

log_success() {
    echo -e "${GREEN}✓${NC} $1"
}

log_warning() {
    echo -e "${YELLOW}⚠${NC} $1"
}

log_error() {
    echo -e "${RED}✗${NC} $1"
}

# Welcome message
echo ""
echo "╔════════════════════════════════════════════════════════╗"
echo "║                                                        ║"
echo "║        Vibe Coding Project Initialization              ║"
echo "║                                                        ║"
echo "╚════════════════════════════════════════════════════════╝"
echo ""

# Check if we're in the right directory
if [ ! -f "README.md" ] || [ ! -d "templates" ]; then
    log_error "This script must be run from the vibe-coding-starter directory"
    exit 1
fi

# Prompt for project information
log_info "Let's set up your new vibe coding project!"
echo ""

read -p "Project name (lowercase-with-dashes): " PROJECT_NAME
read -p "Project title (Human Readable): " PROJECT_TITLE
read -p "Brief description: " PROJECT_DESC
read -p "Your name: " AUTHOR_NAME
read -p "Your email: " AUTHOR_EMAIL

# Validate project name
if [[ ! $PROJECT_NAME =~ ^[a-z0-9-]+$ ]]; then
    log_error "Project name must be lowercase with dashes only"
    exit 1
fi

# Create planning directory
PLANNING_DIR="planning"
log_info "Creating planning directory structure..."

mkdir -p "$PLANNING_DIR"
mkdir -p "$PLANNING_DIR/wireframes"
mkdir -p "$PLANNING_DIR/assets"

log_success "Directory structure created"

# Copy templates to planning directory
log_info "Copying templates..."

cp templates/PRD.md "$PLANNING_DIR/PRD.md"
cp templates/DATABASE_SCHEMA.md "$PLANNING_DIR/DATABASE_SCHEMA.md"
cp templates/TECHNICAL_SPEC.md "$PLANNING_DIR/TECHNICAL_SPEC.md"
cp templates/WIREFRAMES.md "$PLANNING_DIR/WIREFRAMES.md"
cp templates/SETUP_NOTES.md "$PLANNING_DIR/SETUP_NOTES.md"
cp templates/MANUS_PROMPT.md "$PLANNING_DIR/MANUS_PROMPT.md"

log_success "Templates copied"

# Replace placeholders in templates
log_info "Customizing templates with your project information..."

DATE=$(date +"%B %d, %Y")

# Function to replace placeholders in a file
replace_placeholders() {
    local file=$1
    
    # macOS (BSD) sed requires different syntax than GNU sed
    if [[ "$OSTYPE" == "darwin"* ]]; then
        sed -i '' "s/\[Your Project Name\]/$PROJECT_TITLE/g" "$file"
        sed -i '' "s/\[Date\]/$DATE/g" "$file"
        sed -i '' "s/\[Your Name\]/$AUTHOR_NAME/g" "$file"
    else
        sed -i "s/\[Your Project Name\]/$PROJECT_TITLE/g" "$file"
        sed -i "s/\[Date\]/$DATE/g" "$file"
        sed -i "s/\[Your Name\]/$AUTHOR_NAME/g" "$file"
    fi
}

# Replace placeholders in all planning documents
for file in "$PLANNING_DIR"/*.md; do
    replace_placeholders "$file"
done

log_success "Templates customized"

# Create README for the project
log_info "Creating project README..."

cat > README.md << EOF
# $PROJECT_TITLE - Planning Repository

$PROJECT_DESC

## Overview

This repository contains all planning documents for the $PROJECT_TITLE project. These documents serve as the single source of truth for requirements, design, and technical specifications.

## Project Information

- **Project Name:** $PROJECT_NAME
- **Created:** $DATE
- **Author:** $AUTHOR_NAME
- **Status:** Planning Phase

## Planning Documents

All planning documents are in the \`planning/\` directory:

- **PRD.md** - Product Requirements Document
- **DATABASE_SCHEMA.md** - Database design and schema
- **TECHNICAL_SPEC.md** - Technical specifications and architecture
- **WIREFRAMES.md** - UI/UX designs and wireframes
- **SETUP_NOTES.md** - Infrastructure and environment setup
- **MANUS_PROMPT.md** - Comprehensive prompt for Manus AI

## Workflow

### 1. Complete Planning Documents

Fill out all documents in the \`planning/\` directory:

1. Start with **PRD.md** - Define what you're building
2. Create **wireframes** - Design the UI/UX
3. Design **DATABASE_SCHEMA.md** - Plan your data model
4. Complete **TECHNICAL_SPEC.md** - Choose your tech stack
5. Fill out **SETUP_NOTES.md** - Document infrastructure
6. Review **MANUS_PROMPT.md** - Ensure it's comprehensive

### 2. Review and Lock

Once all documents are complete:

\`\`\`bash
# Validate documents
./scripts/validate-docs.sh

# Commit and tag
git add planning/
git commit -m "Planning phase complete - LOCKED"
git tag -a v1.0-planning -m "Planning phase complete"
git push --tags
\`\`\`

### 3. Execute with Manus

Provide this prompt to Manus:

\`\`\`
I want to build $PROJECT_TITLE. All planning documents are in this GitHub repository:
[Your repository URL]

Please:
1. Clone the repository
2. Review all files in the planning/ directory
3. Start with planning/MANUS_PROMPT.md for complete instructions
4. Create a new repository for the code: $PROJECT_NAME-code
5. Build the complete project following the specifications
\`\`\`

### 4. Iterate

- Manus will create the execution repository
- Review the generated code
- Test functionality
- Iterate as needed (2-3 iterations expected)

## Document Status

| Document | Status | Last Updated |
|----------|--------|--------------|
| PRD | Draft | $DATE |
| Database Schema | Draft | $DATE |
| Technical Spec | Draft | $DATE |
| Wireframes | Draft | $DATE |
| Setup Notes | Draft | $DATE |
| Manus Prompt | Draft | $DATE |

## Notes

- Planning documents are LOCKED once approved
- Changes require agreement from all stakeholders
- Document all changes in CHANGELOG.md

## Resources

- [Vibe Coding Best Practices](https://github.com/bradleyhope/vibe-coding-starter/blob/main/docs/BEST_PRACTICES.md)
- [Manus Documentation](https://open.manus.ai/docs)
- [Project Workflow](https://github.com/bradleyhope/vibe-coding-starter/blob/main/WORKFLOW.md)

---

**Planning Repository** | **Execution Repository:** [To be created by Manus]
EOF

log_success "README created"

# Create CHANGELOG
log_info "Creating CHANGELOG..."

cat > CHANGELOG.md << EOF
# Changelog

All notable changes to the planning documents will be documented in this file.

## [1.0] - $DATE

### Added
- Initial planning documents created
- PRD with core requirements
- Database schema design
- Technical specifications
- UI/UX wireframes
- Setup and infrastructure notes
- Comprehensive Manus prompt

### Status
- Planning phase: In Progress
- All documents: Draft status
EOF

log_success "CHANGELOG created"

# Create .gitignore
log_info "Creating .gitignore..."

cat > .gitignore << EOF
# Environment variables (NEVER commit secrets!)
.env
.env.local
.env.*.local

# Secrets and credentials
planning/SETUP_NOTES.md.local
**/secrets/
**/*.pem
**/*.key

# OS files
.DS_Store
Thumbs.db

# Editor files
.vscode/
.idea/
*.swp
*.swo
*~

# Logs
*.log
logs/

# Temporary files
tmp/
temp/
*.tmp
EOF

log_success ".gitignore created"

# Create .env.example
log_info "Creating .env.example..."

cat > .env.example << EOF
# This is an example environment file
# Copy to .env.local and fill in actual values
# NEVER commit .env.local to version control

# Database
DATABASE_URL="postgresql://user:password@localhost:5432/dbname"

# Authentication
NEXTAUTH_SECRET="generate-with-openssl-rand-base64-32"
JWT_SECRET="generate-with-openssl-rand-base64-32"

# Add other environment variables as needed
EOF

log_success ".env.example created"

# Initialize git if not already initialized
if [ ! -d ".git" ]; then
    log_info "Initializing git repository..."
    git init
    git add .
    git commit -m "Initial commit: Project planning setup"
    log_success "Git repository initialized"
else
    log_warning "Git repository already exists, skipping initialization"
fi

# Final instructions
echo ""
echo "╔════════════════════════════════════════════════════════╗"
echo "║                                                        ║"
echo "║              Setup Complete! 🎉                        ║"
echo "║                                                        ║"
echo "╚════════════════════════════════════════════════════════╝"
echo ""
log_success "Project initialized successfully!"
echo ""
log_info "Next steps:"
echo ""
echo "  1. Complete all planning documents in planning/ directory"
echo "     - Start with planning/PRD.md"
echo "     - Create wireframes in planning/wireframes/"
echo "     - Design database schema in planning/DATABASE_SCHEMA.md"
echo "     - Complete technical spec in planning/TECHNICAL_SPEC.md"
echo "     - Document infrastructure in planning/SETUP_NOTES.md"
echo ""
echo "  2. Use ChatGPT to help refine your documents"
echo ""
echo "  3. Validate your documents:"
echo "     ./scripts/validate-docs.sh"
echo ""
echo "  4. Generate Manus prompt:"
echo "     ./scripts/generate-manus-prompt.sh"
echo ""
echo "  5. Commit and lock your planning:"
echo "     git add planning/"
echo "     git commit -m \"Planning phase complete - LOCKED\""
echo "     git tag -a v1.0-planning -m \"Planning complete\""
echo ""
echo "  6. Create GitHub repository and push:"
echo "     gh repo create $PROJECT_NAME-planning --private"
echo "     git remote add origin https://github.com/$AUTHOR_NAME/$PROJECT_NAME-planning"
echo "     git push -u origin main --tags"
echo ""
echo "  7. Start Manus with your planning repository URL"
echo ""
log_info "Happy vibe coding! 🚀"
echo ""
