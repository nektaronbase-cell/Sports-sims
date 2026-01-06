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
              <div className="w-12 h-12 bg-mma-red rounded-lg flex items-center justify-center text-white font-bold text-xl">
                OFA
              </div>
              <div>
                <h1 className="text-2xl font-bold text-accent">Onchain Fighting Association</h1>
                <p className="text-sm text-[#6C757D]">MMA Promotion Manager</p>
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
            Build Your Promotion.<br />
            <span className="text-mma-red">Crown Your Champions.</span>
          </h2>
          <p className="text-xl text-[#495057] max-w-2xl mx-auto">
            Experience the most realistic MMA simulation. Sign fighters, build event cards, 
            and watch detailed round-by-round action unfold in the octagon.
          </p>
          <div className="flex gap-4 justify-center pt-4">
            <Button size="lg" variant="primary">
              Start New Promotion
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
            Authentic Fight Simulation
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

      {/* Weight Classes Section */}
      <section className="container mx-auto px-4 py-16">
        <div className="max-w-6xl mx-auto">
          <h3 className="text-3xl font-bold text-accent text-center mb-12">
            Eight Weight Divisions
          </h3>
          <Card variant="bordered" padding="lg">
            <div className="grid grid-cols-2 md:grid-cols-4 gap-6">
              {weightClasses.map((wc, index) => (
                <div key={index} className="text-center">
                  <div className="text-2xl font-bold text-accent mb-1">{wc.name}</div>
                  <div className="text-sm text-[#6C757D]">{wc.limit}</div>
                  <div className="w-full h-1 bg-mma-red rounded-full mt-2"></div>
                </div>
              ))}
            </div>
          </Card>
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
          <p>© 2025 Onchain Fighting Association. Built with precision and passion.</p>
        </div>
      </footer>
    </div>
  );
}

const features = [
  {
    icon: '🥊',
    title: '22 Fighter Attributes',
    description: 'Deep character progression with striking, grappling, physical and mental attributes.'
  },
  {
    icon: '🎯',
    title: '9 Fighting Styles',
    description: 'From strikers to grapplers, each style brings unique strengths and strategies.'
  },
  {
    icon: '⚔️',
    title: 'Realistic Fights',
    description: 'Round-by-round simulation with knockdowns, submissions, and judges decisions.'
  },
  {
    icon: '🏆',
    title: 'Championships',
    description: 'Build championship lineages across 8 weight classes with rankings and title defenses.'
  },
  {
    icon: '📅',
    title: 'Event Planning',
    description: 'Create stacked fight cards, manage fighter availability, and maximize revenue.'
  },
  {
    icon: '💪',
    title: 'Training Camps',
    description: 'Develop your fighters between bouts with focused training regimens.'
  }
];

const weightClasses = [
  { name: 'Flyweight', limit: '125 lbs' },
  { name: 'Bantamweight', limit: '135 lbs' },
  { name: 'Featherweight', limit: '145 lbs' },
  { name: 'Lightweight', limit: '155 lbs' },
  { name: 'Welterweight', limit: '170 lbs' },
  { name: 'Middleweight', limit: '185 lbs' },
  { name: 'Light Heavyweight', limit: '205 lbs' },
  { name: 'Heavyweight', limit: '265 lbs' },
];

const stats = [
  { value: '8', label: 'Weight Classes' },
  { value: '22', label: 'Attributes' },
  { value: '9', label: 'Fighting Styles' },
  { value: '∞', label: 'Possibilities' }
];
