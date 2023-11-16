import { Request, Response } from "express"
import { slotsService } from "../services/slots.service";

export const getSlots = async (req:Request, res: Response) => {
    const {id} = req.params;
    const {date} : any = req.query

    try {
        let resData = await slotsService(id, date) 
        res.status(200).json(resData)
    } catch (error) {
        console.log(error)
    }

}