const sqlite3 = require('sqlite3');
const sqlite = require('sqlite');

export default function openDb() {
  return sqlite.open({
    filename: './pariette.db',
    driver: sqlite3.Database
  })
}
