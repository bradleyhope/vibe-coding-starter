# Figma Integration Guide

Complete guide to integrating Figma wireframes into your vibe coding planning workflow.

---

## Overview

The Figma integration allows you to automatically import wireframes from your Figma designs directly into your planning repository. This eliminates manual screenshot/export work and ensures your planning documents always reference the latest designs.

---

## Prerequisites

### Required Tools

- **jq** - JSON processor for parsing Figma API responses
  ```bash
  # macOS
  brew install jq
  
  # Linux (Ubuntu/Debian)
  sudo apt install jq
  
  # Linux (RHEL/CentOS)
  sudo yum install jq
  ```

- **curl** - HTTP client (usually pre-installed)

### Figma Account

You need a Figma account with access to the file you want to import.

---

## Step 1: Generate Figma Personal Access Token

### Why You Need This

A personal access token authenticates your API requests to Figma. It allows the script to read your Figma files and export images.

### How to Generate

1. **Login to Figma**
   - Go to https://figma.com and sign in

2. **Open Account Settings**
   - Click your account menu in the top-left corner
   - Select **Settings**

3. **Navigate to Security Tab**
   - Click the **Security** tab

4. **Generate New Token**
   - In the **Personal access tokens** section
   - Click **Generate new token**

5. **Configure Token**
   - **Name:** Give it a descriptive name (e.g., "Vibe Coding Import")
   - **Expiration:** Choose expiration period (or no expiration)
   - **Scopes:** Select `file_content:read` (required)
   - Optional: `file_variables:read` (for design tokens)

6. **Copy Token**
   - Click **Generate token**
   - **⚠️ IMPORTANT:** Copy the token immediately
   - This is your only chance to see it!
   - Store it securely (password manager recommended)

7. **Security Best Practices**
   - Never commit tokens to git
   - Store in `.env.local` (git-ignored)
   - Rotate tokens periodically
   - Revoke immediately if compromised

### Token Management

From the Security tab, you can:
- View when tokens were last used
- See what scopes each token has (hover over name)
- Revoke tokens instantly

If you see unexpected activity on a token, revoke it immediately.

---

## Step 2: Prepare Your Figma File

### File Structure

For best results, organize your Figma file like this:

```
Figma File
├── Page 1: Wireframes
│   ├── Frame: Landing Page
│   ├── Frame: Login Screen
│   ├── Frame: Dashboard
│   └── Frame: Settings
├── Page 2: Components
│   └── (Components library)
└── Page 3: Design System
    └── (Colors, typography, etc.)
```

### Frame Naming

The script exports **FRAME** objects as wireframes. Name your frames clearly:

**Good names:**
- "Landing Page"
- "User Dashboard"
- "Login Screen"
- "Settings - Profile Tab"

**Avoid:**
- "Frame 1"
- "Untitled"
- Special characters: `/ \ : * ? " < > |`

Frame names become filenames, so use descriptive, filesystem-safe names.

### Design Tips

- **Use Frames, not Groups:** Only FRAME objects are exported
- **One screen per Frame:** Each frame should represent one complete screen
- **Consistent sizing:** Use consistent artboard sizes (e.g., 1440x900 for desktop, 375x812 for mobile)
- **Visible layers:** Hidden layers won't be exported

---

## Step 3: Get Your Figma File URL

### Where to Find It

1. Open your Figma file
2. Copy the URL from your browser's address bar

### URL Format

Figma URLs look like this:

```
https://www.figma.com/file/FILE_KEY/FILE_NAME
```

or

```
https://www.figma.com/design/FILE_KEY/FILE_NAME
```

**Example:**
```
https://www.figma.com/file/abc123xyz/My-Awesome-App-Wireframes
```

The script automatically extracts the `FILE_KEY` (e.g., `abc123xyz`) from the URL.

### File Access

Make sure:
- You have view access to the file
- The file is not in a restricted team (or your token has team access)
- The file exists and is not deleted

---

## Step 4: Run the Import Script

### Basic Usage

```bash
cd your-project-planning
./scripts/import-figma-wireframes.sh
```

### What Happens

1. **Check for token**
   - If not found in `.env.local`, prompts you to enter it
   - Saves token to `.env.local` for future use

2. **Request Figma file URL**
   - Paste your Figma file URL
   - Script extracts the file key

3. **Fetch file data**
   - Connects to Figma API
   - Retrieves file structure
   - Identifies all FRAME objects

4. **Export images**
   - Requests PNG exports at 2x scale
   - Downloads each frame as a separate image
   - Saves to `planning/wireframes/`

5. **Update documentation**
   - Adds wireframe references to `planning/WIREFRAMES.md`
   - Includes placeholders for descriptions

### Example Session

