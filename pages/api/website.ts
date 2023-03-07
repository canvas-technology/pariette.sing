import { NextApiRequest, NextApiResponse } from 'next'
import openDb from '../../helpers/sqlite';
import errors from '../../helpers/errors';
import moment from 'moment'

export default async function getContents(req: NextApiRequest, res: NextApiResponse){
  const db = await openDb()
  const table = 'website'
  const siteToken = 'c49n7v1s'
  switch (req.method) {

    case 'GET':
      const rows = await db.get(`SELECT * FROM ${table} WHERE token = ? AND publish = ? AND status = ?`, [
        siteToken,
        1,
        1
      ])
      if (rows) {
        res.json(rows)
      } else {
        // buraya status ve publish durumuna göre mesaj bas. kalabalık olması önemli değil. önce site token çağır, sonra publish 1 mi, status 1 mi şeklinde sorgulat.
        res.json({
          title: 'Bir süreliğine kapalıyız. Pariette',
          description: 'site bakıma alındığı için kısa bir süre kapalı olacak.'
        })
      }
      break;

    case 'PUT':
      const updatedAt = req.body.updated_at ? req.body.updated_at : moment().format('MM-DD-YYYY HH:mm:ss')

      const row = await db.prepare("UPDATE website SET url = ?, title = ?, description = ?, meta_title = ?, meta_description = ?, meta_keywords = ?, meta_sitemap = ?, lang = ?, locales = ?, logo_web = ?, logo_mobile = ?, logo_dark_web = ?, logo_dark_mobile = ?, logo_favicon = ?, mail_driver = ?, mail_host = ?, mail_port = ?, mail_sender = ?, mail_account = ?, mail_password = ?, mail_encryption = ?, cdn_url = ?, status = ?, publish = ?, updated_at = ? where token = ?")
      try {
        const put = await row.run(req.body.url, req.body.title, req.body.description, req.body.meta_title, req.body.meta_description, req.body.meta_keywords, req.body.meta_sitemap, req.body.lang, req.body.locales, req.body.logo_web, req.body.logo_mobile, req.body.logo_dark_web, req.body.logo_dark_mobile, req.body.logo_favicon, req.body.mail_driver, req.body.mail_host, req.body.mail_port, req.body.mail_sender, req.body.mail_account, req.body.mail_password, req.body.mail_encryption, req.body.cdn_url, req.body.status, req.body.publish, updatedAt, siteToken)

        res.status(200).json(put)
      } catch (err) {
        res.json(err)
      }

      break;
    default:
      res.status(400).json({message: errors()})
      break;
  }
}
