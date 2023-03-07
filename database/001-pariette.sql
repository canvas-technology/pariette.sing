-- Up
CREATE TABLE IF NOT EXISTS website (
  id INTEGER PRIMARY KEY AUTOINCREMENT UNIQUE,
  token VARCHAR(8),
  url VARCHAR(64),
  title VARCHAR(64),
  description VARCHAR(128),
  meta_title TEXT,
  meta_description TEXT,
  meta_keywords TEXT,
  meta_sitemap TEXT,
  lang VARCHAR(64),
  locales TEXT,
  logo_web VARCHAR(128),
  logo_mobile VARCHAR(128),
  logo_dark_web VARCHAR(128),
  logo_dark_mobile VARCHAR(128),
  logo_favicon VARCHAR(128),
  mail_driver VARCHAR(128) DEFAULT ('smtp'),
  mail_host VARCHAR(128) DEFAULT ('smtp.gmail.com'),
  mail_port VARCHAR(128) DEFAULT ('465'),
  mail_sender VARCHAR(128) DEFAULT ('Pariette.com'),
  mail_account VARCHAR(128) DEFAULT ('hi@pariette.com'),
  mail_password VARCHAR(128) DEFAULT ('mail_application_password'),
  mail_encryption VARCHAR(128) DEFAULT ('SSL'),
  cdn_url VARCHAR(128),
  status INTEGER NOT NULL DEFAULT 1,
  publish INTEGER NOT NULL DEFAULT 0,
  created_at DATE DEFAULT (datetime('now', 'localtime')),
  updated_at DATE DEFAULT (datetime('now', 'localtime'))
);

CREATE TABLE IF NOT EXISTS seo (
  id INTEGER PRIMARY KEY AUTOINCREMENT UNIQUE,
  position VARCHAR(64),
  type VARCHAR(64),
  label VARCHAR(64),
  value VARCHAR(256),
  created_at DATE DEFAULT (datetime('now', 'localtime')),
  updated_at DATE DEFAULT (datetime('now', 'localtime'))
);

CREATE TABLE IF NOT EXISTS user (
  id INTEGER PRIMARY KEY AUTOINCREMENT UNIQUE,
  token VARCHAR(8),
  name TEXT,
  surname TEXT,
  email TEXT,
  password TEXT,
  login_method TEXT,
  confirmation_code TEXT,
  confirmation_wait INTEGER DEFAULT 0,
  phone VARCHAR(16),
  avatar TEXT,
  signature TEXT,
  ip VARCHAR(16),
  old_ip VARCHAR(16),
  auth_group VARCHAR(16),
  status INTEGER NOT NULL DEFAULT 1,
  created_at DATE DEFAULT (datetime('now', 'localtime')),
  updated_at DATE DEFAULT (datetime('now', 'localtime'))
);

CREATE TABLE IF NOT EXISTS canvas (
  id INTEGER PRIMARY KEY AUTOINCREMENT UNIQUE,
  type VARCHAR(64),
  title VARCHAR(64),
  slug VARCHAR(256),
  user_id INTEGER,
  status INTEGER NOT NULL DEFAULT 1,
  publish INTEGER NOT NULL DEFAULT 0,
  relase_at DATE DEFAULT (datetime('now', 'localtime')),
  created_at DATE DEFAULT (datetime('now', 'localtime')),
  updated_at DATE DEFAULT (datetime('now', 'localtime')),
  FOREIGN KEY (user_id) REFERENCES users (id) ON DELETE CASCADE ON UPDATE NO ACTION
);

CREATE TABLE IF NOT EXISTS content (
  id INTEGER PRIMARY KEY AUTOINCREMENT,
  canvas_id INTEGER,
  user_id INTEGER,
  lang VARCHAR(16),
  type VARCHAR(16),
  title VARCHAR(256),
  description TEXT,
  content TEXT,
  keywords TEXT,
  cover_web VARCHAR(64),
  cover_mobile VARCHAR(64),
  meta_title TEXT,
  meta_description TEXT,
  line INTEGER NOT NULL DEFAULT 0,
  status INTEGER NOT NULL DEFAULT 1,
  publish INTEGER NOT NULL DEFAULT 1,
  created_at DATE DEFAULT (datetime('now', 'localtime')),
  updated_at DATE DEFAULT (datetime('now', 'localtime')),
  FOREIGN KEY (user_id) REFERENCES users (id) ON DELETE CASCADE ON UPDATE NO ACTION,
  FOREIGN KEY (canvas_id) REFERENCES canvas (id) ON DELETE CASCADE ON UPDATE NO ACTION
);

