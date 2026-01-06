'use client';

import { Button, Card, CardHeader, CardTitle, CardContent } from '@sports-sims/shared-ui';

export default function Home() {
  return (
    <div className="min-h-screen bg-gradient-to-br from-background via-background-secondary to-background">
      {/* Header */}
      <header className="border-b border-[#DEE2E6] bg-white/80 backdrop-blur-sm sticky top-0 z-50">
        <div className="container mx-auto px-4 py-4">
          <div className="flex items-center justify-between">
            <div className="flex items-center gap-3">
              <div className="w-12 h-12 bg-nfl-blue rounded-lg flex items-center justify-center text-white font-bold text-xl">
                NFL
              </div>
              <div>
                <h1 className="text-2xl font-bold text-accent">NFL Simulation</h1>
                <p className="text-sm text-[#6C757D]">Franchise Manager</p>
              </div>
            </div>
            <Button variant="accent">Sign In</Button>
          </div>
        </div>
      </header>

      {/* Hero Section */}
      <section className="container mx-auto px-4 py-16">
        <div className="max-w-4xl mx-auto text-center space-y-6">
          <h2 className="text-5xl font-bold text-accent leading-tight">
            Build Your Dynasty.<br />
            <span className="text-nfl-blue">Manage Your Franchise.</span>
          </h2>
          <p className="text-xl text-[#495057] max-w-2xl mx-auto">
            Experience the most realistic NFL simulation. Draft players, manage your roster, 
            call the plays, and lead your team to Super Bowl glory.
          </p>
          <div className="flex gap-4 justify-center pt-4">
            <Button size="lg" variant="primary">
              Start New Franchise
            </Button>
            <Button size="lg" variant="secondary">
              Load Save
            </Button>
          </div>
        </div>
      </section>

      {/* Features Grid */}
      <section className="container mx-auto px-4 py-16">
        <div className="max-w-6xl mx-auto">
          <h3 className="text-3xl font-bold text-accent text-center mb-12">
            Deep Simulation Mechanics
          </h3>
          <div className="grid md:grid-cols-2 lg:grid-cols-3 gap-6">
            {features.map((feature, index) => (
              <Card key={index} variant="elevated" hoverable>
                <CardHeader>
                  <div className="w-12 h-12 bg-accent rounded-lg flex items-center justify-center text-white text-2xl mb-4">
                    {feature.icon}
                  </div>
                  <CardTitle>{feature.title}</CardTitle>
                </CardHeader>
                <CardContent>
                  <p className="text-[#6C757D]">{feature.description}</p>
                </CardContent>
              </Card>
            ))}
          </div>
        </div>
      </section>

      {/* Stats Section */}
      <section className="container mx-auto px-4 py-16">
        <div className="max-w-6xl mx-auto">
          <Card variant="dark" padding="lg">
            <div className="grid md:grid-cols-4 gap-8 text-center">
              {stats.map((stat, index) => (
                <div key={index}>
                  <div className="text-4xl font-bold text-white mb-2">{stat.value}</div>
                  <div className="text-[#ADB5BD]">{stat.label}</div>
                </div>
              ))}
            </div>
          </Card>
        </div>
      </section>

      {/* Footer */}
      <footer className="border-t border-[#DEE2E6] bg-white py-8 mt-16">
        <div className="container mx-auto px-4 text-center text-[#6C757D]">
          <p>© 2025 NFL Simulation. Built with precision and passion.</p>
        </div>
      </footer>
    </div>
  );
}

const features = [
  {
    icon: '🏈',
    title: 'Realistic Rosters',
    description: '1,888+ NFL players with authentic ratings, positions, and stats from the 2024-2025 season.'
  },
  {
    icon: '📊',
    title: 'Deep Analytics',
    description: 'Track 30+ player attributes and comprehensive game statistics for every position.'
  },
  {
    icon: '🎯',
    title: 'Draft System',
    description: 'Scout prospects, make trades, and build through the draft with realistic player development.'
  },
  {
    icon: '⚡',
    title: 'Game Simulation',
    description: 'Watch plays unfold with realistic outcomes based on player ratings and matchups.'
  },
  {
    icon: '🏆',
    title: 'Season Management',
    description: 'Navigate a 17-game regular season plus playoffs, managing injuries and player chemistry.'
  },
  {
    icon: '💼',
    title: 'Salary Cap',
    description: 'Make tough decisions with realistic contract negotiations and cap management.'
  }
];

const stats = [
  { value: '32', label: 'NFL Teams' },
  { value: '1,888+', label: 'Players' },
  { value: '30+', label: 'Attributes' },
  { value: '∞', label: 'Possibilities' }
];
