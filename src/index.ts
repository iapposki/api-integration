require('dotenv').config()
import express from 'express';
import bodyParser from 'body-parser';
import cors from 'cors';

import {Request, Response, Express} from 'express';


const app: Express = express();
const port: number = 3000;

app.use(bodyParser.urlencoded({extended: true}));
app.use(bodyParser.json());
app.use(cors());

app.get('/status',async (req:Request, res, Response) => {
    res.send("Server is online.")
})

if (require.main === module) {
    app.listen(port, () => {
        console.log(`Server is running on port ${port}`);
    })
}

export default app;