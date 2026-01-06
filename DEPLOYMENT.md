# 🚀 Deployment Guide

Complete guide for deploying both NFL and MMA simulations to Vercel with automated CI/CD.

---

## 📋 Prerequisites

Before deploying, make sure you have:
- ✅ GitHub account
- ✅ Vercel account (sign up at vercel.com)
- ✅ PostgreSQL database (your helium database or a production database)
- ✅ Code pushed to GitHub

---

## 🎯 Quick Deploy (Vercel UI Method)

### Method 1: Via Vercel Dashboard (Easiest)

#### Step 1: Push to GitHub
```bash
cd sports-sims
git init
git add .
git commit -m "Initial commit: NFL and MMA simulations"
git remote add origin https://github.com/YOUR_USERNAME/sports-sims.git
git branch -M main
git push -u origin main
```

#### Step 2: Deploy NFL Simulation

1. Go to [vercel.com/new](https://vercel.com/new)
2. Import your GitHub repository
3. **Configure Project:**
   - Framework Preset: **Next.js**
   - Root Directory: **apps/nfl-sim**
   - Build Command: `cd ../.. && npm install && npm run build:nfl`
   - Output Directory: `.next`
   - Install Command: `cd ../.. && npm install`

4. **Add Environment Variables:**
   ```
   DATABASE_URL = postgresql://postgres:password@helium/heliumdb?sslmode=disable
   ```
   ⚠️ **Important:** Use your production database URL, not your local dev one!

5. Click **Deploy**
6. Wait for deployment to complete
7. Your NFL sim will be live at: `your-project.vercel.app`

#### Step 3: Deploy MMA Simulation

1. Go to [vercel.com/new](https://vercel.com/new) again
2. Import the **same** GitHub repository
3. **Configure Project:**
   - Framework Preset: **Next.js**
   - Root Directory: **apps/mma-sim**
   - Build Command: `cd ../.. && npm install && npm run build:mma`
   - Output Directory: `.next`
   - Install Command: `cd ../.. && npm install`

4. **Add Environment Variables:**
   ```
   DATABASE_URL = postgresql://postgres:password@helium/heliumdb?sslmode=disable
   ```

5. Click **Deploy**
6. Your MMA sim will be live at: `your-project-mma.vercel.app`

---

## 🤖 Automated Deploy (GitHub Actions)

### Setup Automated Deployments

This will automatically deploy when you push to GitHub!

#### Step 1: Get Your Vercel Token

1. Go to [vercel.com/account/tokens](https://vercel.com/account/tokens)
2. Click **Create Token**
3. Name it: `Sports Sims Deployment`
4. Copy the token (you'll only see it once!)

#### Step 2: Add Vercel Token to GitHub

1. Go to your GitHub repository
2. Navigate to **Settings** → **Secrets and variables** → **Actions**
3. Click **New repository secret**
4. Name: `VERCEL_TOKEN`
5. Value: Paste your Vercel token
6. Click **Add secret**

#### Step 3: Link Projects to Vercel

For **NFL Sim**:
```bash
cd apps/nfl-sim
vercel link
# Follow prompts to link to your Vercel project
```

For **MMA Sim**:
```bash
cd apps/mma-sim
vercel link
# Follow prompts to link to your Vercel project
```

#### Step 4: Deploy!

Now every time you push to the `main` branch, GitHub Actions will automatically deploy:

```bash
git add .
git commit -m "Add new feature"
git push origin main
```

GitHub Actions will:
- ✅ Detect changes
- ✅ Build the projects
- ✅ Deploy to Vercel
- ✅ Update your live sites

---

## 🗄️ Database Setup for Production

### Option 1: Use Your Existing Database

If your helium database is accessible from the internet:
```
DATABASE_URL=postgresql://postgres:password@helium/heliumdb?sslmode=require
```

### Option 2: Use a Cloud Database

#### Supabase (Recommended)
1. Go to [supabase.com](https://supabase.com)
2. Create new project
3. Go to **Settings** → **Database**
4. Copy the connection string
5. Update `DATABASE_URL` in Vercel

#### Neon
1. Go to [neon.tech](https://neon.tech)
2. Create new project
3. Copy connection string
4. Update `DATABASE_URL` in Vercel

#### Railway
1. Go to [railway.app](https://railway.app)
2. Create PostgreSQL database
3. Copy connection string
4. Update `DATABASE_URL` in Vercel

### Run Migrations on Production Database

```bash
# Update DATABASE_URL in terminal
export DATABASE_URL="your_production_database_url"

# Run migrations
npm run db:migrate
```

---

## 🔧 Vercel CLI Method (Advanced)

### Install Vercel CLI
```bash
npm install -g vercel
```

### Login
```bash
vercel login
```

### Deploy NFL Sim
```bash
cd apps/nfl-sim
vercel --prod
```

### Deploy MMA Sim
```bash
cd apps/mma-sim
vercel --prod
```

---

## 📊 Monitoring Your Deployments

### View Deployment Status

**Via Vercel Dashboard:**
1. Go to [vercel.com/dashboard](https://vercel.com/dashboard)
2. Click on your project
3. View deployment logs, analytics, and performance

**Via GitHub Actions:**
1. Go to your repository
2. Click **Actions** tab
3. View deployment workflows and logs

---

## 🎨 Custom Domains

### Add Custom Domain to Your Projects

1. Go to your project in Vercel
2. Click **Settings** → **Domains**
3. Add your domain (e.g., `nflsim.yourdomain.com`)
4. Follow DNS configuration instructions
5. Wait for DNS propagation (5-30 minutes)

Example setup:
- NFL Sim: `nfl.yourdomain.com`
- MMA Sim: `mma.yourdomain.com`

---

## 🔐 Environment Variables

### Required Variables

Both apps need:
```bash
DATABASE_URL=postgresql://user:password@host:port/database
```

### Optional Variables

```bash
# NextAuth (if you add authentication)
NEXTAUTH_URL=https://your-domain.com
NEXTAUTH_SECRET=your-secret-key

# Analytics (if you add them)
NEXT_PUBLIC_GA_ID=your-google-analytics-id
```

### Add Variables in Vercel

1. Go to project settings
2. Click **Environment Variables**
3. Add variable name and value
4. Select environments (Production, Preview, Development)
5. Click **Save**

---

## 🐛 Troubleshooting

### Build Fails

**Error: Cannot find module**
```bash
# Solution: Check that all dependencies are in package.json
npm install
```

**Error: Build command failed**
```bash
# Solution: Verify root directory is set correctly
# NFL: apps/nfl-sim
# MMA: apps/mma-sim
```

### Database Connection Issues

**Error: Connection timeout**
- Check DATABASE_URL is correct
- Verify database is accessible from internet
- Check SSL mode (`sslmode=require` for production)

**Error: SSL required**
```bash
# Add to connection string:
?sslmode=require
```

### App Not Loading

**Check these:**
1. Build logs in Vercel dashboard
2. Environment variables are set
3. Database is running and accessible
4. All dependencies installed correctly

---

## 📈 Performance Optimization

### Recommended Vercel Settings

1. **Enable Edge Functions** (for faster global performance)
2. **Configure Caching** (for static assets)
3. **Enable Analytics** (monitor performance)
4. **Set up Speed Insights** (track Core Web Vitals)

### Database Optimization

1. Add connection pooling
2. Enable query caching
3. Add database indexes (already included in schemas)
4. Consider read replicas for high traffic

---

## 🔄 Deployment Checklist

Before deploying to production:

- [ ] Code is pushed to GitHub
- [ ] Environment variables configured in Vercel
- [ ] Database migrations run on production DB
- [ ] Test locally with production database
- [ ] Custom domain configured (if applicable)
- [ ] GitHub Actions secrets added (if using CI/CD)
- [ ] Monitoring/analytics set up
- [ ] SSL certificates active
- [ ] CORS configured (if needed)
- [ ] Error tracking enabled

---

## 🎯 Quick Commands Reference

```bash
# Push to GitHub
git add .
git commit -m "Your message"
git push origin main

# Deploy via Vercel CLI
cd apps/nfl-sim && vercel --prod
cd apps/mma-sim && vercel --prod

# Check deployment status
vercel ls

# View deployment logs
vercel logs

# Link to existing project
vercel link
```

---

## 🆘 Need Help?

### Check Logs
```bash
# Vercel CLI
vercel logs your-deployment-url

# Or in Vercel Dashboard:
Project → Deployments → Click deployment → View Function Logs
```

### Common Issues

1. **"Cannot find module"** - Run `npm install` in root
2. **"Build failed"** - Check build command and root directory
3. **"Database connection failed"** - Verify DATABASE_URL
4. **"404 Not Found"** - Check output directory is `.next`

---

## 🎉 Success!

Once deployed, your apps will be live at:
- **NFL Sim:** `https://your-nfl-project.vercel.app`
- **MMA Sim:** `https://your-mma-project.vercel.app`

Share them, test them, and start adding features! 🏈🥊

---

**Pro Tip:** Set up preview deployments by connecting a development branch. Every PR will get its own preview URL for testing before merging to main!
