import { NextApiRequest, NextApiResponse } from 'next'
import openDb from '../../helpers/sqlite';
import errors from '../../helpers/errors';
import moment from 'moment'

export default async function getContents(req: NextApiRequest, res: NextApiResponse){
  const db = await openDb()

  switch (req.method) {

    case 'GET':

      let query = 'SELECT * FROM canvas'
      // dikkat, querynin başında bir karakter boşluk bırak!
      if (req.query.search) {
        query += ` WHERE title LIKE '%${req.query.search}%' OR content LIKE '%${req.query.search}%'`
      }
      if (req.query.type) {
        query += ` WHERE type LIKE '%${req.query.type}%'`
      }
      if (req.query.title) {
        query += ` WHERE title LIKE '%${req.query.title}%'`
      }
      if (req.query.slug) {
        query += ` WHERE slug LIKE '%${req.query.slug}%'`
      }
      if (req.query.position) {
        query += ` WHERE position LIKE '%${req.query.position}%'`
      }
      if (req.query.order) {
        query += ` ORDER BY ${req.query.orderBy} ${req.query.order}`
      }
      if (req.query.limit) {
        query += ` LIMIT ${req.query.limit}`
      }

      const rows = await db.all(query)
      res.json(rows)

      break;

    case 'POST':
      const createdAt = req.body.created_at ? req.body.created_at : moment().format('MM-DD-YYYY HH:mm:ss')
      const updatedAt = req.body.updated_at ? req.body.updated_at : moment().format('MM-DD-YYYY HH:mm:ss')

      const row = await db.prepare("INSERT INTO canvas (type, title, slug, position, created_at, updated_at) values (?, ?, ?, ?, ?, ?)")
      try {
        const post = await row.run(req.body.type, req.body.title, req.body.slug, req.body.position, createdAt, updatedAt)
        res.status(200).json(post)
      } catch (err) {
        res.json(err)
      }

      break;
    default:
      res.status(400).json({message: errors()})
      break;
  }
}
