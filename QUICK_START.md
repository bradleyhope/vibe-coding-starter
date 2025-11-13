# Quick Start Guide

Get started with vibe coding in 5 minutes.

---

## For Your First Project

### Step 1: Create from Template (30 seconds)

**Using GitHub Web:**
1. Go to https://github.com/bradleyhope/vibe-coding-starter
2. Click "Use this template" → "Create a new repository"
3. Name it: `my-project-planning`
4. Click "Create repository"
5. Clone it: `gh repo clone yourusername/my-project-planning`

**Using GitHub CLI:**
```bash
gh repo create my-project-planning \
  --template bradleyhope/vibe-coding-starter \
  --private \
  --clone
```

### Step 2: Initialize (1 minute)

```bash
cd my-project-planning
./scripts/init-project.sh
```

Answer the prompts:
- Project name: `my-awesome-app`
- Project title: `My Awesome App`
- Description: `A tool that helps users do X`
- Your name: `Your Name`
- Your email: `you@example.com`

### Step 3: Plan with ChatGPT (30-60 minutes)

Open ChatGPT and use these prompts:

**For PRD:**
```
I want to build [your idea]. Help me write a comprehensive PRD including:
- Problem statement
- Target users
- Core features with acceptance criteria
- Success metrics
Ask clarifying questions to make it complete.
```

Copy the result to `planning/PRD.md`

**For Database Schema:**
```
Based on this PRD [paste PRD], design a database schema with:
- All entities and fields
- Relationships
- Constraints
- SQL migrations
```

Copy to `planning/DATABASE_SCHEMA.md`

**For Technical Spec:**
```
For this project [paste PRD], recommend:
- Best technology stack
- Architecture approach
- API design
- Security considerations
```

Copy to `planning/TECHNICAL_SPEC.md`

**Create wireframes:**

**Option A: Import from Figma (Recommended)**
```bash
./scripts/import-figma-wireframes.sh
```
- Automatically imports all frames from Figma
- See `docs/FIGMA_INTEGRATION.md` for setup

**Option B: Manual**
- Create in Figma/Excalidraw
- Save screenshots to `planning/wireframes/`
- Document in `planning/WIREFRAMES.md`

**Fill out** `planning/SETUP_NOTES.md` with infrastructure details

### Step 4: Validate (30 seconds)

```bash
./scripts/validate-docs.sh
```

Fix any errors or warnings.

### Step 5: Lock and Push (1 minute)

```bash
git add planning/
git commit -m "Planning complete - LOCKED"
git tag -a v1.0-planning -m "Planning complete"
git push --tags
```

### Step 6: Execute with Manus (1-4 hours)

Open Manus and send:

```
I want to build [Project Name]. All planning documents are in:
https://github.com/yourusername/my-project-planning

Please:
1. Clone the repository
2. Review planning/MANUS_PROMPT.md
3. Create new repo: my-project-code
4. Build the complete project

Key files in planning/:
- PRD.md
- DATABASE_SCHEMA.md
- TECHNICAL_SPEC.md
- WIREFRAMES.md
- SETUP_NOTES.md
```

Let Manus work autonomously.

### Step 7: Review and Test (30-60 minutes)

```bash
gh repo clone yourusername/my-project-code
cd my-project-code
pnpm install
cp .env.example .env.local
# Fill in values from planning/SETUP_NOTES.md
pnpm dev
```

Test all features against PRD acceptance criteria.

### Step 8: Iterate if Needed (1-2 hours)

Provide feedback to Manus:

```
I've tested and found these issues:
1. [Issue description]
2. [Issue description]

Please fix these issues.
```

Expect 2-3 iterations total.

### Step 9: Deploy (30 minutes)

```bash
vercel --prod
```

Done! 🎉

---

## Time Breakdown

- Planning: 1-2 hours (with ChatGPT help)
- Execution: 1-4 hours (Manus autonomous)
- Review/Test: 30-60 minutes
- Iteration: 1-2 hours (if needed)
- Deployment: 30 minutes

**Total: 4-10 hours** from idea to deployed app

Compare to traditional development: 40-100+ hours

---

## Key Success Factors

1. **Complete planning first** - Don't skip the PRD
2. **Use ChatGPT** to help write planning docs
3. **Be specific** about acceptance criteria
4. **Create visual wireframes** not just descriptions
5. **Trust Manus** to work autonomously
6. **Expect 2-3 iterations** - this is normal
7. **Test systematically** against PRD

---

## Common Mistakes to Avoid

❌ Starting Manus without complete planning  
❌ Vague or ambiguous requirements  
❌ Skipping wireframes  
❌ Interrupting Manus mid-execution  
❌ Expecting perfection on first iteration  
❌ Not testing against acceptance criteria  

---

## Need Help?

- **Full Workflow:** See [WORKFLOW.md](WORKFLOW.md)
- **Best Practices:** See [docs/BEST_PRACTICES.md](docs/BEST_PRACTICES.md)
- **Templates:** See [templates/](templates/)
- **Scripts:** See [scripts/](scripts/)

---

**Ready to build?** Start with Step 1 above! 🚀
