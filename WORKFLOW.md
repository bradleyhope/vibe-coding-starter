# Vibe Coding Workflow

A complete, step-by-step guide to using this vibe coding starter template for your projects.

---

## Overview

This workflow separates planning from execution. You create comprehensive planning documents first (in this repository), then Manus builds the actual code (in a separate repository). This separation ensures clarity, reduces iterations, and maximizes AI effectiveness.

---

## The Complete Workflow

### Phase 1: Initialize Your Planning Repository

#### Step 1.1: Create from Template

**Option A: Using GitHub Web Interface**
1. Go to https://github.com/bradleyhope/vibe-coding-starter
2. Click "Use this template" button
3. Choose "Create a new repository"
4. Name it: `your-project-name-planning`
5. Set visibility (private recommended for planning)
6. Click "Create repository"

**Option B: Using GitHub CLI**
```bash
gh repo create your-project-name-planning \
  --template bradleyhope/vibe-coding-starter \
  --private \
  --clone
```

#### Step 1.2: Run Initialization Script

```bash
cd your-project-name-planning
./scripts/init-project.sh
```

The script will prompt you for:
- Project name (lowercase-with-dashes)
- Project title (Human Readable)
- Brief description
- Your name
- Your email

It will then:
- Create the `planning/` directory structure
- Copy all templates
- Customize templates with your information
- Create README, CHANGELOG, .gitignore
- Initialize git repository

---

### Phase 2: Complete Planning Documents

Now fill out all planning documents. Use ChatGPT to help with each one.

#### Step 2.1: Write Your PRD

**File:** `planning/PRD.md`

**Use ChatGPT to help:**

```
Prompt to ChatGPT:
"I want to build [describe your idea]. Help me write a comprehensive 
Product Requirements Document (PRD) that includes:
- What I'm building and why
- Who will use it
- Core features and functionality
- Success criteria
- Technical constraints
- What's out of scope

Ask me clarifying questions to make this PRD complete."
```

**Key sections to complete:**
- Executive Summary
- Problem Statement
- Target Users (personas)
- Core Features (with acceptance criteria)
- Success Metrics
- Technical Constraints
- Risks and Mitigations

**Tips:**
- Be specific about acceptance criteria
- Use "As a [user], I want to [action] so that [benefit]" format
- Define what "done" looks like
- List what's explicitly out of scope

#### Step 2.2: Create Wireframes

**File:** `planning/WIREFRAMES.md`  
**Directory:** `planning/wireframes/`

**Tools:**
- Figma (recommended)
- Excalidraw (simple, free)
- Sketch
- Hand-drawn (scan/photo)

**Screens to wireframe:**
1. Landing page
2. Authentication pages (login, register)
3. Dashboard/main interface
4. List views
5. Detail views
6. Create/edit forms
7. Settings page

**What to include:**
- Layout and structure
- Key UI elements
- User interactions
- Navigation flow
- Responsive considerations

**Export:**
- Save wireframes as images in `planning/wireframes/`
- Document in `planning/WIREFRAMES.md`
- Include design system (colors, typography, spacing)

#### Step 2.3: Design Database Schema

**File:** `planning/DATABASE_SCHEMA.md`

**Use ChatGPT to help:**

```
Prompt to ChatGPT:
"Based on this PRD [paste PRD], help me design a database schema.
Include:
- All entities and their fields
- Relationships between entities
- Data types and constraints
- Indexes for performance
- Migration SQL

Format it as a clear markdown document with tables."
```

**Key sections:**
- Entity Relationship Diagram (ASCII or link to visual)
- Entity definitions with fields and types
- Relationships (one-to-many, many-to-many, etc.)
- Constraints and validations
- Indexes
- Migration SQL
- Seed data

**Tips:**
- Use UUIDs for primary keys
- Add `created_at` and `updated_at` to all tables
- Consider soft deletes (`is_deleted` flag)
- Index foreign keys and frequently queried fields

#### Step 2.4: Complete Technical Specification

**File:** `planning/TECHNICAL_SPEC.md`

**Key decisions to make:**

**Frontend:**
- Framework (Next.js, React, Vue, etc.)
- Language (TypeScript recommended)
- Styling (Tailwind CSS, CSS Modules, etc.)
- State management (Zustand, Redux, Context)

**Backend:**
- Framework (Next.js API Routes, Express, FastAPI, etc.)
- API style (REST, GraphQL, tRPC)
- Authentication (NextAuth.js, Supabase Auth, JWT)

