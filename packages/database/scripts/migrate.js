const fs = require('fs');
const path = require('path');
const { Pool } = require('pg');

function parseConnectionString(connectionString) {
  const url = new URL(connectionString);
  return {
    host: url.hostname,
    port: parseInt(url.port) || 5432,
    database: url.pathname.slice(1),
    user: url.username,
    password: url.password,
    ssl: url.searchParams.get('sslmode') !== 'disable'
  };
}

function createPool(config) {
  return new Pool({
    ...config,
    ssl: config.ssl ? { rejectUnauthorized: false } : false,
    max: 20,
    idleTimeoutMillis: 30000,
    connectionTimeoutMillis: 2000,
  });
}

async function testConnection(pool) {
  try {
    const result = await pool.query('SELECT NOW()');
    console.log('Database connected:', result.rows[0].now);
    return true;
  } catch (error) {
    console.error('Database connection failed:', error);
    return false;
  }
}

async function runMigration(pool, filePath) {
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

async function migrate() {
  const connectionString = process.env.DATABASE_URL || 
    'postgresql://postgres:password@helium/heliumdb?sslmode=disable';
  
  console.log('Connecting to database...');
  const config = parseConnectionString(connectionString);
  const pool = createPool(config);
  
  const connected = await testConnection(pool);
  if (!connected) {
    console.error('Failed to connect to database');
    process.exit(1);
  }
  
  const schemasDir = path.join(__dirname, '../schemas');
  const migrationFiles = ['nfl-schema.sql', 'mma-schema.sql'];
  
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
    await pool.end();
  }
}

migrate();
