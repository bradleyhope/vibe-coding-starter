#!/bin/bash

# Generate Comprehensive Manus Prompt
# This script combines all planning documents into one comprehensive Manus prompt

set -e

# Colors
GREEN='\033[0;32m'
BLUE='\033[0;34m'
NC='\033[0m'

log_info() {
    echo -e "${BLUE}ℹ${NC} $1"
}

log_success() {
    echo -e "${GREEN}✓${NC} $1"
}

echo ""
echo "╔════════════════════════════════════════════════════════╗"
echo "║                                                        ║"
echo "║        Generate Comprehensive Manus Prompt            ║"
echo "║                                                        ║"
echo "╚════════════════════════════════════════════════════════╝"
echo ""

PLANNING_DIR="planning"
OUTPUT_FILE="$PLANNING_DIR/MANUS_PROMPT_GENERATED.md"

# Check if planning directory exists
if [ ! -d "$PLANNING_DIR" ]; then
    echo "Error: Planning directory not found"
    exit 1
fi

log_info "Generating comprehensive Manus prompt from all planning documents..."
echo ""

# Start building the prompt
cat > "$OUTPUT_FILE" << 'EOF'
# Comprehensive Manus Build Prompt

**Generated from all planning documents**

---

## Project Overview

EOF

# Extract project name and description from PRD if available
if [ -f "$PLANNING_DIR/PRD.md" ]; then
    log_info "Extracting project overview from PRD..."
    
    # Extract project name
    PROJECT_NAME=$(grep "^**Project Name:**" "$PLANNING_DIR/PRD.md" | head -1 | sed 's/^**Project Name:** //')
    
    # Extract executive summary
    sed -n '/## Executive Summary/,/^##/p' "$PLANNING_DIR/PRD.md" | grep -v "^##" >> "$OUTPUT_FILE"
    
    echo "" >> "$OUTPUT_FILE"
    echo "**Project Name:** $PROJECT_NAME" >> "$OUTPUT_FILE"
    echo "" >> "$OUTPUT_FILE"
fi

# Add complete requirements section
cat >> "$OUTPUT_FILE" << 'EOF'

---

## Complete Requirements

All detailed requirements are in the planning documents in this repository:

1. **planning/PRD.md** - Complete product requirements with all features and acceptance criteria
2. **planning/DATABASE_SCHEMA.md** - Full database schema with all entities, relationships, and constraints
3. **planning/TECHNICAL_SPEC.md** - Technology stack, architecture, and technical decisions
4. **planning/WIREFRAMES.md** - UI/UX designs for all screens
5. **planning/SETUP_NOTES.md** - Infrastructure details, API keys, and environment configuration

---

## Technology Stack

EOF

# Extract technology stack from Technical Spec
if [ -f "$PLANNING_DIR/TECHNICAL_SPEC.md" ]; then
    log_info "Extracting technology stack..."
    sed -n '/## Technology Stack/,/^## /p' "$PLANNING_DIR/TECHNICAL_SPEC.md" | grep -v "^## Technology Stack" | grep -v "^## " >> "$OUTPUT_FILE"
    echo "" >> "$OUTPUT_FILE"
fi

# Add core features
cat >> "$OUTPUT_FILE" << 'EOF'

---

## Core Features to Implement

EOF

# Extract core features from PRD
if [ -f "$PLANNING_DIR/PRD.md" ]; then
    log_info "Extracting core features from PRD..."
    sed -n '/## Core Features/,/^## /p' "$PLANNING_DIR/PRD.md" | grep -v "^## Core Features" | grep -v "^## " >> "$OUTPUT_FILE"
    echo "" >> "$OUTPUT_FILE"
fi

# Add database implementation section
cat >> "$OUTPUT_FILE" << 'EOF'

---

## Database Implementation

Please implement the complete database schema from `planning/DATABASE_SCHEMA.md`.

### Key Requirements

1. Use the exact entity names and field names specified
2. Implement all relationships and constraints
3. Create all indexes for performance
4. Include seed data for development
5. Set up migrations properly

EOF

# Extract entity summary from database schema
if [ -f "$PLANNING_DIR/DATABASE_SCHEMA.md" ]; then
    log_info "Extracting database entities..."
    echo "### Entities Summary" >> "$OUTPUT_FILE"
    echo "" >> "$OUTPUT_FILE"
    grep "^### Entity [0-9]:" "$PLANNING_DIR/DATABASE_SCHEMA.md" | sed 's/### /- /' >> "$OUTPUT_FILE"
    echo "" >> "$OUTPUT_FILE"
fi

# Add API implementation section
cat >> "$OUTPUT_FILE" << 'EOF'

---

## API Implementation

Implement all API endpoints specified in `planning/TECHNICAL_SPEC.md`.

### Requirements

1. Implement proper authentication middleware
2. Add input validation using Zod or similar
3. Include comprehensive error handling
4. Return consistent response formats
5. Add rate limiting
6. Include proper HTTP status codes

EOF

