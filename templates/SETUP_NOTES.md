# Setup Notes & Infrastructure

**Project Name:** [Your Project Name]  
**Version:** 1.0  
**Date:** [Date]  
**Status:** Draft | In Review | Approved | Locked

⚠️ **IMPORTANT:** This file contains sensitive information. Never commit actual secrets to version control.

---

## Environment Variables

### Development (.env.local)

```bash
# Database
DATABASE_URL="postgresql://user:password@localhost:5432/dbname"
DIRECT_URL="postgresql://user:password@localhost:5432/dbname" # For Prisma migrations

# Redis Cache
REDIS_URL="redis://localhost:6379"

# Authentication
NEXTAUTH_URL="http://localhost:3000"
NEXTAUTH_SECRET="[Generate with: openssl rand -base64 32]"
JWT_SECRET="[Generate with: openssl rand -base64 32]"
JWT_EXPIRES_IN="15m"
REFRESH_TOKEN_SECRET="[Generate with: openssl rand -base64 32]"
REFRESH_TOKEN_EXPIRES_IN="7d"

# OAuth Providers (if using)
GOOGLE_CLIENT_ID="your-google-client-id"
GOOGLE_CLIENT_SECRET="your-google-client-secret"
GITHUB_CLIENT_ID="your-github-client-id"
GITHUB_CLIENT_SECRET="your-github-client-secret"

# Email Service (e.g., SendGrid, Resend)
EMAIL_SERVER_HOST="smtp.sendgrid.net"
EMAIL_SERVER_PORT="587"
EMAIL_SERVER_USER="apikey"
EMAIL_SERVER_PASSWORD="your-sendgrid-api-key"
EMAIL_FROM="noreply@yourdomain.com"

# File Storage (S3 or Supabase Storage)
S3_BUCKET_NAME="your-bucket-name"
S3_REGION="us-east-1"
S3_ACCESS_KEY_ID="your-access-key"
S3_SECRET_ACCESS_KEY="your-secret-key"
S3_ENDPOINT="https://s3.amazonaws.com" # Or custom endpoint

# Monitoring & Analytics
SENTRY_DSN="your-sentry-dsn"
SENTRY_AUTH_TOKEN="your-sentry-auth-token"
NEXT_PUBLIC_ANALYTICS_ID="your-analytics-id"

# Feature Flags
ENABLE_FEATURE_X="true"
ENABLE_BETA_FEATURES="false"

# API Rate Limiting
RATE_LIMIT_WINDOW="60000" # 1 minute in ms
RATE_LIMIT_MAX_REQUESTS="100"

# Other Services
STRIPE_SECRET_KEY="sk_test_..."
STRIPE_PUBLISHABLE_KEY="pk_test_..."
STRIPE_WEBHOOK_SECRET="whsec_..."
```

### Staging (.env.staging)

```bash
# Same structure as development but with staging values
DATABASE_URL="[Staging database URL]"
NEXTAUTH_URL="https://staging.yourdomain.com"
# ... other staging-specific values
```

### Production (.env.production)

```bash
# Same structure as development but with production values
DATABASE_URL="[Production database URL]"
NEXTAUTH_URL="https://yourdomain.com"
# ... other production-specific values
```

---

## Service Setup Instructions

### 1. Database (Supabase)

**Service:** Supabase  
**URL:** https://supabase.com

**Setup Steps:**

1. Create new project at supabase.com
2. Navigate to Project Settings > Database
3. Copy connection string
4. Add to `DATABASE_URL` in `.env.local`
5. For Prisma, also add `DIRECT_URL` (same as DATABASE_URL but with `?pgbouncer=true` removed)

**Connection Strings:**
```bash
# Pooled connection (for app)
DATABASE_URL="postgresql://postgres:[password]@db.[project-ref].supabase.co:5432/postgres?pgbouncer=true"

# Direct connection (for migrations)
DIRECT_URL="postgresql://postgres:[password]@db.[project-ref].supabase.co:5432/postgres"
```

**Notes:**
- Enable Row Level Security (RLS) for production
- Set up database backups
- Configure connection pooling

---

### 2. Authentication (NextAuth.js)

**Service:** NextAuth.js  
**Docs:** https://next-auth.js.org

**Setup Steps:**

1. Install: `pnpm add next-auth`
2. Generate secrets:
   ```bash
   openssl rand -base64 32  # For NEXTAUTH_SECRET
   openssl rand -base64 32  # For JWT_SECRET
   ```
3. Add to `.env.local`
4. Create `/app/api/auth/[...nextauth]/route.ts`

