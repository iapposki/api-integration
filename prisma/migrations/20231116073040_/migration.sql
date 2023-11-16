-- RedefineTables
PRAGMA foreign_keys=OFF;
CREATE TABLE "new_Pax" (
    "id" INTEGER NOT NULL PRIMARY KEY AUTOINCREMENT,
    "max" INTEGER NOT NULL,
    "min" INTEGER NOT NULL,
    "remaining" INTEGER NOT NULL,
    "type" TEXT NOT NULL,
    "isPrimary" BOOLEAN,
    "description" TEXT NOT NULL,
    "name" TEXT NOT NULL,
    "discount" REAL NOT NULL,
    "finalPrice" REAL NOT NULL,
    "originalPrice" REAL NOT NULL,
    "currencyCode" TEXT NOT NULL,
    "aPIdataId" INTEGER,
    CONSTRAINT "Pax_aPIdataId_fkey" FOREIGN KEY ("aPIdataId") REFERENCES "RawData" ("id") ON DELETE SET NULL ON UPDATE CASCADE
);
INSERT INTO "new_Pax" ("aPIdataId", "currencyCode", "description", "discount", "finalPrice", "id", "isPrimary", "max", "min", "name", "originalPrice", "remaining", "type") SELECT "aPIdataId", "currencyCode", "description", "discount", "finalPrice", "id", "isPrimary", "max", "min", "name", "originalPrice", "remaining", "type" FROM "Pax";
DROP TABLE "Pax";
ALTER TABLE "new_Pax" RENAME TO "Pax";
PRAGMA foreign_key_check;
PRAGMA foreign_keys=ON;
