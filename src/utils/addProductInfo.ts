import prisma from "../src/services/prisma.service"

const main = async () => {
    await prisma.productID.create({
                data: {
                            productID: 14,
                            availability: [0,2,4,6]
                        }
                    })
    await prisma.productID.create({
            data: {
                        productID: 15,
                        availability: [0]
                    }
                })
}   

main()