**OAuth Setup (Optional):**

For Google OAuth:
1. Go to Google Cloud Console
2. Create new project
3. Enable Google+ API
4. Create OAuth 2.0 credentials
5. Add authorized redirect URI: `http://localhost:3000/api/auth/callback/google`
6. Copy Client ID and Secret to `.env.local`

For GitHub OAuth:
1. Go to GitHub Settings > Developer settings > OAuth Apps
2. Create new OAuth App
3. Set callback URL: `http://localhost:3000/api/auth/callback/github`
4. Copy Client ID and Secret to `.env.local`

---

### 3. Email Service (Resend)

**Service:** Resend  
**URL:** https://resend.com

**Setup Steps:**

1. Sign up at resend.com
2. Verify your domain
3. Create API key
4. Add to `.env.local`:
   ```bash
   RESEND_API_KEY="re_..."
   EMAIL_FROM="noreply@yourdomain.com"
   ```

**Alternative: SendGrid**
```bash
EMAIL_SERVER_HOST="smtp.sendgrid.net"
EMAIL_SERVER_PORT="587"
EMAIL_SERVER_USER="apikey"
EMAIL_SERVER_PASSWORD="your-sendgrid-api-key"
```

---

### 4. File Storage (Supabase Storage)

**Service:** Supabase Storage  
**Docs:** https://supabase.com/docs/guides/storage

**Setup Steps:**

1. In Supabase dashboard, go to Storage
2. Create new bucket (e.g., "uploads")
3. Set bucket to public or private based on needs
4. Use Supabase client to upload files

**Alternative: AWS S3**
```bash
S3_BUCKET_NAME="your-bucket-name"
S3_REGION="us-east-1"
S3_ACCESS_KEY_ID="AKIA..."
S3_SECRET_ACCESS_KEY="..."
```

---

### 5. Caching (Upstash Redis)

**Service:** Upstash  
**URL:** https://upstash.com

**Setup Steps:**

1. Create account at upstash.com
2. Create new Redis database
3. Copy connection string
4. Add to `.env.local`:
   ```bash
   REDIS_URL="redis://default:[password]@[endpoint]:6379"
   ```

**Usage:**
- Cache frequently accessed data
- Session storage
- Rate limiting

---

### 6. Monitoring (Sentry)

**Service:** Sentry  
**URL:** https://sentry.io

**Setup Steps:**

1. Create account at sentry.io
2. Create new project (Next.js)
3. Copy DSN
4. Install: `pnpm add @sentry/nextjs`
5. Run: `npx @sentry/wizard@latest -i nextjs`
6. Add DSN to `.env.local`

**Configuration:**
- Capture errors automatically
- Set up performance monitoring
- Configure source maps for production

---

### 7. Analytics (Vercel Analytics)

**Service:** Vercel Analytics  
**Docs:** https://vercel.com/docs/analytics

**Setup Steps:**

1. Install: `pnpm add @vercel/analytics`
2. Add to root layout:
   ```typescript
   import { Analytics } from '@vercel/analytics/react';
   
   export default function RootLayout({ children }) {
     return (
       <html>
         <body>
           {children}
           <Analytics />
         </body>
       </html>
     );
   }
   ```

**Alternative: Google Analytics**
```bash
NEXT_PUBLIC_GA_ID="G-XXXXXXXXXX"
```

---

### 8. Payments (Stripe)

**Service:** Stripe  
**URL:** https://stripe.com

**Setup Steps:**

1. Create account at stripe.com
2. Get API keys from Dashboard > Developers > API keys
3. Add to `.env.local`:
   ```bash
   STRIPE_SECRET_KEY="sk_test_..." # Use sk_live_ for production
   STRIPE_PUBLISHABLE_KEY="pk_test_..." # Use pk_live_ for production
   ```
4. Set up webhook endpoint:
   - URL: `https://yourdomain.com/api/webhooks/stripe`
   - Events: `checkout.session.completed`, `customer.subscription.updated`, etc.
5. Copy webhook secret to `.env.local`:
   ```bash
   STRIPE_WEBHOOK_SECRET="whsec_..."
   ```

---

## Deployment Configuration

### Vercel

**Setup Steps:**

1. Install Vercel CLI: `pnpm add -g vercel`
2. Login: `vercel login`
3. Link project: `vercel link`
4. Add environment variables in Vercel dashboard
5. Deploy: `vercel --prod`

**Environment Variables:**
- Add all production env vars in Vercel dashboard
- Settings > Environment Variables
- Separate values for Production, Preview, Development

