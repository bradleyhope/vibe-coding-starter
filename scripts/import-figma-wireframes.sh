#!/bin/bash

# Figma Wireframes Import Script
# Imports wireframes from Figma file into planning/wireframes/ directory

set -e

# Colors
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
BLUE='\033[0;34m'
NC='\033[0m'

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

# Header
echo ""
echo "╔════════════════════════════════════════════════════════╗"
echo "║                                                        ║"
echo "║        Import Figma Wireframes                        ║"
echo "║                                                        ║"
echo "╚════════════════════════════════════════════════════════╝"
echo ""

# Check for required tools
if ! command -v curl &> /dev/null; then
    log_error "curl is required but not installed"
    exit 1
fi

if ! command -v jq &> /dev/null; then
    log_error "jq is required but not installed. Install with: sudo apt install jq (Linux) or brew install jq (macOS)"
    exit 1
fi

# Check for environment variables
if [ -f ".env.local" ]; then
    source .env.local
fi

# Prompt for Figma access token if not set
if [ -z "$FIGMA_ACCESS_TOKEN" ]; then
    echo ""
    log_warning "Figma access token not found in .env.local"
    echo ""
    echo "To generate a Figma personal access token:"
    echo "1. Login to Figma (https://figma.com)"
    echo "2. Click account menu (top-left) → Settings"
    echo "3. Select Security tab"
    echo "4. Click 'Generate new token'"
    echo "5. Set scopes: file_content:read"
    echo "6. Copy the token (shown only once!)"
    echo ""
    read -p "Enter your Figma access token: " FIGMA_ACCESS_TOKEN
    
    if [ -z "$FIGMA_ACCESS_TOKEN" ]; then
        log_error "Access token is required"
        exit 1
    fi
    
    # Save to .env.local
    echo "" >> .env.local
    echo "# Figma Integration" >> .env.local
    echo "FIGMA_ACCESS_TOKEN=\"$FIGMA_ACCESS_TOKEN\"" >> .env.local
    log_success "Token saved to .env.local"
fi

# Prompt for Figma file URL
echo ""
read -p "Enter Figma file URL: " FIGMA_URL

if [ -z "$FIGMA_URL" ]; then
    log_error "Figma file URL is required"
    exit 1
fi

# Extract file key from URL
# URL format: https://www.figma.com/file/FILE_KEY/FILE_NAME or https://www.figma.com/design/FILE_KEY/FILE_NAME
FILE_KEY=$(echo "$FIGMA_URL" | grep -oP '(?<=/file/|/design/)[^/]+' | head -1)

if [ -z "$FILE_KEY" ]; then
    log_error "Could not extract file key from URL. Please check the URL format."
    exit 1
fi

log_success "File key: $FILE_KEY"

# Create wireframes directory
WIREFRAMES_DIR="planning/wireframes"
mkdir -p "$WIREFRAMES_DIR"

# Fetch file data from Figma API
log_info "Fetching file data from Figma..."
echo ""

FILE_DATA=$(curl -s -H "X-Figma-Token: $FIGMA_ACCESS_TOKEN" \
    "https://api.figma.com/v1/files/$FILE_KEY")

# Check for errors
if echo "$FILE_DATA" | jq -e '.err' > /dev/null 2>&1; then
    ERROR_MSG=$(echo "$FILE_DATA" | jq -r '.err')
    log_error "Figma API error: $ERROR_MSG"
    exit 1
fi

if echo "$FILE_DATA" | jq -e '.status == 403' > /dev/null 2>&1; then
    log_error "Authentication failed. Please check your access token."
    exit 1
fi

if echo "$FILE_DATA" | jq -e '.status == 404' > /dev/null 2>&1; then
    log_error "File not found. Please check the file URL."
    exit 1
fi

FILE_NAME=$(echo "$FILE_DATA" | jq -r '.name')
log_success "File found: $FILE_NAME"

# Extract all FRAME nodes (these are typically screens/wireframes)
log_info "Extracting frames from file..."
echo ""

# Get all canvas (page) nodes
PAGES=$(echo "$FILE_DATA" | jq -r '.document.children[] | @base64')

FRAME_IDS=()
FRAME_NAMES=()

for page in $PAGES; do
    PAGE_DATA=$(echo "$page" | base64 --decode)
    PAGE_NAME=$(echo "$PAGE_DATA" | jq -r '.name')
    
    log_info "Scanning page: $PAGE_NAME"
    
    # Get all frames in this page
    FRAMES=$(echo "$PAGE_DATA" | jq -r '.children[]? | select(.type == "FRAME") | @base64')
    
    for frame in $FRAMES; do
        FRAME_DATA=$(echo "$frame" | base64 --decode)
        FRAME_ID=$(echo "$FRAME_DATA" | jq -r '.id')
        FRAME_NAME=$(echo "$FRAME_DATA" | jq -r '.name')
        
        FRAME_IDS+=("$FRAME_ID")
        FRAME_NAMES+=("$FRAME_NAME")
        
        log_info "  Found frame: $FRAME_NAME (ID: $FRAME_ID)"
    done
done

echo ""

