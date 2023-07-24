import dotenv from 'dotenv';
dotenv.config();
// import express from 'express';
const express =require('express')
// import cors from 'cors';
// import bodyParser from 'body-parser';




const server = express();
import bodyParser from 'body-parser';
server.use(bodyParser.json())


import routerConfig from './src/routes'
server.use('/api',routerConfig)


server.listen(process.env.PORT, () => {
    console.log("Server đã chạy tại port", process.env.PORT)
})