// Light mode with dark accents theme
export const theme = {
  colors: {
    // Background colors (light base)
    background: {
      primary: '#FFFFFF',
      secondary: '#F8F9FA',
      tertiary: '#F1F3F5',
      hover: '#E9ECEF',
    },
    
    // Dark accents
    accent: {
      primary: '#212529',
      secondary: '#343A40',
      tertiary: '#495057',
      hover: '#2C3136',
    },
    
    // Text colors
    text: {
      primary: '#212529',
      secondary: '#495057',
      tertiary: '#6C757D',
      inverse: '#FFFFFF',
    },
    
    // Brand colors for sports
    brand: {
      nfl: '#013369', // NFL blue
      mma: '#C41E3A', // UFC/MMA red
      success: '#28A745',
      warning: '#FFC107',
      error: '#DC3545',
      info: '#17A2B8',
    },
    
    // Border colors
    border: {
      light: '#DEE2E6',
      medium: '#CED4DA',
      dark: '#ADB5BD',
    },
  },
  
  // Shadows for depth
  shadows: {
    sm: '0 1px 2px 0 rgba(0, 0, 0, 0.05)',
    md: '0 4px 6px -1px rgba(0, 0, 0, 0.1), 0 2px 4px -1px rgba(0, 0, 0, 0.06)',
    lg: '0 10px 15px -3px rgba(0, 0, 0, 0.1), 0 4px 6px -2px rgba(0, 0, 0, 0.05)',
    xl: '0 20px 25px -5px rgba(0, 0, 0, 0.1), 0 10px 10px -5px rgba(0, 0, 0, 0.04)',
  },
  
  // Border radius for modern feel
  radius: {
    sm: '0.25rem',
    md: '0.5rem',
    lg: '0.75rem',
    xl: '1rem',
    full: '9999px',
  },
  
  // Spacing scale
  spacing: {
    xs: '0.25rem',
    sm: '0.5rem',
    md: '1rem',
    lg: '1.5rem',
    xl: '2rem',
    '2xl': '3rem',
  },
  
  // Typography
  fontSize: {
    xs: '0.75rem',
    sm: '0.875rem',
    base: '1rem',
    lg: '1.125rem',
    xl: '1.25rem',
    '2xl': '1.5rem',
    '3xl': '1.875rem',
    '4xl': '2.25rem',
  },
  
  // Transitions
  transition: {
    fast: '150ms ease-in-out',
    base: '200ms ease-in-out',
    slow: '300ms ease-in-out',
  },
} as const;

export type Theme = typeof theme;
