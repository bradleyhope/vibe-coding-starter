# Manus Build Prompt

**Project Name:** [Your Project Name]  
**Version:** 1.0  
**Date:** [Date]  
**Generated From:** Planning documents in this repository

---

## Project Overview

I want to build [project name], a [brief description of what it is and what it does].

**Target Users:** [Who will use this]

**Core Value Proposition:** [What problem it solves and how]

---

## Complete Requirements

All detailed requirements are in the planning documents in this repository. Please review:

1. **planning/PRD.md** - Complete product requirements with all features and acceptance criteria
2. **planning/DATABASE_SCHEMA.md** - Full database schema with all entities, relationships, and constraints
3. **planning/TECHNICAL_SPEC.md** - Technology stack, architecture, and technical decisions
4. **planning/wireframes/** - UI/UX designs for all screens
5. **planning/SETUP_NOTES.md** - Infrastructure details, API keys, and environment configuration

---

## Technology Stack

### Frontend
- Framework: [e.g., Next.js 14 with App Router]
- Language: [e.g., TypeScript 5.0]
- Styling: [e.g., Tailwind CSS]
- State Management: [e.g., Zustand]
- Key Libraries: [List key libraries]

### Backend
- Framework: [e.g., Next.js API Routes]
- Language: [e.g., TypeScript]
- API Style: [REST | GraphQL | tRPC]
- Authentication: [e.g., NextAuth.js]

### Database
- Database: [e.g., PostgreSQL via Supabase]
- ORM: [e.g., Prisma]
- Caching: [e.g., Redis via Upstash]

### Infrastructure
- Hosting: [e.g., Vercel]
- Database Hosting: [e.g., Supabase]
- File Storage: [e.g., S3 or Supabase Storage]

---

## Project Structure

Please create the following structure:

```
project-name/
├── src/
│   ├── app/                    # Next.js App Router
│   │   ├── (auth)/            # Auth routes group
│   │   │   ├── login/
│   │   │   └── register/
│   │   ├── (dashboard)/       # Dashboard routes group
│   │   │   ├── posts/
│   │   │   └── settings/
│   │   ├── api/               # API routes
│   │   │   ├── auth/
│   │   │   └── posts/
│   │   ├── layout.tsx
│   │   └── page.tsx
│   ├── components/
│   │   ├── ui/                # Reusable UI components
│   │   ├── features/          # Feature-specific components
│   │   └── layouts/           # Layout components
│   ├── lib/
│   │   ├── db.ts             # Database client
│   │   ├── auth.ts           # Auth utilities
│   │   └── utils.ts          # Utility functions
│   ├── hooks/                 # Custom React hooks
│   ├── types/                 # TypeScript types
│   └── styles/                # Global styles
├── prisma/
│   ├── schema.prisma          # Prisma schema
│   ├── migrations/            # Database migrations
│   └── seed.ts                # Seed data
├── public/                    # Static assets
├── tests/                     # Test files
├── .env.example              # Environment variables template
├── .env.local                # Local environment (git-ignored)
├── package.json
├── tsconfig.json
├── tailwind.config.ts
└── README.md
```

---

## Core Features to Implement

### Must-Have Features (MVP)

#### 1. [Feature Name]

**Description:** [What this feature does]

**Acceptance Criteria:**
- [ ] [Specific criterion 1]
- [ ] [Specific criterion 2]
- [ ] [Specific criterion 3]

**Implementation Notes:**
- [Any specific implementation details]
- [Edge cases to handle]
- [Validation rules]

---

#### 2. [Feature Name]

**Description:** [What this feature does]

**Acceptance Criteria:**
- [ ] [Specific criterion 1]
- [ ] [Specific criterion 2]
- [ ] [Specific criterion 3]

**Implementation Notes:**
- [Any specific implementation details]
- [Edge cases to handle]
- [Validation rules]

---

#### 3. [Feature Name]

**Description:** [What this feature does]

**Acceptance Criteria:**
- [ ] [Specific criterion 1]
- [ ] [Specific criterion 2]
- [ ] [Specific criterion 3]

**Implementation Notes:**
- [Any specific implementation details]
- [Edge cases to handle]
- [Validation rules]

---

## Database Implementation

Please implement the complete database schema from `planning/DATABASE_SCHEMA.md`:

### Key Points

1. Use the exact entity names and field names specified
2. Implement all relationships and constraints
3. Create all indexes for performance
4. Include seed data for development
5. Set up migrations properly

### Prisma Schema

Create the Prisma schema based on the database schema document. Ensure:
- All entities are defined
- All relationships are properly configured
- Enums are defined
- Indexes are created
- Default values are set

---

## API Implementation

Implement all API endpoints specified in `planning/TECHNICAL_SPEC.md`:

### Authentication Endpoints

- POST /api/auth/register
- POST /api/auth/login
- POST /api/auth/logout
- GET /api/auth/me

### [Resource] Endpoints

- GET /api/[resource] (list with pagination)
- GET /api/[resource]/:id (get single)
- POST /api/[resource] (create)
- PUT /api/[resource]/:id (update)
- DELETE /api/[resource]/:id (delete)

### Requirements

1. Implement proper authentication middleware
2. Add input validation using Zod
3. Include error handling
4. Return consistent response formats
5. Add rate limiting
6. Include proper HTTP status codes

---

## UI/UX Implementation

Implement the UI based on wireframes in `planning/wireframes/`:

### Key Screens

1. **Landing Page**
   - [Description of what should be on this page]
   - [Key elements and interactions]

2. **Authentication Pages**
   - Login page with email/password
   - Registration page with validation
   - Password reset flow

3. **Dashboard**
   - [Description of dashboard layout]
   - [Key components and data displayed]

4. **[Feature] Pages**
   - List view with pagination
   - Detail view
   - Create/edit forms

### UI Requirements

1. Responsive design (mobile, tablet, desktop)
2. Loading states for all async operations
3. Error states with user-friendly messages
4. Success feedback (toasts/notifications)
5. Form validation with inline errors
6. Accessible (ARIA labels, keyboard navigation)

---

## Authentication & Authorization

Implement authentication using [NextAuth.js | Supabase Auth | Custom JWT]:

### Requirements

1. User registration with email verification
2. Login with email/password
3. JWT token-based authentication
4. Protected routes (redirect to login if not authenticated)
5. Role-based access control (admin, user)
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

Create `.env.example` with all required environment variables:

```bash
# Database
DATABASE_URL=

# Authentication
NEXTAUTH_SECRET=
NEXTAUTH_URL=

# External Services
[SERVICE_API_KEY]=
[SERVICE_SECRET]=

# Feature Flags
ENABLE_[FEATURE]=
```

Actual values are in `planning/SETUP_NOTES.md` (do not commit to git).

---

## Testing

Include basic testing setup:

1. Unit tests for utility functions
2. Integration tests for API endpoints
3. Test data factories
4. Setup and teardown for test database

---

## Documentation

Create comprehensive documentation:

### README.md

Include:
- Project overview
- Setup instructions
- Environment variables
- Development workflow
- Deployment instructions
- Testing instructions

### API Documentation

Document all API endpoints with:
- Method and path
- Request parameters
- Request body schema
- Response schema
- Example requests/responses
- Error responses

---

## Success Criteria

This project is complete when:

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

The following are explicitly NOT part of this build:

1. [Feature or aspect not included]
2. [Feature or aspect not included]
3. [Feature or aspect not included]

---

## Implementation Notes

### Code Quality

1. Use TypeScript strict mode
2. Follow consistent naming conventions
3. Add comments for complex logic
4. Keep functions small and focused
5. Use meaningful variable names

### Error Handling

1. Wrap async operations in try-catch
2. Return user-friendly error messages
3. Log errors for debugging
4. Handle edge cases gracefully

### Performance

1. Optimize database queries
2. Add loading states
3. Implement pagination for lists
4. Use caching where appropriate

---

## Execution Instructions

Please:

1. **Review all planning documents** in the `planning/` directory
2. **Ask clarifying questions** if anything is unclear or ambiguous
3. **Create the project structure** as specified above
4. **Implement all features** following the acceptance criteria
5. **Test as you build** to ensure everything works
6. **Document your work** in README and code comments
7. **Create a new repository** for the code (separate from this planning repo)
8. **Provide a summary** of what was built and any issues encountered

---

## Reference Documents

All detailed specifications are in:

- `planning/PRD.md` - Product requirements
- `planning/DATABASE_SCHEMA.md` - Database design
- `planning/TECHNICAL_SPEC.md` - Technical architecture
- `planning/wireframes/` - UI designs
- `planning/SETUP_NOTES.md` - Infrastructure and secrets

Please refer to these documents for complete details on every aspect of the implementation.

---

**Ready to start? Please confirm you've reviewed all planning documents and ask any clarifying questions before beginning implementation.**
