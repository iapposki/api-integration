import { Request, Response } from "express"
import { datesService } from "../services/dates.service";

export const getDates = async (req: Request, res: Response) => {
    const {id} = req.params;
    try {
        let data = await datesService(id)
        res.status(200).json(data)
    } catch (error) {
        console.log(error)
    }
}