```bash
$ ./scripts/import-figma-wireframes.sh

╔════════════════════════════════════════════════════════╗
║                                                        ║
║        Import Figma Wireframes                        ║
║                                                        ║
╚════════════════════════════════════════════════════════╝

⚠ Figma access token not found in .env.local

To generate a Figma personal access token:
1. Login to Figma (https://figma.com)
2. Click account menu (top-left) → Settings
3. Select Security tab
4. Click 'Generate new token'
5. Set scopes: file_content:read
6. Copy the token (shown only once!)

Enter your Figma access token: figd_xxxxxxxxxxxxxxxxxxxxxxxxxxxxx
✓ Token saved to .env.local

Enter Figma file URL: https://www.figma.com/file/abc123xyz/My-App-Wireframes
✓ File key: abc123xyz

ℹ Fetching file data from Figma...

✓ File found: My App Wireframes

ℹ Extracting frames from file...

ℹ Scanning page: Wireframes
ℹ   Found frame: Landing Page (ID: 1:2)
ℹ   Found frame: Dashboard (ID: 1:3)
ℹ   Found frame: Settings (ID: 1:4)

✓ Found 3 frames to export

ℹ Exporting frames as PNG images...

ℹ Downloading images...

✓   Downloaded: landing-page.png
✓   Downloaded: dashboard.png
✓   Downloaded: settings.png

✓ Import complete! 3 wireframes saved to planning/wireframes/

ℹ Updating planning/WIREFRAMES.md...
✓ WIREFRAMES.md updated with wireframe references

╔════════════════════════════════════════════════════════╗
║                                                        ║
║              Import Complete! 🎉                       ║
║                                                        ║
╚════════════════════════════════════════════════════════╝

ℹ Next steps:

  1. Review wireframes in planning/wireframes/
  2. Update descriptions in planning/WIREFRAMES.md
  3. Continue with your planning documents

✓ Happy planning! 🚀
```

---

## Step 5: Review and Document

### Check Imported Wireframes

```bash
ls planning/wireframes/
```

You should see PNG files for each frame:
```
landing-page.png
dashboard.png
settings.png
```

### Update WIREFRAMES.md

The script adds sections like this to `planning/WIREFRAMES.md`:

```markdown
## Imported Wireframes

Imported from Figma: My App Wireframes
File URL: https://www.figma.com/file/abc123xyz/My-App-Wireframes
Import Date: November 13, 2025

### Landing Page

![Landing Page](wireframes/landing-page.png)

**Description:** [Add description of this screen]

**Key Elements:**
- [Element 1]
- [Element 2]

**User Interactions:**
- [Interaction 1]
- [Interaction 2]

---
```

**Fill in the placeholders:**

```markdown
### Landing Page

![Landing Page](wireframes/landing-page.png)

**Description:** The main entry point for new and returning users. Features hero section with value proposition, key features overview, and clear call-to-action.

**Key Elements:**
- Hero section with headline and subheadline
- Three-column feature showcase
- Testimonials carousel
- Primary CTA button: "Get Started"
- Secondary CTA: "Learn More"
- Navigation bar with logo and menu

**User Interactions:**
- Click "Get Started" → Navigate to signup page
- Click "Learn More" → Scroll to features section
- Click menu items → Navigate to respective pages
- Hover over features → Show additional details
```

---

## Troubleshooting

### Error: "jq: command not found"

**Solution:** Install jq

```bash
# macOS
brew install jq

# Linux
sudo apt install jq
```

### Error: "Authentication failed"

**Causes:**
- Invalid or expired token
- Token doesn't have required scopes

**Solution:**
1. Generate new token with `file_content:read` scope
2. Update `.env.local` with new token
3. Run script again

### Error: "File not found"

**Causes:**
- Incorrect file URL
- No access to the file
- File was deleted

**Solution:**
1. Verify you can open the file in Figma
2. Check the URL is correct
3. Ensure you have at least view access

### Error: "No frames found"

**Causes:**
- Designs are in GROUP objects, not FRAME objects
- Frames are nested too deep
- File only contains components

**Solution:**
1. In Figma, select your designs
2. Right-click → Frame Selection (or press Cmd/Ctrl + Alt + G)
3. This converts groups to frames
4. Run import script again

### Images Don't Download

**Causes:**
- Frames are invisible (0% opacity)
- Frames are too large (>32 megapixels)
- Network issues

**Solution:**
1. Check frame visibility in Figma
2. Reduce frame size if needed
3. Check internet connection
4. Try again

---

## Advanced Usage

### Custom Token Storage

If you prefer not to use `.env.local`, you can set the environment variable manually:

```bash
export FIGMA_ACCESS_TOKEN="your_token_here"
./scripts/import-figma-wireframes.sh
```

### Batch Import from Multiple Files

Create a script to import from multiple Figma files:

```bash
#!/bin/bash

# Import from multiple Figma files

FIGMA_ACCESS_TOKEN="your_token_here"

FILES=(
  "https://www.figma.com/file/abc123/Mobile-Wireframes"
  "https://www.figma.com/file/xyz789/Desktop-Wireframes"
)

for file_url in "${FILES[@]}"; do
  echo "Importing from: $file_url"
  FIGMA_URL="$file_url" ./scripts/import-figma-wireframes.sh
done
```

### Re-importing Updated Wireframes

If you update your Figma designs:

1. Run the import script again
2. It will overwrite existing images
3. Update descriptions in WIREFRAMES.md if needed

**Tip:** Commit wireframes to git before re-importing so you can see what changed.

