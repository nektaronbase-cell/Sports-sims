# ⚡ Quick Deploy Reference

## 🎯 Fastest Deploy (5 minutes)

### 1. Push to GitHub
```bash
./deploy.sh
# Or manually:
git init
git add .
git commit -m "Initial commit"
git remote add origin https://github.com/YOUR_USERNAME/sports-sims.git
git branch -M main
git push -u origin main
```

### 2. Deploy to Vercel

#### NFL Sim:
1. Go to [vercel.com/new](https://vercel.com/new)
2. Import your repo
3. Root Directory: `apps/nfl-sim`
4. Build Command: `cd ../.. && npm install && npm run build:nfl`
5. Add `DATABASE_URL` environment variable
6. Deploy!

#### MMA Sim:
1. Go to [vercel.com/new](https://vercel.com/new) again
2. Import same repo
3. Root Directory: `apps/mma-sim`
4. Build Command: `cd ../.. && npm install && npm run build:mma`
5. Add `DATABASE_URL` environment variable
6. Deploy!

---

## 🤖 Automated Deploy

### Setup Once:
1. Get Vercel token: [vercel.com/account/tokens](https://vercel.com/account/tokens)
2. Add to GitHub: Settings → Secrets → `VERCEL_TOKEN`
3. Link projects: `cd apps/nfl-sim && vercel link`
4. Done! Auto-deploys on every push

---

## 🗄️ Database Options

### Quick Production DB:
- **Supabase** (Easiest): [supabase.com](https://supabase.com)
- **Neon** (Fast): [neon.tech](https://neon.tech)
- **Railway**: [railway.app](https://railway.app)

Copy connection string → Add to Vercel as `DATABASE_URL`

---

## ✅ Deployment Checklist

- [ ] Code pushed to GitHub
- [ ] Database URL in Vercel
- [ ] Migrations run: `npm run db:migrate`
- [ ] Both apps deployed
- [ ] Sites working!

---

## 🆘 Troubleshooting

**Build fails?**
- Check root directory is correct
- Verify build command

**Can't connect to DB?**
- Use production DB URL (not localhost)
- Add `?sslmode=require` to connection string

**404 Error?**
- Output directory should be `.next`

---

## 📱 Your Live URLs

After deployment:
- NFL: `https://your-project.vercel.app`
- MMA: `https://your-project-mma.vercel.app`

---

**Need detailed help?** → Read `DEPLOYMENT.md`
