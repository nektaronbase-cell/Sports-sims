import { Pool, PoolConfig } from 'pg';

/**
 * Database connection configuration
 */
export interface DatabaseConfig {
  host: string;
  port: number;
  database: string;
  user: string;
  password: string;
  ssl?: boolean;
}

/**
 * Parse PostgreSQL connection string
 */
export function parseConnectionString(connectionString: string): DatabaseConfig {
  // Format: postgresql://user:password@host:port/database?options
  const url = new URL(connectionString);
  
  const config: DatabaseConfig = {
    host: url.hostname,
    port: parseInt(url.port) || 5432,
    database: url.pathname.slice(1), // Remove leading slash
    user: url.username,
    password: url.password,
  };
  
  // Check for SSL mode
  const sslMode = url.searchParams.get('sslmode');
  config.ssl = sslMode !== 'disable';
  
  return config;
}

/**
 * Create a database connection pool
 */
export function createPool(config: DatabaseConfig): Pool {
  const poolConfig: PoolConfig = {
    host: config.host,
    port: config.port,
    database: config.database,
    user: config.user,
    password: config.password,
    ssl: config.ssl ? { rejectUnauthorized: false } : false,
    max: 20, // Maximum pool size
    idleTimeoutMillis: 30000,
    connectionTimeoutMillis: 2000,
  };
  
  return new Pool(poolConfig);
}

/**
 * Test database connection
 */
export async function testConnection(pool: Pool): Promise<boolean> {
  try {
    const result = await pool.query('SELECT NOW()');
    console.log('Database connected:', result.rows[0].now);
    return true;
  } catch (error) {
    console.error('Database connection failed:', error);
    return false;
  }
}

/**
 * Close database pool
 */
export async function closePool(pool: Pool): Promise<void> {
  await pool.end();
}
