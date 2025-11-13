# Vibe Coding Starter

A comprehensive template and workflow for starting vibe coding projects with Manus AI. This repository establishes a standard process where planning comes first, documentation is immutable, and execution follows a proven methodology.

## Features

- **Comprehensive Templates** - 6 fully-structured planning documents
- **Automation Scripts** - One-command initialization, validation, and prompt generation
- **Figma Integration** - Automatically import wireframes from Figma designs
- **Extensive Documentation** - 35,000+ words of guides and best practices
- **Research-Based** - Synthesizes insights from 17 sources
- **Professional Workflow** - Immutable planning, version control, clear separation of concerns

## Philosophy

Every vibe coding project should start with comprehensive planning in its own dedicated repository. The planning documents become the single source of truth and are not edited unless explicitly agreed upon. This approach ensures clarity, reduces iterations, and maximizes the effectiveness of AI-assisted development.

## Quick Start

### For New Projects

```bash
# 1. Use this repository as a template
# Click "Use this template" on GitHub

# 2. Clone your new project planning repo
git clone https://github.com/yourusername/your-project-planning
cd your-project-planning

# 3. Run the initialization script
./scripts/init-project.sh

# 4. Follow the guided workflow
```

### The Workflow

1. **Planning Phase** (this repo) - Create immutable planning documents
2. **Execution Phase** (separate repo) - Manus builds based on planning docs
3. **Iteration Phase** (execution repo) - Refine implementation
4. **Update Phase** (back to planning repo) - Only if requirements change

## Repository Structure

```
vibe-coding-starter/
├── README.md                    # This file
├── WORKFLOW.md                  # Complete step-by-step workflow
├── templates/                   # All planning templates
│   ├── PRD.md                  # Product Requirements Document
│   ├── DATABASE_SCHEMA.md      # Database design template
│   ├── WIREFRAMES.md           # UI/UX planning template
│   ├── TECHNICAL_SPEC.md       # Technical specifications
│   ├── MANUS_PROMPT.md         # Comprehensive Manus prompt
│   └── SETUP_NOTES.md          # Infrastructure and secrets
├── scripts/                     # Automation scripts
│   ├── init-project.sh         # Initialize new project
│   ├── validate-docs.sh        # Validate planning docs
│   ├── generate-manus-prompt.sh # Auto-generate Manus prompt
│   └── import-figma-wireframes.sh # Import from Figma (NEW!)
├── docs/                        # Documentation
│   ├── BEST_PRACTICES.md       # Vibe coding best practices
│   ├── FIGMA_INTEGRATION.md    # Figma integration guide (NEW!)
│   ├── MANUS_GUIDE.md          # How to work with Manus
│   └── TROUBLESHOOTING.md      # Common issues and solutions
├── examples/                    # Example projects
│   ├── simple-api/             # Simple API example
│   ├── full-stack-app/         # Full-stack example
│   └── data-analysis/          # Data analysis example
└── .github/
    └── workflows/
        └── validate.yml        # GitHub Actions for validation
```

## Core Principles

### 1. Planning First, Always

Never start coding before completing:
- Product Requirements Document (PRD)
- UI/UX wireframes
- Database schema
- Technical specifications
- Comprehensive Manus prompt

### 2. Immutable Planning Documents

Once finalized and committed, planning documents are not edited unless:
- Requirements fundamentally change
- Critical issues are discovered
- All stakeholders agree to the change
- Changes are documented with rationale

### 3. Separate Planning and Execution

- **Planning Repository:** This template, contains all planning docs
- **Execution Repository:** Created by Manus, contains actual code
- Planning repo is referenced by execution repo
- Clear separation of concerns

### 4. The Two-AI Workflow

- **ChatGPT:** Helps create and refine planning documents
- **Manus:** Executes based on planning documents
- **VS Code:** Review and understand generated code

### 5. Expect 2-3 Iterations

- First iteration: 60-70% complete
- Second iteration: 80-90% complete
- Third iteration: 95%+ complete
- This is normal and expected

## The Complete Workflow

### Phase 1: Initialize Planning Repository

```bash
# Create from template
gh repo create my-project-planning --template bradleyhope/vibe-coding-starter --private

# Clone and initialize
git clone https://github.com/yourusername/my-project-planning
cd my-project-planning
./scripts/init-project.sh
```

### Phase 2: Create Planning Documents

Use ChatGPT to help create each document:

1. **PRD** (`planning/PRD.md`)
   - What you're building and why
   - Who will use it
   - Core features
   - Success criteria

2. **Wireframes** (`planning/wireframes/`)
   - Key screens and flows
   - User interactions
   - Visual hierarchy
   - **NEW:** Import directly from Figma with `./scripts/import-figma-wireframes.sh`

3. **Database Schema** (`planning/DATABASE_SCHEMA.md`)
   - Entities and relationships
   - Fields and data types
   - Constraints and validations

4. **Technical Spec** (`planning/TECHNICAL_SPEC.md`)
   - Technology stack
   - Architecture decisions
   - External integrations
   - Deployment strategy

5. **Setup Notes** (`planning/SETUP_NOTES.md`)
   - API keys and secrets
   - Infrastructure details
   - Environment configuration

