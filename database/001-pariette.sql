-- Up
CREATE TABLE IF NOT EXISTS website (
  id INTEGER PRIMARY KEY AUTOINCREMENT UNIQUE,
  url TEXT,
  title TEXT,
  meta_title TEXT,
  meta_description TEXT,
  meta_keywords TEXT,
  meta_revisit_after TEXT,
  meta_sitemap TEXT,
  lang TEXT,
  locales TEXT,
  logo_web TEXT,
  logo_mobile TEXT,
  logo_dark_web TEXT,
  logo_dark_mobile TEXT,
  logo_favicon TEXT,
  mail_driver TEXT,
  mail_host TEXT,
  mail_port TEXT,
  mail_sender TEXT,
  mail_account TEXT,
  mail_password TEXT,
  mail_encryption TEXT,
  email_address TEXT,
  email_title TEXT,
  cdn_url TEXT,
  status INTEGER NOT NULL DEFAULT 1,
  created_at DATE DEFAULT (datetime('now', 'localtime')),
  updated_at DATE DEFAULT (datetime('now', 'localtime'))
);

CREATE TABLE IF NOT EXISTS users (
  id INTEGER PRIMARY KEY AUTOINCREMENT UNIQUE,
  name TEXT,
  surname TEXT,
  email TEXT,
  password TEXT,
  login_method TEXT,
  phone TEXT,
  avatar TEXT,
  ip TEXT,
  old_ip TEXT,
  status INTEGER NOT NULL DEFAULT 1,
  created_at DATE DEFAULT (datetime('now', 'localtime')),
  updated_at DATE DEFAULT (datetime('now', 'localtime'))
);

CREATE TABLE IF NOT EXISTS ticket (
  id INTEGER PRIMARY KEY AUTOINCREMENT UNIQUE,
  type TEXT,
  user TEXT,
  title TEXT,
  slug TEXT,
  content TEXT,
  status INTEGER NOT NULL DEFAULT 1,
  created_at DATE DEFAULT (datetime('now', 'localtime')),
  updated_at DATE DEFAULT (datetime('now', 'localtime'))
);

CREATE TABLE IF NOT EXISTS ticket_post (
  id INTEGER PRIMARY KEY AUTOINCREMENT UNIQUE,
  ticket_id INTEGER,
  user_id INTEGER,
  content TEXT,
  status INTEGER NOT NULL DEFAULT 1,
  created_at DATE DEFAULT (datetime('now', 'localtime')),
  updated_at DATE DEFAULT (datetime('now', 'localtime')),
  FOREIGN KEY (user_id) REFERENCES users (id) ON DELETE CASCADE ON UPDATE NO ACTION,
  FOREIGN KEY (ticket_id) REFERENCES ticket (id) ON DELETE CASCADE ON UPDATE NO ACTION,
);

CREATE TABLE IF NOT EXISTS canvas (
  id INTEGER PRIMARY KEY AUTOINCREMENT UNIQUE,
  user_id INTEGER,
  type TEXT,
  title TEXT,
  slug TEXT,
  status INTEGER NOT NULL DEFAULT 1,
  created_at DATE DEFAULT (datetime('now', 'localtime')),
  updated_at DATE DEFAULT (datetime('now', 'localtime')),
  FOREIGN KEY (user_id) REFERENCES users (id) ON DELETE CASCADE ON UPDATE NO ACTION,
);

CREATE TABLE IF NOT EXISTS content (
  id INTEGER PRIMARY KEY AUTOINCREMENT,
  canvas_id INTEGER,
  user_id INTEGER,
  lang TEXT,
  type TEXT,
  title TEXT,
  description TEXT,
  content TEXT,
  keywords TEXT,
  image_web TEXT,
  image_mobile TEXT,
  meta_title TEXT,
  meta_description TEXT,
  status INTEGER NOT NULL DEFAULT 1,
  created_at DATE DEFAULT (datetime('now', 'localtime')),
  updated_at DATE DEFAULT (datetime('now', 'localtime')),
  FOREIGN KEY (user_id) REFERENCES users (id) ON DELETE CASCADE ON UPDATE NO ACTION,
  FOREIGN KEY (canvas_id) REFERENCES canvas (id) ON DELETE CASCADE ON UPDATE NO ACTION,
);

CREATE TABLE IF NOT EXISTS blog (
  id INTEGER PRIMARY KEY AUTOINCREMENT UNIQUE,
  user_id INTEGER,
  type TEXT,
  title TEXT,
  slug TEXT,
  status INTEGER NOT NULL DEFAULT 1,
  created_at DATE DEFAULT (datetime('now', 'localtime')),
  updated_at DATE DEFAULT (datetime('now', 'localtime')),
  FOREIGN KEY (user_id) REFERENCES users (id) ON DELETE CASCADE ON UPDATE NO ACTION,
);

CREATE TABLE IF NOT EXISTS blog_post (
  id INTEGER PRIMARY KEY AUTOINCREMENT,
  blog_id INTEGER,
  user_id INTEGER,
  lang TEXT,
  type TEXT,
  title TEXT,
  description TEXT,
  content TEXT,
  keywords TEXT,
  image_web TEXT,
  image_mobile TEXT,
  meta_title TEXT,
  meta_description TEXT,
  status INTEGER NOT NULL DEFAULT 1,
  created_at DATE DEFAULT (datetime('now', 'localtime')),
  updated_at DATE DEFAULT (datetime('now', 'localtime')),
  FOREIGN KEY (user_id) REFERENCES users (id) ON DELETE CASCADE ON UPDATE NO ACTION,
  FOREIGN KEY (blog_id) REFERENCES blog (id) ON DELETE CASCADE ON UPDATE NO ACTION,
);

