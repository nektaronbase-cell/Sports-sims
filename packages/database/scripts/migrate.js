import fs from 'fs';
import path from 'path';
import { Pool } from 'pg';
import { parseConnectionString, createPool, testConnection, closePool } from '../src/connection';

/**
 * Run SQL migration from file
 */
async function runMigration(pool: Pool, filePath: string): Promise<void> {
  console.log(`Running migration: ${path.basename(filePath)}`);
  
  try {
    const sql = fs.readFileSync(filePath, 'utf-8');
    await pool.query(sql);
    console.log(`✓ Migration completed: ${path.basename(filePath)}`);
  } catch (error) {
    console.error(`✗ Migration failed: ${path.basename(filePath)}`, error);
    throw error;
  }
}

/**
 * Main migration function
 */
async function migrate() {
  const connectionString = process.env.DATABASE_URL || 
    'postgresql://postgres:password@helium/heliumdb?sslmode=disable';
  
  console.log('Connecting to database...');
  const config = parseConnectionString(connectionString);
  const pool = createPool(config);
  
  // Test connection
  const connected = await testConnection(pool);
  if (!connected) {
    console.error('Failed to connect to database');
    process.exit(1);
  }
  
  // Run migrations
  const schemasDir = path.join(__dirname, '../schemas');
  const migrationFiles = [
    'nfl-schema.sql',
    'mma-schema.sql',
  ];
  
  try {
    for (const file of migrationFiles) {
      const filePath = path.join(schemasDir, file);
      if (fs.existsSync(filePath)) {
        await runMigration(pool, filePath);
      } else {
        console.warn(`⚠ Migration file not found: ${file}`);
      }
    }
    
    console.log('\n✓ All migrations completed successfully!');
  } catch (error) {
    console.error('\n✗ Migration failed:', error);
    process.exit(1);
  } finally {
    await closePool(pool);
  }
}

// Run migrations
migrate();
