# Sports Simulations Monorepo

Two realistic sports simulation games built with Next.js, PostgreSQL, and modern web technologies.

## 🎮 Games

### NFL Simulation
Full-featured NFL franchise management with realistic rosters, deep stats, and authentic gameplay.
- **Port:** 3000
- **Features:** 32 teams, 1,888+ players, draft system, salary cap, season simulation

### MMA Simulation (OFA)
Onchain Fighting Association - Manage your MMA promotion with detailed fight mechanics.
- **Port:** 3001
- **Features:** 8 weight classes, 22 attributes, 9 fighting styles, round-by-round simulation

## 🏗️ Project Structure

```
sports-sims/
├── apps/
│   ├── nfl-sim/           # NFL Simulation Next.js app
│   └── mma-sim/           # MMA Simulation Next.js app
├── packages/
│   ├── shared-ui/         # Shared UI components (buttons, cards, etc.)
│   ├── shared-utils/      # Common utilities (math, date functions)
│   └── database/          # PostgreSQL schemas and connection utils
└── package.json           # Root workspace configuration
```

## 🎨 Design System

**Light Mode with Dark Accents**
- Background: Clean white (#FFFFFF) with subtle grays
- Accents: Deep blacks (#212529, #343A40) for contrast
- Sport Colors: NFL Blue (#013369), MMA Red (#C41E3A)
- Components: Modern, touch-friendly, responsive

## 🚀 Getting Started

### Prerequisites
- Node.js 18+
- PostgreSQL database
- npm or yarn

### Installation

1. **Clone and install dependencies**
```bash
cd sports-sims
npm install
```

2. **Set up environment variables**

Create `.env.local` in both app directories:

```bash
# apps/nfl-sim/.env.local
DATABASE_URL=postgresql://postgres:password@helium/heliumdb?sslmode=disable
```

```bash
# apps/mma-sim/.env.local
DATABASE_URL=postgresql://postgres:password@helium/heliumdb?sslmode=disable
```

3. **Run database migrations**
```bash
npm run db:migrate
```

4. **Start development servers**

Run both games:
```bash
npm run dev:all
```

Or run individually:
```bash
npm run dev:nfl  # NFL sim on port 3000
npm run dev:mma  # MMA sim on port 3001
```

## 📊 Database Schemas

### NFL Database
15 comprehensive tables including:
- Teams, Players, Coaches
- Player Attributes (30+ stats)
- Season and Game Statistics
- Draft System
- Depth Charts
- Game Schedule

### MMA Database
14 specialized tables including:
- Fighters, Weight Classes, Fighting Styles
- Fighter Attributes (22 trainable stats)
- Events, Fights, Championships
- Round-by-round Fight Data
- Rankings and Training Camps

## 🛠️ Tech Stack

- **Framework:** Next.js 14 (App Router)
- **Language:** TypeScript
- **Styling:** Tailwind CSS
- **Database:** PostgreSQL
- **State Management:** React Hooks
- **Deployment:** Vercel-ready

## 📦 Shared Packages

### @sports-sims/shared-ui
Reusable UI components with consistent theming:
- Button, Card, Input, Select, Modal
- Light mode design with dark accents
- Mobile-first responsive design

### @sports-sims/shared-utils
Common utility functions:
- Math helpers (random, weighted random, clamp)
- Date utilities (formatting, calculations)
- Game logic utilities

### @sports-sims/database
Database connection and schema management:
- PostgreSQL connection pooling
- Migration scripts
- Type-safe database utilities

## 🎯 Development Commands

```bash
# Development
npm run dev:nfl        # Start NFL sim
npm run dev:mma        # Start MMA sim
npm run dev:all        # Start both games

# Building
npm run build:nfl      # Build NFL sim
npm run build:mma      # Build MMA sim

# Database
npm run db:generate    # Generate database types
npm run db:migrate     # Run migrations

# Linting
npm run lint           # Lint all packages
```

## 🔐 Database Connection

The PostgreSQL connection string format:
```
postgresql://user:password@host:port/database?sslmode=disable
```

Example:
```
postgresql://postgres:password@helium/heliumdb?sslmode=disable
```

**Note:** `sslmode=disable` is for local development only. Use proper SSL in production.

## 📱 Mobile Development

Both games are optimized for mobile:
- Touch-friendly UI elements
- Responsive layouts
- Smooth animations
- Optimized for Termux/mobile browsers

## 🚢 Deployment

### Quick Deploy (5 minutes)

```bash
# 1. Push to GitHub
./deploy.sh

# 2. Deploy to Vercel
# Visit vercel.com/new and import your repository
# See QUICK_DEPLOY.md for step-by-step guide
```

### Automated CI/CD

GitHub Actions are configured for automatic deployments:
- Push to `main` branch → Auto-deploys to production
- Change detection for each app (only deploys what changed)
- Full build logs and error reporting

**Setup:**
1. Get Vercel token from [vercel.com/account/tokens](https://vercel.com/account/tokens)
2. Add `VERCEL_TOKEN` to GitHub repository secrets
3. Push to trigger deployment

### Documentation

- **Quick Start:** `QUICK_DEPLOY.md` - 5-minute deployment guide
- **Full Guide:** `DEPLOYMENT.md` - Comprehensive deployment instructions
- **Troubleshooting:** Check deployment logs in Vercel dashboard

Both apps are pre-configured with:
- ✅ Vercel configuration files (`vercel.json`)
- ✅ GitHub Actions workflows (`.github/workflows/`)
- ✅ Build optimization settings
- ✅ Environment variable templates

## 🤝 Contributing

This is a personal project, but suggestions are welcome!

## 📄 License

Private project - All rights reserved

## 🎮 Features Roadmap

### NFL Simulation
- [ ] Full season simulation
- [ ] Draft system with scouting
- [ ] Free agency and trades
- [ ] Injury system
- [ ] Coaching staff management
- [ ] Playbook customization

### MMA Simulation
- [ ] Complete fight engine
- [ ] Fighter creation system
- [ ] Event card builder
- [ ] Training camp mechanics
- [ ] Contract negotiations
- [ ] Promotion reputation system

---

Built with ❤️ for sports simulation enthusiasts
