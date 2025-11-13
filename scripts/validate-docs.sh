#!/bin/bash

# Vibe Coding Planning Documents Validation Script
# Checks that all required planning documents are present and complete

set -e

# Colors
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
BLUE='\033[0;34m'
NC='\033[0m'

# Counters
ERRORS=0
WARNINGS=0
CHECKS=0

# Helper functions
log_info() {
    echo -e "${BLUE}ℹ${NC} $1"
}

log_success() {
    echo -e "${GREEN}✓${NC} $1"
    ((CHECKS++))
}

log_warning() {
    echo -e "${YELLOW}⚠${NC} $1"
    ((WARNINGS++))
}

log_error() {
    echo -e "${RED}✗${NC} $1"
    ((ERRORS++))
}

# Header
echo ""
echo "╔════════════════════════════════════════════════════════╗"
echo "║                                                        ║"
echo "║        Planning Documents Validation                   ║"
echo "║                                                        ║"
echo "╚════════════════════════════════════════════════════════╝"
echo ""

PLANNING_DIR="planning"

# Check if planning directory exists
if [ ! -d "$PLANNING_DIR" ]; then
    log_error "Planning directory not found. Run ./scripts/init-project.sh first"
    exit 1
fi

log_info "Validating planning documents..."
echo ""

# Required files
REQUIRED_FILES=(
    "PRD.md"
    "DATABASE_SCHEMA.md"
    "TECHNICAL_SPEC.md"
    "WIREFRAMES.md"
    "SETUP_NOTES.md"
    "MANUS_PROMPT.md"
)

# Check for required files
log_info "Checking required files..."
for file in "${REQUIRED_FILES[@]}"; do
    if [ -f "$PLANNING_DIR/$file" ]; then
        log_success "$file exists"
    else
        log_error "$file is missing"
    fi
done
echo ""

# Check PRD completeness
log_info "Validating PRD.md..."
PRD_FILE="$PLANNING_DIR/PRD.md"

if [ -f "$PRD_FILE" ]; then
    # Check for key sections
    if grep -q "## Problem Statement" "$PRD_FILE"; then
        log_success "PRD has Problem Statement section"
    else
        log_error "PRD missing Problem Statement section"
    fi
    
    if grep -q "## Core Features" "$PRD_FILE"; then
        log_success "PRD has Core Features section"
    else
        log_error "PRD missing Core Features section"
    fi
    
    if grep -q "## Success Metrics" "$PRD_FILE"; then
        log_success "PRD has Success Metrics section"
    else
        log_error "PRD missing Success Metrics section"
    fi
    
    # Check for placeholders
    if grep -q "\[.*\]" "$PRD_FILE"; then
        log_warning "PRD contains placeholders - please fill them in"
    else
        log_success "PRD has no placeholders"
    fi
    
    # Check status
    if grep -q "Status:.*Locked" "$PRD_FILE"; then
        log_success "PRD is locked"
    elif grep -q "Status:.*Approved" "$PRD_FILE"; then
        log_warning "PRD is approved but not locked"
    else
        log_warning "PRD is still in draft status"
    fi
fi
echo ""

# Check Database Schema completeness
log_info "Validating DATABASE_SCHEMA.md..."
SCHEMA_FILE="$PLANNING_DIR/DATABASE_SCHEMA.md"

if [ -f "$SCHEMA_FILE" ]; then
    if grep -q "## Entities" "$SCHEMA_FILE"; then
        log_success "Schema has Entities section"
    else
        log_error "Schema missing Entities section"
    fi
    
    if grep -q "CREATE TABLE" "$SCHEMA_FILE"; then
        log_success "Schema includes SQL definitions"
    else
        log_warning "Schema missing SQL definitions"
    fi
    
    if grep -q "## Migrations Strategy" "$SCHEMA_FILE"; then
        log_success "Schema has Migrations Strategy"
    else
        log_warning "Schema missing Migrations Strategy"
    fi
    
    # Check for placeholders
    if grep -q "\[.*\]" "$SCHEMA_FILE"; then
        log_warning "Schema contains placeholders - please fill them in"
    else
        log_success "Schema has no placeholders"
    fi
fi
echo ""

# Check Technical Spec completeness
log_info "Validating TECHNICAL_SPEC.md..."
TECH_FILE="$PLANNING_DIR/TECHNICAL_SPEC.md"

if [ -f "$TECH_FILE" ]; then
    if grep -q "## Technology Stack" "$TECH_FILE"; then
        log_success "Tech Spec has Technology Stack section"
    else
        log_error "Tech Spec missing Technology Stack section"
    fi
    
    if grep -q "## System Architecture" "$TECH_FILE"; then
        log_success "Tech Spec has System Architecture section"
    else
        log_error "Tech Spec missing System Architecture section"
    fi
    
    if grep -q "## API Design" "$TECH_FILE"; then
        log_success "Tech Spec has API Design section"
    else
        log_error "Tech Spec missing API Design section"
    fi
    
    if grep -q "## Security" "$TECH_FILE"; then
        log_success "Tech Spec has Security section"
    else
        log_warning "Tech Spec missing Security section"
    fi
    
    # Check for placeholders
    if grep -q "\[.*\]" "$TECH_FILE"; then
        log_warning "Tech Spec contains placeholders - please fill them in"
    else
        log_success "Tech Spec has no placeholders"
    fi
