import prisma from "./prisma.service"

export const slotsService = async (id: string, date: string) => {
    const data = await prisma.rawData.findMany({
        where: {
            productId: parseInt(id),
            startDate: date
        },
        include: {
            paxAvailability: true
        }
    })
    let res = []
    for (let i = 0; i < data.length; i++) {
        let tempData = data[i]
        res[i] = {startTime: tempData.startDate,
            startDate: tempData.startDate,
            remaining: tempData.remaining,
            paxAvailability: tempData.paxAvailability   
        }
    }

    // console.info(res)
    return res
}