CREATE TABLE IF NOT EXISTS attachment (
  id INTEGER PRIMARY KEY AUTOINCREMENT,
  title VARCHAR(256),
  alt VARCHAR(256),
  href VARCHAR(256),
  cdn_url VARCHAR(256),
  file_format VARCHAR(16),
  file_size INTEGER,
  file_name VARCHAR(256),
  creator VARCHAR(256),
  license VARCHAR(256),
  source VARCHAR(256),
  status INTEGER NOT NULL DEFAULT 1,
  created_at DATE DEFAULT (datetime('now', 'localtime')),
  updated_at DATE DEFAULT (datetime('now', 'localtime'))
);

CREATE TABLE IF NOT EXISTS canvas_file (
  id INTEGER PRIMARY KEY AUTOINCREMENT,
  content_id INTEGER,
  file_id INTEGER,
  line INTEGER NOT NULL DEFAULT 0,
  status INTEGER NOT NULL DEFAULT 1,
  publish INTEGER NOT NULL DEFAULT 1,
  created_at DATE DEFAULT (datetime('now', 'localtime')),
  updated_at DATE DEFAULT (datetime('now', 'localtime')),
  FOREIGN KEY (file_id) REFERENCES attachment (id) ON DELETE CASCADE ON UPDATE NO ACTION,
  FOREIGN KEY (content_id) REFERENCES content (id) ON DELETE CASCADE ON UPDATE NO ACTION
);

CREATE TABLE IF NOT EXISTS ticket (
  id INTEGER PRIMARY KEY AUTOINCREMENT UNIQUE,
  type VARCHAR(64),
  user VARCHAR(128),
  title VARCHAR(128),
  content TEXT,
  status INTEGER NOT NULL DEFAULT 1,
  created_at DATE DEFAULT (datetime('now', 'localtime')),
  updated_at DATE DEFAULT (datetime('now', 'localtime'))
);

CREATE TABLE IF NOT EXISTS ticket_post (
  id INTEGER PRIMARY KEY AUTOINCREMENT UNIQUE,
  ticket_id INTEGER,
  writer VARCHAR(64),
  content TEXT,
  status INTEGER NOT NULL DEFAULT 1,
  rate INTEGER,
  created_at DATE DEFAULT (datetime('now', 'localtime')),
  updated_at DATE DEFAULT (datetime('now', 'localtime')),
  FOREIGN KEY (ticket_id) REFERENCES ticket (id) ON DELETE CASCADE ON UPDATE NO ACTION
);

CREATE TABLE IF NOT EXISTS lookup (
  id INTEGER PRIMARY KEY AUTOINCREMENT,
  type VARCHAR(64),
  main INTEGER,
  title VARCHAR(64),
  slug VARCHAR(128),
  status INTEGER NOT NULL DEFAULT 1,
  created_at DATE DEFAULT (datetime('now', 'localtime')),
  updated_at DATE DEFAULT (datetime('now', 'localtime'))
);

CREATE TABLE IF NOT EXISTS lookup_item (
  id INTEGER PRIMARY KEY AUTOINCREMENT,
  lookup_id INTEGER,
  item_id INTEGER,
  type VARCHAR(64),
  label VARCHAR(64),
  value VARCHAR(128),
  image VARCHAR(256),
  line INTEGER,
  status INTEGER NOT NULL DEFAULT 1,
  created_at DATE DEFAULT (datetime('now', 'localtime')),
  updated_at DATE DEFAULT (datetime('now', 'localtime')),
  FOREIGN KEY (lookup_id) REFERENCES lookup (id) ON DELETE CASCADE ON UPDATE NO ACTION,
  FOREIGN KEY (item_id) REFERENCES lookup_item (id) ON DELETE CASCADE ON UPDATE NO ACTION
);

CREATE TABLE IF NOT EXISTS navigation (
  id INTEGER PRIMARY KEY AUTOINCREMENT,
  canvas_id INTEGER,
  item_id INTEGER,
  lang VARCHAR(64),
  title VARCHAR(64),
  alt VARCHAR(64),
  route VARCHAR(64),
  url VARCHAR(64),
  link VARCHAR(64),
  params VARCHAR(64),
  icon VARCHAR(64),
  image VARCHAR(64),
  target VARCHAR(64),
  icon_only INTEGER DEFAULT 0,
  line INTEGER DEFAULT 0,
  status INTEGER NOT NULL DEFAULT 1,
  created_at DATE DEFAULT (datetime('now', 'localtime')),
  updated_at DATE DEFAULT (datetime('now', 'localtime')),
  FOREIGN KEY (canvas_id) REFERENCES navigation (id) ON DELETE CASCADE ON UPDATE NO ACTION,
  FOREIGN KEY (item_id) REFERENCES navigation (id) ON DELETE CASCADE ON UPDATE NO ACTION
);

