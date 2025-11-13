# Usage Instructions

Complete guide to using the Vibe Coding Starter template.

---

## Overview

This template provides a structured workflow for vibe coding projects:

1. **Planning Repository** (this template) - Contains all planning documents
2. **Execution Repository** (created by Manus) - Contains actual code

This separation ensures clarity, reduces iterations, and maximizes AI effectiveness.

---

## Prerequisites

### Required Tools

- **Git:** Version control
- **GitHub Account:** For hosting repositories
- **GitHub CLI:** `gh` command (recommended)
- **Node.js:** For running scripts (optional)
- **ChatGPT Account:** For planning assistance
- **Manus Account:** For code execution

### Installation

```bash
# Install GitHub CLI (macOS)
brew install gh

# Install GitHub CLI (Linux)
curl -fsSL https://cli.github.com/packages/githubcli-archive-keyring.gpg | sudo dd of=/usr/share/keyrings/githubcli-archive-keyring.gpg
echo "deb [arch=$(dpkg --print-architecture) signed-by=/usr/share/keyrings/githubcli-archive-keyring.gpg] https://cli.github.com/packages stable main" | sudo tee /etc/apt/sources.list.d/github-cli.list > /dev/null
sudo apt update
sudo apt install gh

# Login to GitHub
gh auth login
```

---

## Getting Started

### Option 1: Using GitHub Web Interface

1. Navigate to https://github.com/bradleyhope/vibe-coding-starter
2. Click the green "Use this template" button
3. Select "Create a new repository"
4. Fill in repository details:
   - **Name:** `your-project-name-planning`
   - **Description:** Brief project description
   - **Visibility:** Private (recommended for planning)
5. Click "Create repository"
6. Clone your new repository:
   ```bash
   git clone https://github.com/yourusername/your-project-name-planning
   cd your-project-name-planning
   ```

### Option 2: Using GitHub CLI

```bash
# Create from template
gh repo create your-project-name-planning \
  --template bradleyhope/vibe-coding-starter \
  --private \
  --clone

# Navigate to directory
cd your-project-name-planning
```

---

## Initialization

### Run the Init Script

```bash
./scripts/init-project.sh
```

### What the Script Does

1. Prompts for project information
2. Creates `planning/` directory structure
3. Copies and customizes templates
4. Creates README, CHANGELOG, .gitignore
5. Initializes git repository
6. Provides next steps

### Script Prompts

You'll be asked for:

- **Project name:** Lowercase with dashes (e.g., `my-awesome-app`)
- **Project title:** Human-readable (e.g., `My Awesome App`)
- **Brief description:** One sentence describing your project
- **Your name:** For documentation
- **Your email:** For git commits

### After Initialization

You'll have this structure:

```
your-project-name-planning/
├── README.md                    # Project overview
├── CHANGELOG.md                 # Change tracking
├── WORKFLOW.md                  # Complete workflow guide
├── QUICK_START.md              # Quick reference
├── .gitignore                   # Git ignore rules
├── .env.example                # Environment variables template
├── planning/                    # Your planning documents
│   ├── PRD.md                  # Product requirements
│   ├── DATABASE_SCHEMA.md      # Database design
│   ├── TECHNICAL_SPEC.md       # Technical specifications
│   ├── WIREFRAMES.md           # UI/UX designs
│   ├── SETUP_NOTES.md          # Infrastructure notes
│   ├── MANUS_PROMPT.md         # Manus build prompt
│   └── wireframes/             # Wireframe images
├── scripts/                     # Automation scripts
│   ├── init-project.sh         # Initialization
│   ├── validate-docs.sh        # Validation
│   └── generate-manus-prompt.sh # Prompt generation
└── docs/                        # Documentation
    └── BEST_PRACTICES.md       # Vibe coding guide
```

---

## Planning Phase

### 1. Complete the PRD

**File:** `planning/PRD.md`

**Use ChatGPT:**

```
I want to build [describe your idea in detail]. 

Help me write a comprehensive Product Requirements Document (PRD) that includes:

1. Executive Summary
2. Problem Statement (who has this problem, why it matters)
3. Target Users (detailed personas)
4. Core Features (with specific acceptance criteria)
5. Success Metrics (how we measure success)
6. Technical Constraints
7. What's explicitly out of scope

Ask me clarifying questions to ensure completeness.
```

