const sqlite3 = require('sqlite3');
const sqlite = require('sqlite');

async function openDb() {
  return sqlite.open({
    filename: './pariette.db',
    driver: sqlite3.Database
  })
}

async function setup() {
  const db = await openDb();
  await db.migrate({
    migrationsPath: './database',
    force: 'last'
  })

  const canvas = await db.all('SELECT * FROM canvas')
  console.log('canvas', JSON.stringify(canvas, null, 2))
}

setup()