fi
echo ""

# Check Wireframes
log_info "Validating WIREFRAMES.md..."
WIREFRAMES_FILE="$PLANNING_DIR/WIREFRAMES.md"

if [ -f "$WIREFRAMES_FILE" ]; then
    if grep -q "## Screen Layouts" "$WIREFRAMES_FILE"; then
        log_success "Wireframes has Screen Layouts section"
    else
        log_error "Wireframes missing Screen Layouts section"
    fi
    
    if grep -q "## Design System" "$WIREFRAMES_FILE"; then
        log_success "Wireframes has Design System section"
    else
        log_warning "Wireframes missing Design System section"
    fi
    
    # Check for wireframes directory
    if [ -d "$PLANNING_DIR/wireframes" ]; then
        WIREFRAME_COUNT=$(find "$PLANNING_DIR/wireframes" -type f | wc -l)
        if [ "$WIREFRAME_COUNT" -gt 0 ]; then
            log_success "Found $WIREFRAME_COUNT wireframe file(s)"
        else
            log_warning "Wireframes directory is empty"
        fi
    else
        log_warning "Wireframes directory not found"
    fi
fi
echo ""

# Check Setup Notes
log_info "Validating SETUP_NOTES.md..."
SETUP_FILE="$PLANNING_DIR/SETUP_NOTES.md"

if [ -f "$SETUP_FILE" ]; then
    if grep -q "## Environment Variables" "$SETUP_FILE"; then
        log_success "Setup Notes has Environment Variables section"
    else
        log_error "Setup Notes missing Environment Variables section"
    fi
    
    if grep -q "## Service Setup Instructions" "$SETUP_FILE"; then
        log_success "Setup Notes has Service Setup Instructions"
    else
        log_warning "Setup Notes missing Service Setup Instructions"
    fi
    
    # Check for actual secrets (should not be committed)
    if grep -q "sk_live_\|pk_live_\|your-actual-" "$SETUP_FILE"; then
        log_error "Setup Notes contains actual secrets - remove them!"
    else
        log_success "Setup Notes does not contain actual secrets"
    fi
fi
echo ""

# Check Manus Prompt
log_info "Validating MANUS_PROMPT.md..."
MANUS_FILE="$PLANNING_DIR/MANUS_PROMPT.md"

if [ -f "$MANUS_FILE" ]; then
    if grep -q "## Project Overview" "$MANUS_FILE"; then
        log_success "Manus Prompt has Project Overview"
    else
        log_error "Manus Prompt missing Project Overview"
    fi
    
    if grep -q "## Core Features to Implement" "$MANUS_FILE"; then
        log_success "Manus Prompt has Core Features section"
    else
        log_error "Manus Prompt missing Core Features section"
    fi
    
    if grep -q "## Success Criteria" "$MANUS_FILE"; then
        log_success "Manus Prompt has Success Criteria"
    else
        log_warning "Manus Prompt missing Success Criteria"
    fi
    
    # Check for placeholders
    if grep -q "\[.*\]" "$MANUS_FILE"; then
        log_warning "Manus Prompt contains placeholders - please fill them in"
    else
        log_success "Manus Prompt has no placeholders"
    fi
fi
echo ""

# Check for .env files (should not be committed)
log_info "Checking for sensitive files..."
if [ -f ".env" ] || [ -f ".env.local" ]; then
    log_error "Found .env file(s) - these should not be committed!"
else
    log_success "No .env files found in repository"
fi

if [ -f ".env.example" ]; then
    log_success ".env.example exists for reference"
else
    log_warning ".env.example not found - consider creating one"
fi
echo ""

# Summary
echo "╔════════════════════════════════════════════════════════╗"
echo "║                                                        ║"
echo "║              Validation Summary                        ║"
echo "║                                                        ║"
echo "╚════════════════════════════════════════════════════════╝"
echo ""
echo "  Passed checks: $CHECKS"
echo "  Warnings: $WARNINGS"
echo "  Errors: $ERRORS"
echo ""

if [ $ERRORS -eq 0 ] && [ $WARNINGS -eq 0 ]; then
    log_success "All validation checks passed! 🎉"
    echo ""
    log_info "Your planning documents are ready for Manus!"
    echo ""
    log_info "Next steps:"
    echo "  1. Commit your planning documents"
    echo "  2. Tag as v1.0-planning"
    echo "  3. Push to GitHub"
    echo "  4. Provide the repository URL to Manus"
    echo ""
    exit 0
elif [ $ERRORS -eq 0 ]; then
    log_warning "Validation passed with $WARNINGS warning(s)"
    echo ""
    log_info "Consider addressing warnings before proceeding to Manus"
    echo ""
    exit 0
else
    log_error "Validation failed with $ERRORS error(s) and $WARNINGS warning(s)"
    echo ""
    log_info "Please fix errors before proceeding to Manus"
    echo ""
    exit 1
fi
