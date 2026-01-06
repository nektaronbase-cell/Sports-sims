import React from 'react';
import { clsx } from 'clsx';

export interface CardProps extends React.HTMLAttributes<HTMLDivElement> {
  variant?: 'default' | 'elevated' | 'bordered' | 'dark';
  padding?: 'none' | 'sm' | 'md' | 'lg';
  hoverable?: boolean;
}

export const Card = React.forwardRef<HTMLDivElement, CardProps>(
  ({ 
    variant = 'default',
    padding = 'md',
    hoverable = false,
    className,
    children,
    ...props
  }, ref) => {
    const baseStyles = 'rounded-lg transition-all duration-200';
    
    const variants = {
      default: 'bg-white border border-[#DEE2E6]',
      elevated: 'bg-white shadow-md',
      bordered: 'bg-white border-2 border-[#343A40]',
      dark: 'bg-[#212529] border border-[#343A40] text-white',
    };
    
    const paddings = {
      none: '',
      sm: 'p-3',
      md: 'p-4',
      lg: 'p-6',
    };
    
    const hoverStyles = hoverable 
      ? 'hover:shadow-lg hover:scale-[1.02] cursor-pointer' 
      : '';
    
    return (
      <div
        ref={ref}
        className={clsx(
          baseStyles,
          variants[variant],
          paddings[padding],
          hoverStyles,
          className
        )}
        {...props}
      >
        {children}
      </div>
    );
  }
);

Card.displayName = 'Card';

// Card subcomponents for better composition
export const CardHeader: React.FC<React.HTMLAttributes<HTMLDivElement>> = ({ 
  className, 
  children, 
  ...props 
}) => (
  <div className={clsx('mb-4', className)} {...props}>
    {children}
  </div>
);

export const CardTitle: React.FC<React.HTMLAttributes<HTMLHeadingElement>> = ({ 
  className, 
  children, 
  ...props 
}) => (
  <h3 className={clsx('text-xl font-bold text-[#212529]', className)} {...props}>
    {children}
  </h3>
);

export const CardContent: React.FC<React.HTMLAttributes<HTMLDivElement>> = ({ 
  className, 
  children, 
  ...props 
}) => (
  <div className={clsx('text-[#495057]', className)} {...props}>
    {children}
  </div>
);

export const CardFooter: React.FC<React.HTMLAttributes<HTMLDivElement>> = ({ 
  className, 
  children, 
  ...props 
}) => (
  <div className={clsx('mt-4 pt-4 border-t border-[#DEE2E6]', className)} {...props}>
    {children}
  </div>
);
