require('dotenv').config()
import express from 'express';
import bodyParser from 'body-parser';
import cors from 'cors';
import cron from 'node-cron'
import {Request, Response, Express} from 'express';

import { getSlots } from './controllers/slots.controller';
import { getDates } from './controllers/dates.controller';
import { syncService } from './services/sync.service';


const app: Express = express();
const port: number = 3000;

app.use(bodyParser.urlencoded({extended: true}));
app.use(bodyParser.json());
app.use(cors());


app.get('/api/v1/experience/:id/slots', getSlots)
app.get('/api/v1/experience/:id/dates', getDates)


app.get('/status',async (req:Request, res, Response) => {
    res.send("Server is online.")
})

if (require.main === module) {
    app.listen(port, () => {
        console.log(`Server is running on port ${port}`);
    })
    cron.schedule('*/15 * * * *', () => {
        console.log('Fetching availability for today.')
        syncService(1)
    })
    cron.schedule('3 */4 * * *', () => {
        console.log('Fetching availability for next 7 days.')
        syncService(7)
    })
    cron.schedule('6 0 * * *', () => {
        console.log('Fetching availability for next 30 days.')
        syncService(30)
    }) 
}

export default app;