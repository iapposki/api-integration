/*
  Warnings:

  - You are about to drop the `APIdata` table. If the table is not empty, all the data it contains will be lost.

*/
-- DropIndex
DROP INDEX "APIdata_providerSlotId_key";

-- DropTable
PRAGMA foreign_keys=off;
DROP TABLE "APIdata";
PRAGMA foreign_keys=on;

-- CreateTable
CREATE TABLE "RawData" (
    "id" INTEGER NOT NULL PRIMARY KEY AUTOINCREMENT,
    "startDate" TEXT NOT NULL,
    "startTime" TEXT NOT NULL,
    "endTime" TEXT NOT NULL,
    "providerSlotId" TEXT NOT NULL,
    "remaining" INTEGER NOT NULL,
    "currencyCode" TEXT NOT NULL,
    "variantId" INTEGER NOT NULL
);

-- RedefineTables
PRAGMA foreign_keys=OFF;
CREATE TABLE "new_Pax" (
    "id" INTEGER NOT NULL PRIMARY KEY AUTOINCREMENT,
    "max" INTEGER NOT NULL,
    "min" INTEGER NOT NULL,
    "remaining" INTEGER NOT NULL,
    "type" TEXT NOT NULL,
    "isPrimary" BOOLEAN NOT NULL,
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

-- CreateIndex
CREATE UNIQUE INDEX "RawData_providerSlotId_key" ON "RawData"("providerSlotId");
