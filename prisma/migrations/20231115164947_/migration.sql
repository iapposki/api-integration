-- CreateTable
CREATE TABLE "ProductID" (
    "id" INTEGER NOT NULL PRIMARY KEY AUTOINCREMENT,
    "productID" INTEGER NOT NULL
);

-- CreateIndex
CREATE UNIQUE INDEX "ProductID_productID_key" ON "ProductID"("productID");