if [ ${#FRAME_IDS[@]} -eq 0 ]; then
    log_warning "No frames found in the file. Make sure your designs are in FRAME objects."
    exit 0
fi

log_success "Found ${#FRAME_IDS[@]} frames to export"
echo ""

# Export frames as images
log_info "Exporting frames as PNG images..."
echo ""

# Join frame IDs with commas
IDS_PARAM=$(IFS=,; echo "${FRAME_IDS[*]}")

# Request image exports
IMAGE_DATA=$(curl -s -H "X-Figma-Token: $FIGMA_ACCESS_TOKEN" \
    "https://api.figma.com/v1/images/$FILE_KEY?ids=$IDS_PARAM&format=png&scale=2")

# Check for errors
if echo "$IMAGE_DATA" | jq -e '.err' > /dev/null 2>&1; then
    ERROR_MSG=$(echo "$IMAGE_DATA" | jq -r '.err')
    log_error "Image export error: $ERROR_MSG"
    exit 1
fi

# Download each image
log_info "Downloading images..."
echo ""

INDEX=0
for frame_id in "${FRAME_IDS[@]}"; do
    FRAME_NAME="${FRAME_NAMES[$INDEX]}"
    
    # Get image URL for this frame
    IMAGE_URL=$(echo "$IMAGE_DATA" | jq -r ".images[\"$frame_id\"]")
    
    if [ "$IMAGE_URL" == "null" ] || [ -z "$IMAGE_URL" ]; then
        log_warning "  Skipping $FRAME_NAME (no image URL)"
        ((INDEX++))
        continue
    fi
    
    # Sanitize filename
    FILENAME=$(echo "$FRAME_NAME" | tr '[:upper:]' '[:lower:]' | tr ' ' '-' | tr -cd '[:alnum:]-')
    FILEPATH="$WIREFRAMES_DIR/${FILENAME}.png"
    
    # Download image
    curl -s -o "$FILEPATH" "$IMAGE_URL"
    
    if [ -f "$FILEPATH" ]; then
        log_success "  Downloaded: ${FILENAME}.png"
    else
        log_error "  Failed to download: $FRAME_NAME"
    fi
    
    ((INDEX++))
done

echo ""
log_success "Import complete! ${#FRAME_IDS[@]} wireframes saved to $WIREFRAMES_DIR/"
echo ""

# Update WIREFRAMES.md
log_info "Updating planning/WIREFRAMES.md..."

if [ -f "planning/WIREFRAMES.md" ]; then
    # Add wireframe references to the document
    echo "" >> planning/WIREFRAMES.md
    echo "## Imported Wireframes" >> planning/WIREFRAMES.md
    echo "" >> planning/WIREFRAMES.md
    echo "Imported from Figma: $FILE_NAME" >> planning/WIREFRAMES.md
    echo "File URL: $FIGMA_URL" >> planning/WIREFRAMES.md
    echo "Import Date: $(date +"%B %d, %Y")" >> planning/WIREFRAMES.md
    echo "" >> planning/WIREFRAMES.md
    
    INDEX=0
    for frame_id in "${FRAME_IDS[@]}"; do
        FRAME_NAME="${FRAME_NAMES[$INDEX]}"
        FILENAME=$(echo "$FRAME_NAME" | tr '[:upper:]' '[:lower:]' | tr ' ' '-' | tr -cd '[:alnum:]-')
        
        echo "### $FRAME_NAME" >> planning/WIREFRAMES.md
        echo "" >> planning/WIREFRAMES.md
        echo "![${FRAME_NAME}](wireframes/${FILENAME}.png)" >> planning/WIREFRAMES.md
        echo "" >> planning/WIREFRAMES.md
        echo "**Description:** [Add description of this screen]" >> planning/WIREFRAMES.md
        echo "" >> planning/WIREFRAMES.md
        echo "**Key Elements:**" >> planning/WIREFRAMES.md
        echo "- [Element 1]" >> planning/WIREFRAMES.md
        echo "- [Element 2]" >> planning/WIREFRAMES.md
        echo "" >> planning/WIREFRAMES.md
        echo "**User Interactions:**" >> planning/WIREFRAMES.md
        echo "- [Interaction 1]" >> planning/WIREFRAMES.md
        echo "- [Interaction 2]" >> planning/WIREFRAMES.md
        echo "" >> planning/WIREFRAMES.md
        echo "---" >> planning/WIREFRAMES.md
        echo "" >> planning/WIREFRAMES.md
        
        ((INDEX++))
    done
    
    log_success "WIREFRAMES.md updated with wireframe references"
fi

echo ""
echo "╔════════════════════════════════════════════════════════╗"
echo "║                                                        ║"
echo "║              Import Complete! 🎉                       ║"
echo "║                                                        ║"
echo "╚════════════════════════════════════════════════════════╝"
echo ""
log_info "Next steps:"
echo ""
echo "  1. Review wireframes in $WIREFRAMES_DIR/"
echo "  2. Update descriptions in planning/WIREFRAMES.md"
echo "  3. Continue with your planning documents"
echo ""
log_success "Happy planning! 🚀"
echo ""