**Key Sections:**

- **Problem Statement:** What problem are you solving?
- **Target Users:** Who will use this? Create personas.
- **Core Features:** What must it do? Use acceptance criteria.
- **Success Metrics:** How will you know it works?
- **Non-Goals:** What are you NOT building?

**Tips:**

- Be specific about acceptance criteria
- Use "As a [user], I want to [action] so that [benefit]" format
- Define what "done" looks like
- List what's explicitly out of scope

### 2. Create Wireframes

**File:** `planning/WIREFRAMES.md`  
**Directory:** `planning/wireframes/`

**Recommended Tools:**

- **Figma:** Professional, free tier available
- **Excalidraw:** Simple, open-source
- **Sketch:** macOS only
- **Hand-drawn:** Scan or photograph

**What to Wireframe:**

1. Landing page
2. Authentication (login, register)
3. Dashboard/main interface
4. List views
5. Detail views
6. Create/edit forms
7. Settings

**Include:**

- Layout and structure
- Key UI elements
- User interactions
- Navigation flow
- Responsive considerations
- Design system (colors, typography, spacing)

**Export:**

- Save as images in `planning/wireframes/`
- Document in `planning/WIREFRAMES.md`
- Include design system specifications

### 3. Design Database Schema

**File:** `planning/DATABASE_SCHEMA.md`

**Use ChatGPT:**

```
Based on this PRD:

[Paste your PRD]

Help me design a database schema that includes:

1. All entities needed to support the features
2. Fields for each entity with data types
3. Relationships between entities
4. Constraints and validations
5. Indexes for performance
6. SQL migration code

Format as a clear markdown document with tables.
```

**Key Sections:**

- **Entity Relationship Diagram:** Visual representation
- **Entity Definitions:** Tables with fields and types
- **Relationships:** How entities connect
- **Constraints:** Validations and rules
- **Indexes:** For query performance
- **Migrations:** SQL to create tables
- **Seed Data:** Sample data for development

**Best Practices:**

- Use UUIDs for primary keys
- Add `created_at` and `updated_at` timestamps
- Consider soft deletes (`is_deleted` boolean)
- Index all foreign keys
- Index frequently queried fields

### 4. Complete Technical Specification

**File:** `planning/TECHNICAL_SPEC.md`

**Key Decisions:**

**Frontend:**
- Framework: Next.js, React, Vue, Svelte
- Language: TypeScript (recommended)
- Styling: Tailwind CSS, CSS Modules, Styled Components
- State: Zustand, Redux, Context API

**Backend:**
- Framework: Next.js API Routes, Express, FastAPI, Flask
- API Style: REST, GraphQL, tRPC
- Auth: NextAuth.js, Supabase Auth, JWT

**Database:**
- Type: PostgreSQL, MongoDB, MySQL
- Hosting: Supabase, PlanetScale, Neon
- ORM: Prisma, Drizzle, SQLAlchemy

**Infrastructure:**
- Hosting: Vercel, Railway, AWS
- Storage: S3, Supabase Storage
- Monitoring: Sentry, LogRocket

**Complete:**

- Technology Stack (all choices above)
- System Architecture (diagrams)
- API Design (all endpoints with examples)
- Security (authentication, authorization, encryption)
- Performance (targets and optimization)
- Testing (strategy and tools)
- Deployment (process and configuration)

### 5. Document Infrastructure

**File:** `planning/SETUP_NOTES.md`

⚠️ **Important:** Never commit actual secrets!

**Document:**

- All environment variables (with placeholders)
- Service setup instructions (step-by-step)
- API keys needed (where to get them)
- Database connection strings (format only)
- OAuth setup (for each provider)
- Deployment configuration

**Create `.env.example`:**

```bash
# Database
DATABASE_URL="postgresql://..."

# Authentication
NEXTAUTH_SECRET="generate-with-openssl"
JWT_SECRET="generate-with-openssl"

# External Services
STRIPE_SECRET_KEY="sk_test_..."
SENDGRID_API_KEY="SG..."

# Feature Flags
ENABLE_FEATURE_X="true"
```

**Keep actual values in `.env.local`** (git-ignored)

### 6. Review Manus Prompt

**File:** `planning/MANUS_PROMPT.md`

This template references all your other documents. Review and ensure:

- Project overview is clear
- Technology stack matches TECHNICAL_SPEC.md
- Core features summarized from PRD
- Success criteria defined
- Out of scope items listed

**Or auto-generate:**

```bash
./scripts/generate-manus-prompt.sh
```

This creates `planning/MANUS_PROMPT_GENERATED.md` by combining all planning docs.

---

## Validation

### Run Validation Script

```bash
./scripts/validate-docs.sh
```

### What It Checks

- ✅ All required files exist
- ✅ Key sections are present in each document
- ✅ No placeholder text remains
- ✅ No actual secrets committed
- ✅ Documents are complete

### Fix Issues

The script will show:

- **Errors:** Must fix before proceeding
- **Warnings:** Should address but not blocking
- **Success:** All checks passed

Address all errors and consider addressing warnings.

---

## Locking Planning

### Commit and Tag

```bash
# Add all planning documents
git add planning/

# Commit with descriptive message
git commit -m "Planning phase complete - LOCKED

All planning documents finalized:
- PRD with complete requirements
- Database schema designed
- Technical specifications defined
- Wireframes created
- Infrastructure documented
- Manus prompt prepared

Status: Ready for execution"

# Tag as version 1.0
git tag -a v1.0-planning -m "Planning phase complete and locked"

# Push with tags
git push origin main --tags
```

### Why Lock?

Once planning is locked:

- Documents become the single source of truth
- Changes require explicit agreement
- Provides stable reference for Manus
- Enables version tracking

---

## Executing with Manus

### Method 1: GitHub Repository Reference (Recommended)

**Prompt for Manus:**

```
I want to build [Project Name]. All planning documents are in this GitHub repository:

https://github.com/yourusername/your-project-name-planning

Please:
1. Clone the repository
2. Review all files in the planning/ directory
3. Start with planning/MANUS_PROMPT.md for complete instructions
4. Create a new repository for the code: your-project-name-code
5. Build the complete project following the specifications

Key planning files:
- planning/PRD.md (complete requirements and acceptance criteria)
- planning/DATABASE_SCHEMA.md (full data model)
- planning/TECHNICAL_SPEC.md (architecture and API design)
- planning/WIREFRAMES.md (UI/UX specifications)
- planning/wireframes/ (visual mockups)
- planning/SETUP_NOTES.md (infrastructure and services)
- planning/MANUS_PROMPT.md (comprehensive build instructions)

Please confirm you've reviewed all documents before starting.
```

### Method 2: Upload Files Directly

**Files to upload:**

- `planning/MANUS_PROMPT.md`
- `planning/PRD.md`
- `planning/DATABASE_SCHEMA.md`
- `planning/TECHNICAL_SPEC.md`
- `planning/WIREFRAMES.md`
- All files from `planning/wireframes/`

**Prompt:**

```
I want to build [Project Name]. I've uploaded all planning documents.

Please review all files and build the complete project following the specifications in MANUS_PROMPT.md.

Create a new repository called: your-project-name-code

Confirm you've reviewed all documents before starting.
```

### Let Manus Work

- ✅ Let it work autonomously
- ✅ Monitor progress
- ✅ Wait for completion
- ❌ Don't interrupt
- ❌ Don't micromanage

**Typical Timeline:**

- Simple: 15-30 minutes
- Medium: 1-2 hours
- Complex: 2-4 hours

---

## Review and Testing

### Clone Execution Repository

```bash
gh repo clone yourusername/your-project-name-code
cd your-project-name-code
```

### Setup and Run

```bash
# Install dependencies
pnpm install

# Setup environment
cp .env.example .env.local
# Fill in actual values from planning/SETUP_NOTES.md

# Run migrations
pnpm prisma migrate dev

# Seed database (if applicable)
pnpm prisma db seed

# Start development server
pnpm dev
```

### Test Systematically

Test against PRD acceptance criteria:

- [ ] Application starts without errors
- [ ] All pages load correctly
- [ ] Authentication works (register, login, logout)
- [ ] All CRUD operations work
- [ ] Forms validate correctly
- [ ] Error handling works
- [ ] Responsive on all devices
- [ ] All acceptance criteria met

### Document Issues

Create `TESTING_NOTES.md`:

```markdown
# Testing Notes

## Issues Found

### Issue 1: [Description]
- Severity: High | Medium | Low
- Steps to reproduce: [Steps]
- Expected: [What should happen]
- Actual: [What actually happens]
```