# Extract API endpoints from technical spec
if [ -f "$PLANNING_DIR/TECHNICAL_SPEC.md" ]; then
    log_info "Extracting API endpoints..."
    sed -n '/### Endpoints/,/^## /p' "$PLANNING_DIR/TECHNICAL_SPEC.md" | grep -v "^## " >> "$OUTPUT_FILE"
    echo "" >> "$OUTPUT_FILE"
fi

# Add UI implementation section
cat >> "$OUTPUT_FILE" << 'EOF'

---

## UI/UX Implementation

Implement the UI based on wireframes in `planning/WIREFRAMES.md` and `planning/wireframes/` directory.

### Key Screens

EOF

# Extract screen layouts from wireframes
if [ -f "$PLANNING_DIR/WIREFRAMES.md" ]; then
    log_info "Extracting screen layouts..."
    grep "^### [0-9]\." "$PLANNING_DIR/WIREFRAMES.md" | sed 's/### /- /' >> "$OUTPUT_FILE"
    echo "" >> "$OUTPUT_FILE"
fi

cat >> "$OUTPUT_FILE" << 'EOF'

### UI Requirements

1. Responsive design (mobile, tablet, desktop)
2. Loading states for all async operations
3. Error states with user-friendly messages
4. Success feedback (toasts/notifications)
5. Form validation with inline errors
6. Accessible (ARIA labels, keyboard navigation)

EOF

# Add authentication section
cat >> "$OUTPUT_FILE" << 'EOF'

---

## Authentication & Authorization

Implement authentication as specified in `planning/TECHNICAL_SPEC.md`.

### Requirements

1. User registration with email verification
2. Login with email/password
3. JWT token-based authentication
4. Protected routes (redirect to login if not authenticated)
5. Role-based access control
6. Session management
7. Logout functionality

### Security

1. Hash passwords with bcrypt (cost factor 10)
2. Validate all inputs
3. Implement rate limiting on auth endpoints
4. Use secure HTTP-only cookies for tokens
5. Add CSRF protection

---

## Environment Configuration

Create `.env.example` with all required environment variables. Actual values are in `planning/SETUP_NOTES.md` (do not commit to git).

---

## Success Criteria

This project is complete when:

EOF

# Extract success criteria from PRD
if [ -f "$PLANNING_DIR/PRD.md" ]; then
    log_info "Extracting success criteria..."
    sed -n '/## Success Metrics/,/^## /p' "$PLANNING_DIR/PRD.md" | grep "^- \[ \]" >> "$OUTPUT_FILE"
    echo "" >> "$OUTPUT_FILE"
fi

# Add standard success criteria
cat >> "$OUTPUT_FILE" << 'EOF'

Standard completion criteria:

1. ✅ All must-have features from PRD are implemented
2. ✅ All acceptance criteria are met
3. ✅ Database schema is fully implemented
4. ✅ All API endpoints work correctly
5. ✅ UI matches wireframes and is responsive
6. ✅ Authentication and authorization work
7. ✅ Error handling is comprehensive
8. ✅ Code is well-documented
9. ✅ Basic tests are passing
10. ✅ Application runs locally without errors

---

## Out of Scope

EOF

# Extract non-goals from PRD
if [ -f "$PLANNING_DIR/PRD.md" ]; then
    log_info "Extracting non-goals..."
    sed -n '/### Non-Goals/,/^## /p' "$PLANNING_DIR/PRD.md" | grep "^[0-9]\." >> "$OUTPUT_FILE"
    echo "" >> "$OUTPUT_FILE"
fi

# Add execution instructions
cat >> "$OUTPUT_FILE" << 'EOF'

---

## Execution Instructions

Please:

1. **Review all planning documents** in the `planning/` directory
2. **Ask clarifying questions** if anything is unclear or ambiguous
3. **Create the project structure** as specified in planning/TECHNICAL_SPEC.md
4. **Implement all features** following the acceptance criteria
5. **Test as you build** to ensure everything works
6. **Document your work** in README and code comments
7. **Create a new repository** for the code (separate from this planning repo)
8. **Provide a summary** of what was built and any issues encountered

---

## Reference Documents

All detailed specifications are in:

- `planning/PRD.md` - Product requirements and acceptance criteria
- `planning/DATABASE_SCHEMA.md` - Complete database design
- `planning/TECHNICAL_SPEC.md` - Technical architecture and API design
- `planning/WIREFRAMES.md` - UI/UX designs and component specifications
- `planning/SETUP_NOTES.md` - Infrastructure, services, and environment setup

Please refer to these documents for complete details on every aspect of the implementation.

---

**Ready to start? Please confirm you've reviewed all planning documents and ask any clarifying questions before beginning implementation.**

EOF

log_success "Comprehensive Manus prompt generated!"
echo ""
log_info "Output file: $OUTPUT_FILE"
echo ""
log_info "This prompt combines all your planning documents into one comprehensive prompt for Manus."
log_info "You can use either this generated prompt or the template in MANUS_PROMPT.md"
echo ""
log_success "Done! 🎉"
echo ""
