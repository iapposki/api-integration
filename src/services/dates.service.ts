import prisma from "./prisma.service"

export const datesService = async (id:string) => {
    var date = new Date()
    var param = date.toISOString().split('T')[0]

    let dates = []
    for (let i = 0; i < 60; i++) {
        var element = await prisma.rawData.findMany({
            where: {
                productId: parseInt(id),
                startDate: param
            }
        })
        
                date = new Date(date.valueOf() + 1*24*60*60*1000)     
                param = date.toISOString().split('T')[0]
        
                dates.push(...element)
    }
    return dates
}