**Database:**
- Database (PostgreSQL, MongoDB, etc.)
- Hosting (Supabase, PlanetScale, Neon)
- ORM (Prisma, Drizzle, SQLAlchemy)

**Infrastructure:**
- Hosting (Vercel, Railway, AWS)
- File storage (S3, Supabase Storage)
- Monitoring (Sentry, LogRocket)

**Complete sections:**
- Technology Stack
- System Architecture
- API Design (all endpoints)
- Security considerations
- Performance targets
- Testing strategy
- Deployment configuration

#### Step 2.5: Document Infrastructure Setup

**File:** `planning/SETUP_NOTES.md`

⚠️ **Important:** Never commit actual secrets!

**Document:**
- All required environment variables (with placeholders)
- Service setup instructions (Supabase, Vercel, etc.)
- API keys needed (where to get them)
- Database connection strings (format, not actual values)
- OAuth setup steps
- Deployment configuration

**Create `.env.example`:**
```bash
DATABASE_URL="postgresql://..."
NEXTAUTH_SECRET="generate-with-openssl"
# etc.
```

**Keep actual values in `.env.local`** (git-ignored)

#### Step 2.6: Review Manus Prompt

**File:** `planning/MANUS_PROMPT.md`

This template is pre-filled and references all your other documents. Review and customize:

- Project overview (auto-filled from PRD)
- Technology stack (matches TECHNICAL_SPEC.md)
- Core features (summarized from PRD)
- Success criteria (from PRD)
- Out of scope (from PRD)

**Or generate automatically:**
```bash
./scripts/generate-manus-prompt.sh
```

This creates `planning/MANUS_PROMPT_GENERATED.md` by combining all your planning docs.

---

### Phase 3: Validate and Lock Planning

#### Step 3.1: Validate Documents

```bash
./scripts/validate-docs.sh
```

This checks:
- All required files exist
- Key sections are present
- No placeholders remain
- No secrets committed
- Documents are complete

Fix any errors or warnings before proceeding.

#### Step 3.2: Review with ChatGPT

**Final review prompt:**

```
I've completed all planning documents for my project. Can you review them 
for completeness, consistency, and potential issues?

[Paste or upload all planning documents]

Specifically check:
1. Are requirements clear and complete?
2. Does the database schema support all features?
3. Is the tech stack appropriate?
4. Are there any missing considerations?
5. Is anything ambiguous that could cause issues?
```

Address any feedback from ChatGPT.

#### Step 3.3: Commit and Lock

```bash
# Add all planning documents
git add planning/

# Commit with clear message
git commit -m "Planning phase complete - LOCKED

All planning documents finalized:
- PRD with complete requirements
- Database schema designed
- Technical specifications defined
- Wireframes created
- Infrastructure documented
- Manus prompt prepared

Status: Ready for execution"

# Tag as locked
git tag -a v1.0-planning -m "Planning phase complete and locked"
```

#### Step 3.4: Push to GitHub

```bash
# Create GitHub repository
gh repo create your-project-name-planning --private

# Add remote (if not already added)
git remote add origin https://github.com/yourusername/your-project-name-planning

# Push with tags
git push -u origin main --tags
```

---

### Phase 4: Execute with Manus

#### Step 4.1: Prepare Manus Prompt

You have two options:

**Option A: Reference GitHub Repository (Recommended)**

```
I want to build [Project Name]. All planning documents are in this 
GitHub repository:

https://github.com/yourusername/your-project-name-planning

Please:
1. Clone the repository
2. Review all files in the planning/ directory
3. Start with planning/MANUS_PROMPT.md for complete instructions
4. Create a new repository for the code: your-project-name-code
5. Build the complete project following the specifications

Key files:
- planning/PRD.md (complete requirements)
- planning/DATABASE_SCHEMA.md (data model)
- planning/TECHNICAL_SPEC.md (architecture and API)
- planning/WIREFRAMES.md (UI/UX designs)
- planning/wireframes/ (visual mockups)
- planning/SETUP_NOTES.md (infrastructure)
- planning/MANUS_PROMPT.md (comprehensive build instructions)
```

**Option B: Upload Files Directly**

Upload these files to Manus:
- `planning/MANUS_PROMPT.md`
- `planning/PRD.md`
- `planning/DATABASE_SCHEMA.md`
- `planning/TECHNICAL_SPEC.md`
- `planning/WIREFRAMES.md`
- All files from `planning/wireframes/`

Then send:
```
I want to build [Project Name]. I've uploaded all planning documents.

Please review all files and build the complete project following the 
specifications in MANUS_PROMPT.md.

Create a new repository called: your-project-name-code
```