---

## Security Best Practices

### Token Security

**Do:**
- ✅ Store tokens in `.env.local` (git-ignored)
- ✅ Use password manager for backup
- ✅ Set expiration dates
- ✅ Rotate tokens periodically
- ✅ Revoke unused tokens

**Don't:**
- ❌ Commit tokens to git
- ❌ Share tokens in chat/email
- ❌ Use tokens in CI/CD without secrets management
- ❌ Give tokens more scopes than needed

### .env.local Example

```bash
# Figma Integration
FIGMA_ACCESS_TOKEN="figd_xxxxxxxxxxxxxxxxxxxxxxxxxxxxx"

# Never commit this file to git!
# Add to .gitignore
```

### .gitignore

Ensure `.env.local` is in `.gitignore`:

```
# Environment variables (NEVER commit secrets!)
.env
.env.local
.env.*.local
```

---

## Integration with Workflow

### When to Import

**Ideal time:** After creating wireframes in Figma, before completing PRD

**Workflow:**

1. Create Figma wireframes
2. Run import script
3. Review imported wireframes
4. Document wireframes in WIREFRAMES.md
5. Use wireframes to inform PRD and technical spec
6. Complete remaining planning documents

### Updating Wireframes

If designs change during planning:

1. Update Figma file
2. Re-run import script
3. Review changes in git diff
4. Update documentation if needed
5. Commit updated wireframes

### Sharing with Team

**For team projects:**

1. Each team member generates their own token
2. Share Figma file URL (not token!)
3. Each person runs import script locally
4. Commit wireframes to shared repository

**Alternative:** One person imports, commits wireframes to git, team pulls updates

---

## API Reference

### Figma REST API Endpoints Used

**GET /v1/files/:key**
- Retrieves file structure
- Returns all pages and frames
- Requires `file_content:read` scope

**GET /v1/images/:key**
- Exports frames as images
- Parameters:
  - `ids`: Comma-separated node IDs
  - `format`: png, jpg, svg, pdf
  - `scale`: 1, 2, 3, 4 (default: 2)
- Returns URLs to download images

### Rate Limits

Figma API has rate limits:
- **Tier 1 endpoints:** 100 requests per minute
- **Tier 2 endpoints:** 50 requests per minute

The import script uses Tier 1 endpoints, so you can import from many files without hitting limits.

---

## FAQ

### Q: Do I need a paid Figma account?

**A:** No, free Figma accounts can generate personal access tokens and use the API.

### Q: Can I import from FigJam files?

**A:** Yes, the API works with both Figma and FigJam files. Use FRAME objects in FigJam.

### Q: What image format is used?

**A:** PNG at 2x scale for high quality. You can modify the script to use SVG, JPG, or PDF if needed.

### Q: Can I import design tokens/variables?

**A:** The current script imports wireframes only. You can extend it to fetch variables using the `file_variables:read` scope and the Variables API.

### Q: Will this work with Figma Community files?

**A:** Yes, if you have view access to the file. Duplicate community files to your account first.

### Q: How do I import only specific frames?

**A:** Currently, the script imports all frames. You can modify it to filter by page name or frame name.

### Q: Can I automate this in CI/CD?

**A:** Yes, but store the token in your CI/CD secrets manager (GitHub Secrets, GitLab CI/CD variables, etc.). Never commit tokens to the repository.

---

## Extending the Script

### Export as SVG Instead of PNG

Change line in script:

```bash
# From:
"https://api.figma.com/v1/images/$FILE_KEY?ids=$IDS_PARAM&format=png&scale=2"

# To:
"https://api.figma.com/v1/images/$FILE_KEY?ids=$IDS_PARAM&format=svg"
```

### Filter Frames by Page

Add page filter:

```bash
TARGET_PAGE="Wireframes"

for page in $PAGES; do
    PAGE_DATA=$(echo "$page" | base64 --decode)
    PAGE_NAME=$(echo "$PAGE_DATA" | jq -r '.name')
    
    # Only process target page
    if [ "$PAGE_NAME" != "$TARGET_PAGE" ]; then
        continue
    fi
    
    # ... rest of processing
done
```

### Import Design Tokens

Extend script to fetch variables:

```bash
# Fetch variables
VARIABLES=$(curl -s -H "X-Figma-Token: $FIGMA_ACCESS_TOKEN" \
    "https://api.figma.com/v1/files/$FILE_KEY/variables/local")

# Parse and save
echo "$VARIABLES" | jq '.meta.variables' > planning/design-tokens.json
```

---

## Resources

### Figma API Documentation

- **Authentication:** https://developers.figma.com/docs/rest-api/authentication/
- **Files Endpoints:** https://developers.figma.com/docs/rest-api/file-endpoints/
- **Rate Limits:** https://developers.figma.com/docs/rest-api/rate-limits/

### Tools

- **jq Tutorial:** https://stedolan.github.io/jq/tutorial/
- **Figma API Playground:** https://www.figma.com/developers/api

---

**Version:** 1.0  
**Last Updated:** November 13, 2025  
**Maintained By:** Bradley Hope
