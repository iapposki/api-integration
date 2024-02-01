-- CreateTable
CREATE TABLE "APIdata" (
    "id" INTEGER NOT NULL PRIMARY KEY AUTOINCREMENT,
    "startDate" TEXT NOT NULL,
    "startTime" TEXT NOT NULL,
    "endTime" TEXT NOT NULL,
    "providerSlotId" TEXT NOT NULL,
    "remaining" INTEGER NOT NULL,
    "currencyCode" TEXT NOT NULL,
    "variantId" INTEGER NOT NULL
);

-- CreateTable
CREATE TABLE "Pax" (
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
    CONSTRAINT "Pax_aPIdataId_fkey" FOREIGN KEY ("aPIdataId") REFERENCES "APIdata" ("id") ON DELETE SET NULL ON UPDATE CASCADE
);

-- CreateIndex
CREATE UNIQUE INDEX "APIdata_providerSlotId_key" ON "APIdata"("providerSlotId");
