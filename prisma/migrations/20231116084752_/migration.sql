/*
  Warnings:

  - Added the required column `productId` to the `RawData` table without a default value. This is not possible if the table is not empty.

*/
-- RedefineTables
PRAGMA foreign_keys=OFF;
CREATE TABLE "new_RawData" (
    "id" INTEGER NOT NULL PRIMARY KEY AUTOINCREMENT,
    "productId" INTEGER NOT NULL,
    "startDate" TEXT NOT NULL,
    "startTime" TEXT NOT NULL,
    "endTime" TEXT NOT NULL,
    "providerSlotId" TEXT NOT NULL,
    "remaining" INTEGER NOT NULL,
    "currencyCode" TEXT NOT NULL,
    "variantId" INTEGER NOT NULL
);
INSERT INTO "new_RawData" ("currencyCode", "endTime", "id", "providerSlotId", "remaining", "startDate", "startTime", "variantId") SELECT "currencyCode", "endTime", "id", "providerSlotId", "remaining", "startDate", "startTime", "variantId" FROM "RawData";
DROP TABLE "RawData";
ALTER TABLE "new_RawData" RENAME TO "RawData";
CREATE UNIQUE INDEX "RawData_providerSlotId_key" ON "RawData"("providerSlotId");
PRAGMA foreign_key_check;
PRAGMA foreign_keys=ON;
