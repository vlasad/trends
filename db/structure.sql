CREATE TABLE IF NOT EXISTS "schema_migrations" ("version" varchar NOT NULL PRIMARY KEY);
CREATE TABLE IF NOT EXISTS "ar_internal_metadata" ("key" varchar NOT NULL PRIMARY KEY, "value" varchar, "created_at" datetime(6) NOT NULL, "updated_at" datetime(6) NOT NULL);
CREATE TABLE IF NOT EXISTS "banners" ("id" integer PRIMARY KEY AUTOINCREMENT NOT NULL, "code" varchar(16) NOT NULL, "views" integer DEFAULT 0 NOT NULL, "clicks" integer DEFAULT 0 NOT NULL, "created_at" datetime(6) NOT NULL, "updated_at" datetime(6) NOT NULL);
CREATE TABLE sqlite_sequence(name,seq);
CREATE UNIQUE INDEX "index_banners_on_code" ON "banners" ("code");
CREATE TABLE IF NOT EXISTS "custom_banners" ("id" integer PRIMARY KEY AUTOINCREMENT NOT NULL, "banner_id" integer NOT NULL, "views" integer DEFAULT 0 NOT NULL, "clicks" integer DEFAULT 0 NOT NULL, "params" text, "created_at" datetime(6) NOT NULL, "updated_at" datetime(6) NOT NULL, CONSTRAINT "fk_rails_1ed06ee18f"
FOREIGN KEY ("banner_id")
  REFERENCES "banners" ("id")
);
CREATE INDEX "index_custom_banners_on_banner_id" ON "custom_banners" ("banner_id");
CREATE TABLE IF NOT EXISTS "categories" ("id" integer PRIMARY KEY AUTOINCREMENT NOT NULL, "code" varchar(128) NOT NULL, "created_at" datetime(6) NOT NULL, "updated_at" datetime(6) NOT NULL);
CREATE UNIQUE INDEX "index_categories_on_code" ON "categories" ("code");
CREATE TABLE IF NOT EXISTS "offers" ("id" integer PRIMARY KEY AUTOINCREMENT NOT NULL, "code" varchar(256) NOT NULL, "affiliate_url" varchar NOT NULL, "created_at" datetime(6) NOT NULL, "updated_at" datetime(6) NOT NULL);
CREATE UNIQUE INDEX "index_offers_on_code" ON "offers" ("code");
CREATE TABLE IF NOT EXISTS "pages" ("id" integer PRIMARY KEY AUTOINCREMENT NOT NULL, "category_id" integer NOT NULL, "offer_id" integer NOT NULL, "custom_banner_id" integer NOT NULL, "code" varchar NOT NULL, "title" varchar NOT NULL, "content_url" varchar NOT NULL, "created_at" datetime(6) NOT NULL, "updated_at" datetime(6) NOT NULL, CONSTRAINT "fk_rails_5f634a1e21"
FOREIGN KEY ("category_id")
  REFERENCES "categories" ("id")
, CONSTRAINT "fk_rails_501123ad29"
FOREIGN KEY ("offer_id")
  REFERENCES "offers" ("id")
, CONSTRAINT "fk_rails_c21d4e18ab"
FOREIGN KEY ("custom_banner_id")
  REFERENCES "custom_banners" ("id")
);
CREATE INDEX "index_pages_on_category_id" ON "pages" ("category_id");
CREATE INDEX "index_pages_on_offer_id" ON "pages" ("offer_id");
CREATE INDEX "index_pages_on_custom_banner_id" ON "pages" ("custom_banner_id");
CREATE UNIQUE INDEX "index_pages_on_code" ON "pages" ("code");
INSERT INTO "schema_migrations" (version) VALUES
('20201220094258'),
('20201220095117'),
('20201220100325'),
('20201220100557'),
('20201220101102');


