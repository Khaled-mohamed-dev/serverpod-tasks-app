BEGIN;

--
-- ACTION CREATE TABLE
--
CREATE TABLE "task" (
    "id" serial PRIMARY KEY,
    "text" text NOT NULL,
    "priority" text NOT NULL,
    "date" timestamp without time zone NOT NULL,
    "isChecked" boolean NOT NULL
);


--
-- MIGRATION VERSION FOR tasks
--
INSERT INTO "serverpod_migrations" ("module", "version", "timestamp")
    VALUES ('tasks', '20240508044251429', now())
    ON CONFLICT ("module")
    DO UPDATE SET "version" = '20240508044251429', "timestamp" = now();

--
-- MIGRATION VERSION FOR serverpod
--
INSERT INTO "serverpod_migrations" ("module", "version", "timestamp")
    VALUES ('serverpod', '20240115074235544', now())
    ON CONFLICT ("module")
    DO UPDATE SET "version" = '20240115074235544', "timestamp" = now();


COMMIT;
