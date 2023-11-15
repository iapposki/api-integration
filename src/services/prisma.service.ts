import { PrismaClient } from "@prisma/client";

let prismaClient: any;

export const prisma = () => {
    if(!prisma){
        prismaClient = new PrismaClient()
        return prismaClient
    }
    return prismaClient
}