---

## Iteration

### Expected Results

- **Iteration 1:** 60-70% complete
- **Iteration 2:** 80-90% complete
- **Iteration 3:** 95%+ complete

This is normal!

### Provide Feedback

**For bugs:**

```
I've tested and found these issues:

1. [Issue description]
   - Steps: [steps]
   - Expected: [expected]
   - Actual: [actual]

Please fix these issues.
```

**For missing features:**

```
These features from the PRD are not implemented:

1. [Feature] - [Acceptance criteria not met]
2. [Feature] - [Acceptance criteria not met]

Please implement according to PRD.
```

### When to Start Fresh

Start new Manus session if:

- More than 3 iterations without progress
- Fundamental misunderstanding
- Wrong technical approach
- Architecture mismatch

---

## Updating Planning

### When Requirements Change

```bash
cd your-project-name-planning

# Create update branch
git checkout -b planning-update-v2

# Update documents
vim planning/PRD.md

# Document changes
echo "## Changes in v2" >> CHANGELOG.md
echo "- Updated feature X because..." >> CHANGELOG.md

# Commit and tag
git add planning/ CHANGELOG.md
git commit -m "Planning update v2: [reason]"
git tag -a v2.0-planning -m "Planning update: [reason]"
git push --tags
```

### Provide to Manus

```
Requirements have changed. Please review updated planning:

https://github.com/yourusername/your-project-name-planning

Tag: v2.0-planning

Changes:
- [Change 1]
- [Change 2]

Please update the code repository accordingly.
```

---

## Scripts Reference

### init-project.sh

Initializes new project from templates.

```bash
./scripts/init-project.sh
```

**What it does:**
- Prompts for project info
- Creates planning directory
- Copies and customizes templates
- Creates README, CHANGELOG, .gitignore
- Initializes git

### validate-docs.sh

Validates planning documents.

```bash
./scripts/validate-docs.sh
```

**What it checks:**
- Required files exist
- Key sections present
- No placeholders remain
- No secrets committed
- Documents complete

### generate-manus-prompt.sh

Generates comprehensive Manus prompt.

```bash
./scripts/generate-manus-prompt.sh
```

**What it does:**
- Combines all planning docs
- Extracts key information
- Creates comprehensive prompt
- Outputs to `planning/MANUS_PROMPT_GENERATED.md`

---

## Tips for Success

### Do's

✅ Complete all planning before Manus  
✅ Use ChatGPT for planning docs  
✅ Be specific about acceptance criteria  
✅ Create visual wireframes  
✅ Design database schema first  
✅ Expect 2-3 iterations  
✅ Test against PRD  
✅ Trust Manus's autonomy  

### Don'ts

❌ Skip the PRD  
❌ Start without complete planning  
❌ Edit planning during execution  
❌ Interrupt Manus mid-execution  
❌ Expect perfection first time  
❌ Commit secrets to git  

---

## Troubleshooting

### Script won't run

**Issue:** Permission denied

**Solution:**
```bash
chmod +x scripts/*.sh
```

### Validation fails

**Issue:** Missing sections or placeholders

**Solution:**
- Review validation output
- Complete missing sections
- Replace all `[placeholders]`
- Run validation again

### Manus misunderstands

**Issue:** Generated code doesn't match requirements

**Solution:**
1. Review PRD for ambiguity
2. Add specific examples
3. Include wireframes
4. Clarify with ChatGPT
5. Start fresh with clearer prompt

### Running out of credits

**Issue:** Manus uses too many credits

**Solution:**
1. Provide comprehensive initial prompts
2. Reduce iterations through better planning
3. Break into smaller phases
4. Optimize for KV-cache efficiency

---

## Support

### Documentation

- **Quick Start:** [QUICK_START.md](QUICK_START.md)
- **Full Workflow:** [WORKFLOW.md](WORKFLOW.md)
- **Best Practices:** [docs/BEST_PRACTICES.md](docs/BEST_PRACTICES.md)

### Resources

- [Manus Documentation](https://open.manus.ai/docs)
- [Manus Blog](https://manus.im/blog)
- [GitHub Repository](https://github.com/bradleyhope/vibe-coding-starter)

---

**Version:** 1.0  
**Last Updated:** November 12, 2025  
**Repository:** https://github.com/bradleyhope/vibe-coding-starter