#### Step 4.2: Let Manus Work

**Do:**
- ✅ Let Manus work autonomously
- ✅ Monitor progress to understand what it's doing
- ✅ Wait for completion before reviewing

**Don't:**
- ❌ Interrupt mid-execution
- ❌ Micromanage each step
- ❌ Provide conflicting instructions

**Typical timeline:**
- Simple project: 15-30 minutes
- Medium complexity: 1-2 hours
- Complex project: 2-4 hours

#### Step 4.3: Manus Creates Execution Repository

Manus will:
1. Create new repository: `your-project-name-code`
2. Set up complete project structure
3. Implement all features
4. Write tests
5. Create documentation
6. Commit and push to GitHub

---

### Phase 5: Review and Test

#### Step 5.1: Clone and Review

```bash
# Clone the execution repository
gh repo clone yourusername/your-project-name-code
cd your-project-name-code

# Open in VS Code
code .
```

#### Step 5.2: Understand the Code

If you're non-technical, use ChatGPT:

```
I have code generated by Manus for my project. Can you explain:
1. What is the overall structure?
2. How does [specific feature] work?
3. What does this file do? [paste file]
4. How are [component A] and [component B] connected?

[Upload relevant files]
```

#### Step 5.3: Test Systematically

**Setup:**
```bash
# Install dependencies
pnpm install

# Set up environment variables
cp .env.example .env.local
# Fill in actual values from planning/SETUP_NOTES.md

# Run database migrations
pnpm prisma migrate dev

# Seed database (if applicable)
pnpm prisma db seed

# Start development server
pnpm dev
```

**Test checklist:**
- [ ] Application starts without errors
- [ ] All pages load correctly
- [ ] Authentication works (register, login, logout)
- [ ] All CRUD operations work
- [ ] Forms validate correctly
- [ ] Error handling works
- [ ] Responsive on mobile/tablet/desktop
- [ ] All acceptance criteria from PRD are met

**Document issues:**
Create `TESTING_NOTES.md`:
```markdown
# Testing Notes

## Issues Found

### Issue 1: [Description]
- **Severity:** High | Medium | Low
- **Steps to reproduce:** [Steps]
- **Expected:** [What should happen]
- **Actual:** [What actually happens]

### Issue 2: [Description]
...
```

---

### Phase 6: Iterate and Refine

#### Step 6.1: First Iteration Review

After testing, you'll likely have issues or missing features. This is normal!

**Expected results:**
- Iteration 1: 60-70% complete
- Iteration 2: 80-90% complete
- Iteration 3: 95%+ complete

#### Step 6.2: Provide Feedback to Manus

**For bugs/issues:**

```
I've tested the application and found these issues:

1. [Issue description]
   - Steps to reproduce: [steps]
   - Expected: [expected behavior]
   - Actual: [actual behavior]

2. [Issue description]
   ...

Please fix these issues.
```

**For missing features:**

```
The following features from the PRD are not implemented:

1. [Feature name] - [Acceptance criteria not met]
2. [Feature name] - [Acceptance criteria not met]

Please implement these features according to the PRD.
```

**For refinements:**

```
The implementation is good but needs these refinements:

1. [Refinement description]
2. [Refinement description]

Please make these improvements.
```

#### Step 6.3: When to Start Fresh

Start fresh (new Manus session) if:
- More than 3 iterations without progress
- Fundamental misunderstanding of requirements
- Wrong technical approach taken
- Architecture doesn't match specifications

**Starting fresh:**
1. Document lessons learned
2. Update planning documents if needed (with new version tag)
3. Start new Manus session with updated planning repo

---

### Phase 7: Deployment

#### Step 7.1: Pre-Deployment Checklist

- [ ] All features implemented and tested
- [ ] All tests passing
- [ ] Environment variables documented
- [ ] Database migrations ready
- [ ] Error tracking configured (Sentry)
- [ ] Analytics configured
- [ ] Performance acceptable
- [ ] Security reviewed

#### Step 7.2: Deploy to Staging

**Vercel:**
```bash
# Install Vercel CLI
pnpm add -g vercel

# Login
vercel login

# Deploy to staging
vercel
```

**Railway:**
1. Connect GitHub repository
2. Add environment variables
3. Deploy automatically on push

#### Step 7.3: Test on Staging

- [ ] All functionality works in staging
- [ ] Database migrations applied
- [ ] Environment variables correct
- [ ] External services connected
- [ ] Performance acceptable
- [ ] No console errors

#### Step 7.4: Deploy to Production

**Vercel:**
```bash
vercel --prod
```

