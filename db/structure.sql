CREATE TABLE IF NOT EXISTS "schema_migrations" ("version" varchar NOT NULL PRIMARY KEY);
CREATE TABLE IF NOT EXISTS "ar_internal_metadata" ("key" varchar NOT NULL PRIMARY KEY, "value" varchar, "created_at" datetime(6) NOT NULL, "updated_at" datetime(6) NOT NULL);
CREATE TABLE IF NOT EXISTS "banner_types" ("id" integer PRIMARY KEY AUTOINCREMENT NOT NULL, "file_name" varchar NOT NULL, "views" integer DEFAULT 0 NOT NULL, "clicks" integer DEFAULT 0 NOT NULL, "created_at" datetime(6) NOT NULL, "updated_at" datetime(6) NOT NULL);
CREATE TABLE sqlite_sequence(name,seq);
CREATE UNIQUE INDEX "index_banner_types_on_file_name" ON "banner_types" ("file_name");
CREATE TABLE IF NOT EXISTS "banners" ("id" integer PRIMARY KEY AUTOINCREMENT NOT NULL, "banner_type_id" integer NOT NULL, "page_id" integer NOT NULL, "code" varchar(16) NOT NULL, "views" integer DEFAULT 0 NOT NULL, "clicks" integer DEFAULT 0 NOT NULL, "data" text, "created_at" datetime(6) NOT NULL, "updated_at" datetime(6) NOT NULL, CONSTRAINT "fk_rails_fcc65012de"
FOREIGN KEY ("banner_type_id")
  REFERENCES "banner_types" ("id")
, CONSTRAINT "fk_rails_412b4abc08"
FOREIGN KEY ("page_id")
  REFERENCES "pages" ("id")
);
CREATE INDEX "index_banners_on_banner_type_id" ON "banners" ("banner_type_id");
CREATE INDEX "index_banners_on_page_id" ON "banners" ("page_id");
CREATE UNIQUE INDEX "index_banners_on_code" ON "banners" ("code");
CREATE TABLE IF NOT EXISTS "categories" ("id" integer PRIMARY KEY AUTOINCREMENT NOT NULL, "code" varchar(128) NOT NULL, "created_at" datetime(6) NOT NULL, "updated_at" datetime(6) NOT NULL);
CREATE UNIQUE INDEX "index_categories_on_code" ON "categories" ("code");
CREATE TABLE IF NOT EXISTS "offers" ("id" integer PRIMARY KEY AUTOINCREMENT NOT NULL, "code" varchar(256) NOT NULL, "affiliate_url" varchar NOT NULL, "created_at" datetime(6) NOT NULL, "updated_at" datetime(6) NOT NULL);
CREATE UNIQUE INDEX "index_offers_on_code" ON "offers" ("code");
CREATE UNIQUE INDEX "index_offers_on_affiliate_url" ON "offers" ("affiliate_url");
CREATE TABLE IF NOT EXISTS "pages" ("id" integer PRIMARY KEY AUTOINCREMENT NOT NULL, "category_id" integer NOT NULL, "offer_id" integer NOT NULL, "code" varchar NOT NULL, "content_url" varchar NOT NULL, "title" varchar NOT NULL, "description" varchar, "keywords" varchar, "meta_image_url" varchar, "created_at" datetime(6) NOT NULL, "updated_at" datetime(6) NOT NULL, CONSTRAINT "fk_rails_5f634a1e21"
FOREIGN KEY ("category_id")
  REFERENCES "categories" ("id")
, CONSTRAINT "fk_rails_501123ad29"
FOREIGN KEY ("offer_id")
  REFERENCES "offers" ("id")
);
CREATE INDEX "index_pages_on_category_id" ON "pages" ("category_id");
CREATE INDEX "index_pages_on_offer_id" ON "pages" ("offer_id");
CREATE UNIQUE INDEX "index_pages_on_code" ON "pages" ("code");
INSERT INTO "schema_migrations" (version) VALUES
('20201220094258'),
('20201220095117'),
('20201220100325'),
('20201220100557'),
('20201220101102');