CREATE TABLE IF NOT EXISTS lookup (
  id INTEGER PRIMARY KEY AUTOINCREMENT,
  type TEXT,
  main INTEGER,
  title TEXT,
  slug TEXT,
  status INTEGER NOT NULL DEFAULT 1,
  created_at DATE DEFAULT (datetime('now', 'localtime')),
  updated_at DATE DEFAULT (datetime('now', 'localtime')),
);

CREATE TABLE IF NOT EXISTS lookup_item (
  id INTEGER PRIMARY KEY AUTOINCREMENT,
  lookup_id INTEGER,
  item_id INTEGER,
  type TEXT,
  label TEXT,
  value TEXT,
  image TEXT,
  line INTEGER,
  status INTEGER NOT NULL DEFAULT 1,
  created_at DATE DEFAULT (datetime('now', 'localtime')),
  updated_at DATE DEFAULT (datetime('now', 'localtime')),
  FOREIGN KEY (lookup_id) REFERENCES lookup (id) ON DELETE CASCADE ON UPDATE NO ACTION,
  FOREIGN KEY (item_id) REFERENCES lookup_item (id) ON DELETE CASCADE ON UPDATE NO ACTION,
);

CREATE TABLE IF NOT EXISTS carousel (
  id INTEGER PRIMARY KEY AUTOINCREMENT UNIQUE,
  type TEXT,
  title TEXT,
  slug TEXT,
  status INTEGER NOT NULL DEFAULT 1,
  created_at DATE DEFAULT (datetime('now', 'localtime')),
  updated_at DATE DEFAULT (datetime('now', 'localtime')),
  FOREIGN KEY (user_id) REFERENCES users (id) ON DELETE CASCADE ON UPDATE NO ACTION,
);

CREATE TABLE IF NOT EXISTS attachment (
  id INTEGER PRIMARY KEY AUTOINCREMENT,
  title TEXT,
  alt TEXT,
  image TEXT,
  cdn_url TEXT,
  file_format TEXT,
  file_size TEXT,
  file_name TEXT,
  status INTEGER NOT NULL DEFAULT 1,
  created_at DATE DEFAULT (datetime('now', 'localtime')),
  updated_at DATE DEFAULT (datetime('now', 'localtime')),
);

CREATE TABLE IF NOT EXISTS navigation (
  id INTEGER PRIMARY KEY AUTOINCREMENT UNIQUE,
  type TEXT,
  title TEXT,
  slug TEXT,
  status INTEGER NOT NULL DEFAULT 1,
  created_at DATE DEFAULT (datetime('now', 'localtime')),
  updated_at DATE DEFAULT (datetime('now', 'localtime')),
);

CREATE TABLE IF NOT EXISTS navigation_item (
  id INTEGER PRIMARY KEY AUTOINCREMENT,
  navigation_id INTEGER,
  item_id INTEGER,
  lang TEXT,
  title TEXT,
  alt TEXT,
  icon TEXT,
  route TEXT,
  url TEXT,
  link TEXT,
  line TEXT,
  params TEXT,
  target TEXT,
  image TEXT,
  collapse TEXT,
  position TEXT,
  icon_only INTEGER,
  status INTEGER NOT NULL DEFAULT 1,
  created_at DATE DEFAULT (datetime('now', 'localtime')),
  updated_at DATE DEFAULT (datetime('now', 'localtime')),
  FOREIGN KEY (navigation_id) REFERENCES navigation (id) ON DELETE CASCADE ON UPDATE NO ACTION,
  FOREIGN KEY (item_id) REFERENCES navigation_item (id) ON DELETE CASCADE ON UPDATE NO ACTION,
);

INSERT INTO website (id, url, title, meta_title, meta_description, meta_keywords, meta_revisit_after, meta_sitemap, lang, locales, logo_web, logo_mobile, logo_dark_web, logo_dark_mobile, logo_favicon, mail_driver, mail_host, mail_port, mail_sender, mail_account, mail_password, mail_encryption, email_address, email_title, cdn_url, status, created_at, updated_at) values (1, 'https://pariette.com/', 'Pariette.com', 'Pariette.com', 'Pariette is most cute headless cms on the world', 'headless cms, pariette', '7 days', 'sitemap.xml', 'en-US', '["en-US", "tr-TR"]', 'pariette-web.png' 'pariette-mobile.png' 'pariette-dark-web.png' 'pariette-dark-mobile.png' 'favicon.ico', '', '', '', '', '', '', '', '', '', '', '', 1, '2023-03-03 23:13:33', '2023-03-03 23:13:43');

INSERT INTO users (!) values ();
INSERT INTO canvas (!) values ();
INSERT INTO content (!) values ();
INSERT INTO blog () values ();
INSERT INTO blog_post () values ();
INSERT INTO lookup (!) values ();
INSERT INTO lookup_item (!) values ();
INSERT INTO carousel () values ();
INSERT INTO attachment () values ();
INSERT INTO navigation (!) values ();
INSERT INTO navigation_item (!) values ();

-- Down
DROP TABLE website;
DROP TABLE users;
DROP TABLE ticket;
DROP TABLE ticket_post;
DROP TABLE canvas;
DROP TABLE content;
DROP TABLE blog;
DROP TABLE blog_post;
DROP TABLE lookup;
DROP TABLE lookup_item;
DROP TABLE carousel;
DROP TABLE attachment;
DROP TABLE navigation;
DROP TABLE navigation_item;