**Configure:**
- Custom domain
- SSL certificate
- Environment variables
- Monitoring and alerts

---

### Phase 8: Maintenance and Updates

#### Step 8.1: When Requirements Change

If requirements change significantly:

1. **Update planning repository:**
   ```bash
   cd your-project-name-planning
   git checkout -b planning-update-v2
   
   # Update relevant planning documents
   vim planning/PRD.md
   
   # Document changes
   echo "## Changes in v2" >> CHANGELOG.md
   echo "- Updated feature X because..." >> CHANGELOG.md
   
   # Commit
   git add planning/ CHANGELOG.md
   git commit -m "Planning update v2: [reason]"
   
   # Tag
   git tag -a v2.0-planning -m "Planning update: [reason]"
   git push --tags
   ```

2. **Provide updated planning to Manus:**
   ```
   Requirements have changed. Please review the updated planning documents:
   
   https://github.com/yourusername/your-project-name-planning
   
   Tag: v2.0-planning
   
   Changes:
   - [Change 1]
   - [Change 2]
   
   Please update the code repository to reflect these changes.
   ```

#### Step 8.2: Bug Fixes

For small bug fixes, work directly in the code repository:

```bash
cd your-project-name-code

# Create feature branch
git checkout -b fix/bug-description

# Make changes
# Test changes
# Commit and push

git add .
git commit -m "Fix: [bug description]"
git push origin fix/bug-description

# Create pull request
gh pr create
```

---

## Tips for Success

### Do's

✅ **Complete all planning before starting Manus**  
✅ **Use ChatGPT to help write planning documents**  
✅ **Be specific about acceptance criteria**  
✅ **Create visual wireframes, not just descriptions**  
✅ **Design database schema before building**  
✅ **Expect 2-3 iterations**  
✅ **Test systematically against PRD**  
✅ **Document issues clearly**  
✅ **Trust Manus's autonomous execution**  
✅ **Verify data accuracy in results**  

### Don'ts

❌ **Don't skip the PRD**  
❌ **Don't start Manus without complete planning**  
❌ **Don't edit planning docs during execution**  
❌ **Don't interrupt Manus mid-execution**  
❌ **Don't expect perfection on first iteration**  
❌ **Don't get too invested in one approach**  
❌ **Don't commit secrets to git**  
❌ **Don't trust data analysis without verification**  

---

## Troubleshooting

### Problem: Manus misunderstands requirements

**Solution:**
1. Review your PRD for ambiguity
2. Add more specific examples
3. Include wireframes or mockups
4. Use ChatGPT to clarify requirements
5. Start fresh with clearer prompt

### Problem: Code has bugs or errors

**Solution:**
1. Let Manus debug first (it's designed for this)
2. Provide specific error messages
3. Test systematically to isolate issues
4. Review code in VS Code
5. If stuck after 2-3 iterations, start fresh

### Problem: Running out of credits

**Solution:**
1. Provide more comprehensive initial prompts
2. Reduce unnecessary iterations through better planning
3. Break large projects into smaller phases
4. Optimize for KV-cache efficiency
5. Consider upgrading plan

### Problem: Iteration not improving

**Solution:**
1. Stop after 3 iterations
2. Review what's not working
3. Identify root cause (unclear requirements or wrong approach?)
4. Start fresh with lessons learned
5. Consider if problem is too complex

---

## Quick Reference

### Commands

```bash
# Initialize new project
./scripts/init-project.sh

# Validate planning documents
./scripts/validate-docs.sh

# Generate Manus prompt
./scripts/generate-manus-prompt.sh

# Commit and lock planning
git add planning/
git commit -m "Planning complete - LOCKED"
git tag -a v1.0-planning -m "Planning complete"
git push --tags

# Create GitHub repo
gh repo create your-project-name-planning --private
```

### File Structure

```
your-project-name-planning/
├── README.md
├── CHANGELOG.md
├── WORKFLOW.md (this file)
├── .gitignore
├── .env.example
├── planning/
│   ├── PRD.md
│   ├── DATABASE_SCHEMA.md
│   ├── TECHNICAL_SPEC.md
│   ├── WIREFRAMES.md
│   ├── SETUP_NOTES.md
│   ├── MANUS_PROMPT.md
│   └── wireframes/
├── scripts/
│   ├── init-project.sh
│   ├── validate-docs.sh
│   └── generate-manus-prompt.sh
└── docs/
    └── BEST_PRACTICES.md
```

---

**Version:** 1.0  
**Last Updated:** November 12, 2025  
**Maintained By:** Bradley Hope
