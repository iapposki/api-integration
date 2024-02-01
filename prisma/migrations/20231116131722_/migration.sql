-- CreateTable
CREATE TABLE "ProductID" (
    "id" SERIAL NOT NULL,
    "productID" INTEGER NOT NULL,

    CONSTRAINT "ProductID_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "RawData" (
    "id" SERIAL NOT NULL,
    "productId" INTEGER NOT NULL,
    "startDate" TEXT NOT NULL,
    "startTime" TEXT NOT NULL,
    "endTime" TEXT NOT NULL,
    "providerSlotId" TEXT NOT NULL,
    "remaining" INTEGER NOT NULL,
    "currencyCode" TEXT NOT NULL,
    "variantId" INTEGER NOT NULL,

    CONSTRAINT "RawData_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "Pax" (
    "id" SERIAL NOT NULL,
    "max" INTEGER NOT NULL,
    "min" INTEGER NOT NULL,
    "remaining" INTEGER NOT NULL,
    "type" TEXT NOT NULL,
    "isPrimary" BOOLEAN,
    "description" TEXT NOT NULL,
    "name" TEXT NOT NULL,
    "discount" DOUBLE PRECISION NOT NULL,
    "finalPrice" DOUBLE PRECISION NOT NULL,
    "originalPrice" DOUBLE PRECISION NOT NULL,
    "currencyCode" TEXT NOT NULL,
    "aPIdataId" INTEGER,

    CONSTRAINT "Pax_pkey" PRIMARY KEY ("id")
);

-- CreateIndex
CREATE UNIQUE INDEX "ProductID_productID_key" ON "ProductID"("productID");

-- CreateIndex
CREATE UNIQUE INDEX "RawData_providerSlotId_key" ON "RawData"("providerSlotId");

-- AddForeignKey
ALTER TABLE "Pax" ADD CONSTRAINT "Pax_aPIdataId_fkey" FOREIGN KEY ("aPIdataId") REFERENCES "RawData"("id") ON DELETE SET NULL ON UPDATE CASCADE;
