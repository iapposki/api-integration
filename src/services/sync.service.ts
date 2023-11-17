import prisma from "./prisma.service";
import axios from 'axios'

export const syncService = async (daysToSync: number) => {
    const products = await prisma.productID.findMany({})
    const headers = {
        "Content-Type": "application/json",
        'x-api-key': process.env['API_KEY']
    }
    for (let i = 0; i < products.length; i++) {
        var date = new Date()
        var param = date.toISOString().split('T')[0]
        let id = String(products[i].productID)
        let availability = products[i].availability
        for (let j = 0; j < daysToSync; j++) {
            let day: any = new Date(param)
            day = day.getDay()
            if (availability.includes(day)) {    
                console.log('syncing day : ' + String(j+1) + ' ; Product ID : ' + String(id))
                try{
                    var response = await axios.post("https://leap-api.tickete.co/api/v1/inventory/" + String(id) + "?date=" + param, {}, {headers: headers})
                } catch (err:any) {
                    console.log('rate limit reached, waiting for : ' + String((err.response.data.rateLimitState.reset - Date.now())/1000) + ' seconds to resume syncing.')
                    await timer(err.response.data.rateLimitState.reset - Date.now())
                    var response = await axios.post("https://leap-api.tickete.co/api/v1/inventory/" + String(id) + "?date=" + param, {}, {headers: headers})
                }
                response.data.forEach(async (element: any) => {
                    try {
                        element.paxAvailability.map((x:any) => {
                            let temp = x.price
                            delete x.price
                            x = Object.assign(x, temp)
                        })
                        const pastRecord = await prisma.rawData.findUnique({
                            where:{
                                providerSlotId: element.providerSlotId
                            }
                        })
                        if (pastRecord){
                            await prisma.rawData.update({
                                where: {
                                    providerSlotId: element.providerSlotId
                                },
                                data: {
                                    productId: parseInt(id),
                                    startDate: element.startDate,
                                    startTime: element.startTime,
                                    endTime: element.endTime,
                                    providerSlotId: element.providerSlotId,
                                    remaining: element.remaining,
                                    currencyCode: element.currencyCode,
                                    variantId: element.variantId,
                                    paxAvailability:{
                                        create: element.paxAvailability
                                    }
                                }
                            })
                        } else {
                            await prisma.rawData.create({
                                data: {
                                    productId: parseInt(id),
                                    startDate: element.startDate,
                                    startTime: element.startTime,
                                    endTime: element.endTime,
                                    providerSlotId: element.providerSlotId,
                                    remaining: element.remaining,
                                    currencyCode: element.currencyCode,
                                    variantId: element.variantId,
                                    paxAvailability:{
                                        create: element.paxAvailability
                                    }
                                }
                            })
                        }

                    } catch(error) {
                        console.log(error)
                    }
                });
            }
            date = new Date(date.valueOf() + 1*24*60*60*1000)     
            param = date.toISOString().split('T')[0]
        }
    }
    
}


function timer(v:number){
    return new Promise(r=>setTimeout(r,v));
}

