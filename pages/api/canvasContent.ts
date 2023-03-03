import { NextApiRequest, NextApiResponse } from 'next'
import openDb from '../../helpers/sqlite';
import errors from '../../helpers/errors';
import moment from 'moment'

export default async function getContents(req: NextApiRequest, res: NextApiResponse){
  const db = await openDb()

  switch (req.method) {

    case 'GET':

      let query = 'SELECT * FROM canvas_content'
      // dikkat, querynin başında bir karakter boşluk bırak!
      if (req.query.canvas) {
        query += ` WHERE canvas_id = ${req.query.canvas_id}`
      }
      if (req.query.content) {
        query += ` WHERE content_id = ${req.query.content_id}`
      }
      if (req.query.order) {
        query += ` ORDER BY ${req.query.orderBy} ${req.query.order}`
      } else {
        query += ' ORDER BY line ASC'
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
      const status = req.body.status ? req.body.status : 1

      const row = await db.prepare("INSERT INTO canvas_content (canvas_id, content_id, line, status, created_at, updated_at) values (?, ?, ?, ?, ?, ?)")
      try {
        const post = await row.run(req.body.canvas_id, req.body.content_id, req.body.line, status, createdAt, updatedAt)
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