INSERT INTO website (token, url, title, description, meta_title, meta_description, meta_keywords, meta_sitemap, lang, locales, logo_web, logo_mobile, logo_dark_web, logo_dark_mobile, logo_favicon, mail_driver, mail_host, mail_port, mail_sender, mail_account, mail_password, mail_encryption, cdn_url, status, publish, created_at) values  ('c49n7v1s', 'https://pariette.com/', 'Pariette.com', 'Best Headless Website on the World', '', '', '', '', 'en', '', '', '', '', '', '', '', '', '', '', '', '', '', '', 1, 1, '2023-03-06 22:51:21');
INSERT INTO user (token, name, surname, email, password, login_method, confirmation_code, confirmation_wait, phone, avatar, signature, ip, old_ip, auth_group, status, created_at) values ('c49n7v1s', 'ahmet selim', 'çil', 'hi@ahmetsc.com', 'pass', 'password', '', 0, '+905382578462', '', '', '', '', 'admin', 1, '2023-03-06 22:51:21');
INSERT INTO canvas (type, title, slug, user_id, status, publish) values ('homepage', 'pariette homepage', 'pariette_homepage', 1, 1, 1);
INSERT INTO canvas (type, title, slug, user_id, status, publish) values ('navigation', 'pariette header navigation', 'pariette_header_navigation', 1, 1, 1);
INSERT INTO content (canvas_id, user_id, lang, type, title, description, content, keywords, cover_web, cover_mobile, meta_title, meta_description, line, status, publish) values (1, 1, 'tr', 'carousel', 'pariette home carousel', '', '', '', '', '', '', '', 1, 1, 1);
INSERT INTO content (canvas_id, user_id, lang, type, title, description, content, keywords, cover_web, cover_mobile, meta_title, meta_description, line, status, publish) values (1, 1, 'tr', 'section_hero', 'pariette hero section', '', '<h1>hero</h1>', '', '', '', '', '', 2, 1, 1);
INSERT INTO content (canvas_id, user_id, lang, type, title, description, content, keywords, cover_web, cover_mobile, meta_title, meta_description, line, status, publish) values (1, 1, 'tr', 'section_page', 'pariette page section', '', '<h1>page</h1>', '', '', '', '', '', 3, 1, 1);
INSERT INTO attachment (title, alt, href, cdn_url, file_format, file_size, file_name, creator, license, source, status) values ('slider 1', 'slider 1', null, 'assets', 'jpg', 1024, 'slider_1.jpg', 'ahmet selim cil', 'free', 'canvas technology solutions', 1);
INSERT INTO attachment (title, alt, href, cdn_url, file_format, file_size, file_name, creator, license, source, status) values ('slider 2', 'slider 2', null, 'assets', 'jpg', 1024, 'slider_2.jpg', 'ahmet selim cil', 'free', 'canvas technology solutions', 1);
INSERT INTO canvas_file (content_id, file_id, line, status) values (1,1,1,1);
INSERT INTO canvas_file (content_id, file_id, line, status) values (1,2,2,1);
INSERT INTO navigation (canvas_id, item_id, lang, title, alt, route, url, link, params, icon, image, target, icon_only, line, status) values (2, null, 'tr', 'ana sayfa', 'ana sayfa', '/', null, null, null, null, null, null, 0, 1, 1);
INSERT INTO navigation (canvas_id, item_id, lang, title, alt, route, url, link, params, icon, image, target, icon_only, line, status) values (2, null, 'tr', 'hakkımızda', 'hakkımızda', '/about-us', null, null, null, null, null, null, 0, 2, 1);
INSERT INTO navigation (canvas_id, item_id, lang, title, alt, route, url, link, params, icon, image, target, icon_only, line, status) values (2, null, 'tr', 'iletişim', 'iletişim', '/contact', null, null, null, null, null, null, 0, 3, 1);
-- INSERT INTO lookup (type, main, title, slug) values ('', null, '', '');
-- INSERT INTO seo () values ();
-- INSERT INTO lookup_item () values ();

-- Down
DROP TABLE website;
DROP TABLE seo;
DROP TABLE user;
DROP TABLE canvas;
DROP TABLE content;
DROP TABLE attachment;
DROP TABLE canvas_file;
DROP TABLE ticket;
DROP TABLE ticket_post;
DROP TABLE lookup;
DROP TABLE lookup_item;
DROP TABLE navigation;