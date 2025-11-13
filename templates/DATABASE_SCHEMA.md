# Database Schema

**Project Name:** [Your Project Name]  
**Version:** 1.0  
**Date:** [Date]  
**Database:** PostgreSQL | MySQL | MongoDB | Supabase | Firebase | Other  
**Status:** Draft | In Review | Approved | Locked

---

## Overview

[Brief description of your data model and key design decisions]

---

## Entity Relationship Diagram

```
[Include ASCII diagram or link to visual ERD]

Example:
┌─────────────┐         ┌─────────────┐         ┌─────────────┐
│    Users    │────────<│    Posts    │>────────│  Comments   │
└─────────────┘         └─────────────┘         └─────────────┘
      │                                                 │
      │                                                 │
      └─────────────────────────────────────────────────┘
```

---

## Entities

### Entity 1: Users

**Description:** [What this entity represents]

**Table Name:** `users`

#### Fields

| Field Name | Data Type | Constraints | Description |
|------------|-----------|-------------|-------------|
| id | UUID | PRIMARY KEY, NOT NULL | Unique user identifier |
| email | VARCHAR(255) | UNIQUE, NOT NULL | User email address |
| password_hash | VARCHAR(255) | NOT NULL | Hashed password |
| full_name | VARCHAR(255) | NOT NULL | User's full name |
| created_at | TIMESTAMP | NOT NULL, DEFAULT NOW() | Account creation timestamp |
| updated_at | TIMESTAMP | NOT NULL, DEFAULT NOW() | Last update timestamp |
| is_active | BOOLEAN | NOT NULL, DEFAULT TRUE | Account active status |
| role | ENUM | NOT NULL, DEFAULT 'user' | User role (admin, user, etc.) |

#### Indexes

- `idx_users_email` on `email` (for login lookups)
- `idx_users_created_at` on `created_at` (for sorting)

#### Relationships

- One-to-Many with `posts` (one user has many posts)
- One-to-Many with `comments` (one user has many comments)

---

### Entity 2: Posts

**Description:** [What this entity represents]

**Table Name:** `posts`

#### Fields

| Field Name | Data Type | Constraints | Description |
|------------|-----------|-------------|-------------|
| id | UUID | PRIMARY KEY, NOT NULL | Unique post identifier |
| user_id | UUID | FOREIGN KEY (users.id), NOT NULL | Author of the post |
| title | VARCHAR(255) | NOT NULL | Post title |
| content | TEXT | NOT NULL | Post content |
| slug | VARCHAR(255) | UNIQUE, NOT NULL | URL-friendly slug |
| status | ENUM | NOT NULL, DEFAULT 'draft' | Post status (draft, published, archived) |
| published_at | TIMESTAMP | NULL | Publication timestamp |
| created_at | TIMESTAMP | NOT NULL, DEFAULT NOW() | Creation timestamp |
| updated_at | TIMESTAMP | NOT NULL, DEFAULT NOW() | Last update timestamp |
| view_count | INTEGER | NOT NULL, DEFAULT 0 | Number of views |

#### Indexes

