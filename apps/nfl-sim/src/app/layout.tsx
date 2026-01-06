import type { Metadata } from 'next';
import './globals.css';

export const metadata: Metadata = {
  title: 'NFL Simulation',
  description: 'Manage your NFL franchise with deep simulation mechanics',
};

export default function RootLayout({
  children,
}: Readonly<{
  children: React.ReactNode;
}>) {
  return (
    <html lang="en">
      <body className="min-h-screen bg-background antialiased">
        {children}
      </body>
    </html>
  );
}
