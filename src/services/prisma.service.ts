import { PrismaClient } from "@prisma/client";

let prismaClient: ReturnType<typeof PrismaClient> | undefined

export const prisma = () => {
    if(!prisma){
        prismaClient = new PrismaClient()
        return prismaClient
    }
    return prismaClient
}