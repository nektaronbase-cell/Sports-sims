/**
 * Format a date as a readable string
 */
export function formatDate(date: Date): string {
  return date.toLocaleDateString('en-US', {
    year: 'numeric',
    month: 'long',
    day: 'numeric',
  });
}

/**
 * Format a date as short date string (MM/DD/YYYY)
 */
export function formatShortDate(date: Date): string {
  return date.toLocaleDateString('en-US');
}

/**
 * Get current season year (e.g., 2024-2025 NFL season)
 */
export function getCurrentSeasonYear(): number {
  const now = new Date();
  const year = now.getFullYear();
  const month = now.getMonth(); // 0-11
  
  // If we're in Jan-June, use previous year as season start
  return month < 6 ? year - 1 : year;
}

/**
 * Calculate age from birth date
 */
export function calculateAge(birthDate: Date): number {
  const today = new Date();
  let age = today.getFullYear() - birthDate.getFullYear();
  const monthDiff = today.getMonth() - birthDate.getMonth();
  
  if (monthDiff < 0 || (monthDiff === 0 && today.getDate() < birthDate.getDate())) {
    age--;
  }
  
  return age;
}

/**
 * Add days to a date
 */
export function addDays(date: Date, days: number): Date {
  const result = new Date(date);
  result.setDate(result.getDate() + days);
  return result;
}

/**
 * Add weeks to a date
 */
export function addWeeks(date: Date, weeks: number): Date {
  return addDays(date, weeks * 7);
}

/**
 * Check if date is in the future
 */
export function isFuture(date: Date): boolean {
  return date > new Date();
}

/**
 * Check if date is in the past
 */
export function isPast(date: Date): boolean {
  return date < new Date();
}

/**
 * Get days between two dates
 */
export function daysBetween(date1: Date, date2: Date): number {
  const diffTime = Math.abs(date2.getTime() - date1.getTime());
  return Math.ceil(diffTime / (1000 * 60 * 60 * 24));
}

/**
 * Format duration in minutes to readable string
 */
export function formatDuration(minutes: number): string {
  const hours = Math.floor(minutes / 60);
  const mins = minutes % 60;
  
  if (hours === 0) return `${mins}m`;
  if (mins === 0) return `${hours}h`;
  return `${hours}h ${mins}m`;
}
