import React from 'react';
import { clsx } from 'clsx';

export interface InputProps extends React.InputHTMLAttributes<HTMLInputElement> {
  label?: string;
  error?: string;
  helperText?: string;
  leftIcon?: React.ReactNode;
  rightIcon?: React.ReactNode;
}

export const Input = React.forwardRef<HTMLInputElement, InputProps>(
  ({ 
    label,
    error,
    helperText,
    leftIcon,
    rightIcon,
    className,
    ...props
  }, ref) => {
    const inputStyles = clsx(
      'w-full px-4 py-2 text-base text-[#212529] bg-white border rounded-lg transition-all duration-200',
      'placeholder:text-[#6C757D] focus:outline-none focus:ring-2 focus:ring-offset-1',
      error 
        ? 'border-[#DC3545] focus:border-[#DC3545] focus:ring-[#DC3545]'
        : 'border-[#CED4DA] focus:border-[#343A40] focus:ring-[#343A40] hover:border-[#ADB5BD]',
      leftIcon && 'pl-10',
      rightIcon && 'pr-10',
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
        
        <div className="relative">
          {leftIcon && (
            <div className="absolute inset-y-0 left-0 pl-3 flex items-center pointer-events-none text-[#6C757D]">
              {leftIcon}
            </div>
          )}
          
          <input
            ref={ref}
            className={inputStyles}
            {...props}
          />
          
          {rightIcon && (
            <div className="absolute inset-y-0 right-0 pr-3 flex items-center pointer-events-none text-[#6C757D]">
              {rightIcon}
            </div>
          )}
        </div>
        
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

Input.displayName = 'Input';

// Textarea component
export interface TextareaProps extends React.TextareaHTMLAttributes<HTMLTextAreaElement> {
  label?: string;
  error?: string;
  helperText?: string;
}

export const Textarea = React.forwardRef<HTMLTextAreaElement, TextareaProps>(
  ({ 
    label,
    error,
    helperText,
    className,
    ...props
  }, ref) => {
    const textareaStyles = clsx(
      'w-full px-4 py-2 text-base text-[#212529] bg-white border rounded-lg transition-all duration-200 resize-none',
      'placeholder:text-[#6C757D] focus:outline-none focus:ring-2 focus:ring-offset-1',
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
        
        <textarea
          ref={ref}
          className={textareaStyles}
          {...props}
        />
        
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

Textarea.displayName = 'Textarea';
