import { NextApiRequest, NextApiResponse } from 'next'
import openDb from '../../../helpers/sqlite';
import errors from '../../../helpers/errors';

export default async function getContents(req: NextApiRequest, res: NextApiResponse){
  const db = await openDb()

  switch (req.method) {
    case 'GET':
      const canvas = await db.get('SELECT * FROM canvas where slug = ?', [
        req.query.slug
      ])

      if (!canvas) {
        res.status(404).json({message: errors(404)})
      }

      if (req.query.withContent) {
        const rels = await db.all('SELECT * FROM canvas_content WHERE status = ? and canvas_id = ? ORDER BY line ASC', [
          req.query.status ?? 1,
          canvas.id
        ])
        const rows: any[] = [];
        for (let c = 0; c < rels.length; c++) {
          const el = rels[c]
          const content = await db.get('SELECT * FROM content where id = ?', [
            el.id
          ])
          rows.push(content)
        }
        canvas.contents = rows
      }
      res.json(canvas)
      break;

    case 'PUT':

      const row = await db.prepare("UPDATE canvas SET type = ?, title = ?, position = ?, updated_at = ? where slug = ?")
      try {
        const put = await row.run(req.body.type, req.body.title, req.body.position, req.body.updated_at, req.query.slug)

        res.status(200).json(put)
      } catch (err) {
        res.json(err)
      }

      break;
    default:
      res.status(400).json({message: errors(400)})
      break;
  }
}
