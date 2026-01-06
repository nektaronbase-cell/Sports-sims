import React from 'react';
import { clsx } from 'clsx';

export interface SelectOption {
  value: string;
  label: string;
  disabled?: boolean;
}

export interface SelectProps extends Omit<React.SelectHTMLAttributes<HTMLSelectElement>, 'value' | 'onChange'> {
  label?: string;
  error?: string;
  helperText?: string;
  options: SelectOption[];
  value?: string;
  onChange?: (value: string) => void;
  placeholder?: string;
}

export const Select = React.forwardRef<HTMLSelectElement, SelectProps>(
  ({ 
    label,
    error,
    helperText,
    options,
    value,
    onChange,
    placeholder,
    className,
    ...props
  }, ref) => {
    const selectStyles = clsx(
      'w-full px-4 py-2 text-base text-[#212529] bg-white border rounded-lg transition-all duration-200 cursor-pointer',
      'focus:outline-none focus:ring-2 focus:ring-offset-1',
      error 
        ? 'border-[#DC3545] focus:border-[#DC3545] focus:ring-[#DC3545]'
        : 'border-[#CED4DA] focus:border-[#343A40] focus:ring-[#343A40] hover:border-[#ADB5BD]',
      props.disabled && 'bg-[#F1F3F5] cursor-not-allowed opacity-60',
      className
    );
    
    return (
      <div className="w-full">
        {label && (
          <label className="block text-sm font-medium text-[#212529] mb-1">
            {label}
          </label>
        )}
        
        <select
          ref={ref}
          className={selectStyles}
          value={value}
          onChange={(e) => onChange?.(e.target.value)}
          {...props}
        >
          {placeholder && (
            <option value="" disabled>
              {placeholder}
            </option>
          )}
          {options.map((option) => (
            <option 
              key={option.value} 
              value={option.value}
              disabled={option.disabled}
            >
              {option.label}
            </option>
          ))}
        </select>
        
        {error && (
          <p className="mt-1 text-sm text-[#DC3545]">
            {error}
          </p>
        )}
        
        {helperText && !error && (
          <p className="mt-1 text-sm text-[#6C757D]">
            {helperText}
          </p>
        )}
      </div>
    );
  }
);

Select.displayName = 'Select';