- `idx_posts_user_id` on `user_id` (for user's posts)
- `idx_posts_slug` on `slug` (for URL lookups)
- `idx_posts_published_at` on `published_at` (for sorting)
- `idx_posts_status` on `status` (for filtering)

#### Relationships

- Many-to-One with `users` (many posts belong to one user)
- One-to-Many with `comments` (one post has many comments)

---

### Entity 3: Comments

**Description:** [What this entity represents]

**Table Name:** `comments`

#### Fields

| Field Name | Data Type | Constraints | Description |
|------------|-----------|-------------|-------------|
| id | UUID | PRIMARY KEY, NOT NULL | Unique comment identifier |
| post_id | UUID | FOREIGN KEY (posts.id), NOT NULL | Post being commented on |
| user_id | UUID | FOREIGN KEY (users.id), NOT NULL | Comment author |
| content | TEXT | NOT NULL | Comment content |
| parent_id | UUID | FOREIGN KEY (comments.id), NULL | Parent comment for threading |
| created_at | TIMESTAMP | NOT NULL, DEFAULT NOW() | Creation timestamp |
| updated_at | TIMESTAMP | NOT NULL, DEFAULT NOW() | Last update timestamp |
| is_deleted | BOOLEAN | NOT NULL, DEFAULT FALSE | Soft delete flag |

#### Indexes

- `idx_comments_post_id` on `post_id` (for post's comments)
- `idx_comments_user_id` on `user_id` (for user's comments)
- `idx_comments_parent_id` on `parent_id` (for threaded comments)
- `idx_comments_created_at` on `created_at` (for sorting)

#### Relationships

- Many-to-One with `posts` (many comments belong to one post)
- Many-to-One with `users` (many comments belong to one user)
- Self-referential One-to-Many (comments can have child comments)

---

## Enumerations

### UserRole

```sql
CREATE TYPE user_role AS ENUM ('admin', 'moderator', 'user', 'guest');
```

### PostStatus

```sql
CREATE TYPE post_status AS ENUM ('draft', 'published', 'archived');
```

---

## Constraints and Validations

### Business Rules

1. **Email Uniqueness:** Each email can only be associated with one user account
2. **Post Ownership:** Posts cannot be orphaned (must have a valid user_id)
3. **Comment Threading:** Comments can be nested up to 3 levels deep
4. **Soft Deletes:** Comments are soft-deleted (is_deleted flag) to preserve conversation context

### Data Integrity

1. **Cascade Deletes:**
   - When a user is deleted, all their posts are deleted
   - When a post is deleted, all its comments are deleted
   - When a parent comment is deleted, child comments are orphaned (parent_id set to NULL)

2. **Required Fields:**
   - Users must have email, password_hash, and full_name
   - Posts must have user_id, title, and content
   - Comments must have post_id, user_id, and content

---

## Migrations Strategy

### Initial Migration

```sql
-- Create users table
CREATE TABLE users (
    id UUID PRIMARY KEY DEFAULT gen_random_uuid(),
    email VARCHAR(255) UNIQUE NOT NULL,
    password_hash VARCHAR(255) NOT NULL,
    full_name VARCHAR(255) NOT NULL,
    created_at TIMESTAMP NOT NULL DEFAULT NOW(),
    updated_at TIMESTAMP NOT NULL DEFAULT NOW(),
    is_active BOOLEAN NOT NULL DEFAULT TRUE,
    role user_role NOT NULL DEFAULT 'user'
);

-- Create posts table
CREATE TABLE posts (
    id UUID PRIMARY KEY DEFAULT gen_random_uuid(),
    user_id UUID NOT NULL REFERENCES users(id) ON DELETE CASCADE,
    title VARCHAR(255) NOT NULL,
    content TEXT NOT NULL,
    slug VARCHAR(255) UNIQUE NOT NULL,
    status post_status NOT NULL DEFAULT 'draft',
    published_at TIMESTAMP NULL,
    created_at TIMESTAMP NOT NULL DEFAULT NOW(),
    updated_at TIMESTAMP NOT NULL DEFAULT NOW(),
    view_count INTEGER NOT NULL DEFAULT 0
);

-- Create comments table
CREATE TABLE comments (
    id UUID PRIMARY KEY DEFAULT gen_random_uuid(),
    post_id UUID NOT NULL REFERENCES posts(id) ON DELETE CASCADE,
    user_id UUID NOT NULL REFERENCES users(id) ON DELETE CASCADE,
    content TEXT NOT NULL,
    parent_id UUID REFERENCES comments(id) ON DELETE SET NULL,
    created_at TIMESTAMP NOT NULL DEFAULT NOW(),
    updated_at TIMESTAMP NOT NULL DEFAULT NOW(),
    is_deleted BOOLEAN NOT NULL DEFAULT FALSE
);

-- Create indexes
CREATE INDEX idx_users_email ON users(email);
CREATE INDEX idx_users_created_at ON users(created_at);
CREATE INDEX idx_posts_user_id ON posts(user_id);
CREATE INDEX idx_posts_slug ON posts(slug);
CREATE INDEX idx_posts_published_at ON posts(published_at);
CREATE INDEX idx_posts_status ON posts(status);
CREATE INDEX idx_comments_post_id ON comments(post_id);
CREATE INDEX idx_comments_user_id ON comments(user_id);
CREATE INDEX idx_comments_parent_id ON comments(parent_id);
CREATE INDEX idx_comments_created_at ON comments(created_at);
```

---

## Seed Data

### Development Seeds

```sql
-- Insert test users
INSERT INTO users (email, password_hash, full_name, role) VALUES
('admin@example.com', '$2a$10$...', 'Admin User', 'admin'),
('user@example.com', '$2a$10$...', 'Test User', 'user');

-- Insert test posts
INSERT INTO posts (user_id, title, content, slug, status, published_at) VALUES
((SELECT id FROM users WHERE email = 'admin@example.com'), 
 'First Post', 
 'This is the first post content', 
 'first-post', 
 'published', 
 NOW());
```

---

## Scalability Considerations

### Current Scale

- Expected users: [X]
- Expected posts: [X]
- Expected comments: [X]
- Expected queries per second: [X]

### Future Scale

- Projected users (1 year): [X]
- Projected posts (1 year): [X]
- Projected comments (1 year): [X]
- Projected queries per second (1 year): [X]

### Optimization Strategies

1. **Indexing:** All foreign keys and frequently queried fields are indexed
2. **Caching:** Implement Redis caching for frequently accessed posts
3. **Partitioning:** Consider partitioning posts table by created_at if it grows beyond 10M records
4. **Read Replicas:** Add read replicas when read QPS exceeds 1000

---

## Security Considerations

1. **Password Storage:** Passwords are hashed using bcrypt with cost factor 10
2. **SQL Injection:** Use parameterized queries exclusively
3. **Data Encryption:** Sensitive fields (if any) are encrypted at rest
4. **Access Control:** Row-level security policies enforce user permissions

---

## Backup and Recovery

### Backup Strategy

- Full backup: Daily at 2 AM UTC
- Incremental backup: Every 6 hours
- Retention: 30 days
- Location: [Backup location]

### Recovery Plan

- Recovery Time Objective (RTO): [X hours]
- Recovery Point Objective (RPO): [X hours]
- Disaster recovery procedure: [Link to runbook]

---

## Change Log

### Version 1.0 - [Date]

- Initial schema design

### Version 1.1 - [Date] (if applicable)

- [Changes made and rationale]

---

## Approval

**Database Architect:** [Name] - [Approval Date]  
**Technical Lead:** [Name] - [Approval Date]  
**Security Review:** [Name] - [Approval Date]

---

**Status:** Once approved, this document is LOCKED and should not be edited unless requirements fundamentally change and all stakeholders agree.