### Phase 3: Generate Manus Prompt

```bash
# Auto-generate comprehensive Manus prompt from planning docs
./scripts/generate-manus-prompt.sh

# Review and refine
vim planning/MANUS_PROMPT.md

# Validate all documents
./scripts/validate-docs.sh
```

### Phase 4: Commit and Lock Planning

```bash
# Commit all planning documents
git add planning/
git commit -m "Initial planning documents - LOCKED"
git push

# Tag as locked
git tag -a v1.0-planning -m "Planning phase complete"
git push --tags
```

### Phase 5: Execute with Manus

Open new Manus chat and provide:

```
I want to build [project name]. All planning documents are in this GitHub repository:
https://github.com/yourusername/my-project-planning

Please:
1. Clone the repository
2. Review all files in the planning/ directory
3. Start with planning/MANUS_PROMPT.md for complete instructions
4. Create a new repository for the code: my-project-code
5. Build the complete project following the specifications

Key files:
- planning/PRD.md (requirements)
- planning/DATABASE_SCHEMA.md (data model)
- planning/TECHNICAL_SPEC.md (architecture)
- planning/wireframes/ (UI mockups)
- planning/MANUS_PROMPT.md (comprehensive build instructions)
```

### Phase 6: Review and Iterate

1. Manus creates execution repository
2. Review generated code
3. Test functionality
4. Iterate if needed (2-3 times expected)
5. Deploy when complete

### Phase 7: Update Planning (If Needed)

If requirements change:

```bash
# Create new branch for planning updates
git checkout -b planning-update-v2

# Update relevant documents
vim planning/PRD.md

# Document changes
echo "## Changes in v2" >> planning/CHANGELOG.md
echo "- Updated feature X because..." >> planning/CHANGELOG.md

# Commit and merge
git add planning/
git commit -m "Planning update v2: [reason]"
git push

# Tag new version
git tag -a v2.0-planning -m "Planning update: [reason]"
git push --tags
```

## Templates Included

### 1. PRD Template (`templates/PRD.md`)
Comprehensive Product Requirements Document with all sections needed for clear requirements.

### 2. Database Schema Template (`templates/DATABASE_SCHEMA.md`)
Structured format for defining your data model with entities, relationships, and constraints.

### 3. Technical Spec Template (`templates/TECHNICAL_SPEC.md`)
Architecture decisions, technology stack, and technical requirements.

### 4. Manus Prompt Template (`templates/MANUS_PROMPT.md`)
Comprehensive prompt template that Manus can execute autonomously.

### 5. Wireframes Template (`templates/WIREFRAMES.md`)
Guide for creating and documenting UI/UX designs.

### 6. Setup Notes Template (`templates/SETUP_NOTES.md`)
Infrastructure, API keys, and environment configuration.

## Scripts Included

### `init-project.sh`
Initializes a new project from templates, prompts for project details, and sets up the planning directory structure.

### `validate-docs.sh`
Validates that all required planning documents are present and complete before execution.

### `generate-manus-prompt.sh`
Automatically generates a comprehensive Manus prompt by combining all planning documents.

### `import-figma-wireframes.sh` (NEW!)
Imports wireframes directly from Figma files using the Figma REST API. See `docs/FIGMA_INTEGRATION.md` for setup guide.

## Best Practices

### Do's

- ✅ Complete all planning before starting Manus
- ✅ Use ChatGPT to help write planning documents
- ✅ Commit planning docs before execution
- ✅ Reference planning repo from execution repo
- ✅ Expect 2-3 iterations
- ✅ Verify data accuracy in results
- ✅ Use file system for large documents

### Don'ts

- ❌ Start Manus without complete planning
- ❌ Edit planning docs during execution
- ❌ Mix planning and code in same repo
- ❌ Skip wireframes or database schema
- ❌ Expect perfection on first iteration
- ❌ Trust data analysis without verification

## Examples

See the `examples/` directory for complete example projects:

- **simple-api**: REST API with authentication
- **full-stack-app**: Next.js + Supabase application
- **data-analysis**: Python data analysis pipeline

Each example includes complete planning documents and the resulting code repository.

## Documentation

- **WORKFLOW.md**: Detailed step-by-step workflow
- **docs/BEST_PRACTICES.md**: Comprehensive vibe coding best practices
- **docs/FIGMA_INTEGRATION.md**: Complete Figma integration guide (NEW!)
- **docs/MANUS_GUIDE.md**: How to work effectively with Manus
- **docs/TROUBLESHOOTING.md**: Common issues and solutions

## Integration with Manus

This repository is designed to work seamlessly with Manus AI:

1. Manus can clone and read all planning documents
2. File structure is optimized for Manus's context management
3. Prompts are formatted for autonomous execution
4. Follows Manus's context engineering principles

## Contributing

This is a personal template repository. Fork it and customize for your own workflow.

## License

MIT License - Use freely for your projects.

## Resources

- [Manus AI Official Site](https://manus.im)
- [Manus Documentation](https://open.manus.ai/docs)
- [Vibe Coding Guide](./docs/BEST_PRACTICES.md)

---

**Version:** 1.0  
**Last Updated:** November 12, 2025  
**Maintained By:** Bradley Hope