**Build Settings:**
- Framework Preset: Next.js
- Build Command: `pnpm build`
- Output Directory: `.next`
- Install Command: `pnpm install`

---

### Railway

**Setup Steps:**

1. Create account at railway.app
2. Create new project
3. Connect GitHub repository
4. Add environment variables
5. Deploy

**Database:**
- Railway provides PostgreSQL plugin
- Automatically sets DATABASE_URL

---

### Custom Server (e.g., DigitalOcean)

**Requirements:**
- Node.js 20+
- PostgreSQL 15+
- Redis (optional)
- Nginx (reverse proxy)
- PM2 (process manager)

**Setup:**
```bash
# Install dependencies
sudo apt update
sudo apt install nodejs npm postgresql redis-server nginx

# Install PM2
npm install -g pm2

# Clone repository
git clone https://github.com/yourusername/your-project
cd your-project

# Install dependencies
pnpm install

# Build
pnpm build

# Start with PM2
pm2 start npm --name "your-project" -- start
pm2 save
pm2 startup
```

---

## Database Migrations

### Initial Setup

```bash
# Generate Prisma client
pnpm prisma generate

# Create initial migration
pnpm prisma migrate dev --name init

# Seed database
pnpm prisma db seed
```

### Production Migrations

```bash
# Run migrations in production
pnpm prisma migrate deploy
```

---

## CI/CD Pipeline

### GitHub Actions

Create `.github/workflows/deploy.yml`:

```yaml
name: Deploy

on:
  push:
    branches: [main]

jobs:
  deploy:
    runs-on: ubuntu-latest
    
    steps:
      - uses: actions/checkout@v3
      
      - name: Setup Node.js
        uses: actions/setup-node@v3
        with:
          node-version: '20'
          
      - name: Install dependencies
        run: pnpm install
        
      - name: Run tests
        run: pnpm test
        
      - name: Build
        run: pnpm build
        
      - name: Deploy to Vercel
        uses: amondnet/vercel-action@v20
        with:
          vercel-token: ${{ secrets.VERCEL_TOKEN }}
          vercel-org-id: ${{ secrets.ORG_ID }}
          vercel-project-id: ${{ secrets.PROJECT_ID }}
```

---

## Secrets Management

### Development

- Use `.env.local` (git-ignored)
- Never commit secrets to repository
- Share secrets securely (1Password, LastPass, etc.)

### Production

- Use platform environment variables (Vercel, Railway, etc.)
- Rotate secrets regularly
- Use different secrets for each environment
- Enable secret scanning on GitHub

---

## Backup Strategy

### Database Backups

**Supabase:**
- Automatic daily backups (retained for 7 days on free tier)
- Manual backups before major changes
- Export: `pg_dump` via Supabase CLI

**Manual Backup:**
```bash
pg_dump $DATABASE_URL > backup-$(date +%Y%m%d).sql
```

### File Storage Backups

- Enable versioning on S3 buckets
- Regular exports to separate backup storage
- Test restore procedures quarterly

---

## Security Checklist

- [ ] All secrets in environment variables (not in code)
- [ ] `.env.local` in `.gitignore`
- [ ] Different secrets for each environment
- [ ] HTTPS enabled in production
- [ ] Database connections encrypted
- [ ] Rate limiting enabled
- [ ] CORS configured properly
- [ ] Input validation on all endpoints
- [ ] SQL injection prevention (parameterized queries)
- [ ] XSS prevention (sanitize HTML)
- [ ] CSRF protection enabled
- [ ] Security headers configured
- [ ] Regular dependency updates
- [ ] Secrets rotation schedule

---

## Monitoring & Alerts

### Error Tracking

- Sentry for error tracking
- Alert on error rate > 5%
- Daily error summary emails

### Performance Monitoring

- Vercel Analytics for frontend
- Database query performance monitoring
- API response time tracking

### Uptime Monitoring

- Use UptimeRobot or similar
- Check every 5 minutes
- Alert via email/SMS on downtime

---

## Support Contacts

### Services

- **Supabase Support:** support@supabase.io
- **Vercel Support:** support@vercel.com
- **Stripe Support:** support@stripe.com

### Team

- **Technical Lead:** [Name] - [Email]
- **DevOps:** [Name] - [Email]
- **On-Call:** [Rotation schedule]

---

## Change Log

### Version 1.0 - [Date]

- Initial setup documentation

### Version 1.1 - [Date] (if applicable)

- [Changes made and rationale]

---

**Status:** Once approved, this document is LOCKED and should not be edited unless infrastructure changes and all stakeholders agree.
