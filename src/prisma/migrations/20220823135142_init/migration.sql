/*
  Warnings:

  - You are about to drop the column `defaultLogin` on the `User` table. All the data in the column will be lost.
  - You are about to drop the column `deletedAt` on the `User` table. All the data in the column will be lost.
  - You are about to drop the column `deletedById` on the `User` table. All the data in the column will be lost.
  - You are about to drop the column `isDeleted` on the `User` table. All the data in the column will be lost.
  - You are about to drop the `Admin` table. If the table is not empty, all the data it contains will be lost.
  - You are about to drop the `SignUp` table. If the table is not empty, all the data it contains will be lost.
  - Added the required column `email` to the `User` table without a default value. This is not possible if the table is not empty.
  - Added the required column `password` to the `User` table without a default value. This is not possible if the table is not empty.

*/
-- DropForeignKey
ALTER TABLE `SignUp` DROP FOREIGN KEY `SignUp_deletedById_fkey`;

-- DropForeignKey
ALTER TABLE `SignUp` DROP FOREIGN KEY `SignUp_userId_fkey`;

-- DropForeignKey
ALTER TABLE `User` DROP FOREIGN KEY `User_deletedById_fkey`;

-- AlterTable
ALTER TABLE `User` DROP COLUMN `defaultLogin`,
    DROP COLUMN `deletedAt`,
    DROP COLUMN `deletedById`,
    DROP COLUMN `isDeleted`,
    ADD COLUMN `address` VARCHAR(191) NULL,
    ADD COLUMN `avatar` VARCHAR(191) NULL,
    ADD COLUMN `cell` VARCHAR(191) NULL,
    ADD COLUMN `city` VARCHAR(191) NULL,
    ADD COLUMN `club` VARCHAR(191) NULL,
    ADD COLUMN `country` VARCHAR(191) NULL,
    ADD COLUMN `dateOfBirth` DATETIME(3) NULL,
    ADD COLUMN `email` VARCHAR(191) NOT NULL,
    ADD COLUMN `firstName` VARCHAR(191) NULL,
    ADD COLUMN `gender` ENUM('MALE', 'FEMALE', 'PREFER_NOT_TO_SAY') NULL DEFAULT 'PREFER_NOT_TO_SAY',
    ADD COLUMN `isActive` BOOLEAN NULL DEFAULT true,
    ADD COLUMN `isVerified` BOOLEAN NULL DEFAULT false,
    ADD COLUMN `lastName` VARCHAR(191) NULL,
    ADD COLUMN `password` VARCHAR(191) NOT NULL,
    ADD COLUMN `state` VARCHAR(191) NULL,
    ADD COLUMN `zipCode` VARCHAR(191) NULL;

-- DropTable
DROP TABLE `Admin`;

-- DropTable
DROP TABLE `SignUp`;

-- CreateTable
CREATE TABLE `OpsUser` (
    `id` VARCHAR(191) NOT NULL,
    `username` VARCHAR(191) NOT NULL,
    `password` VARCHAR(191) NOT NULL,
    `createdAt` DATETIME(3) NOT NULL,
    `updatedAt` DATETIME(3) NOT NULL,

    PRIMARY KEY (`id`)
) DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;

-- CreateTable
CREATE TABLE `DeletedUser` (
    `id` VARCHAR(191) NOT NULL,
    `deletedAt` DATETIME(3) NOT NULL,
    `deletedById` VARCHAR(191) NOT NULL,
    `userId` VARCHAR(191) NOT NULL,
    `createdAt` DATETIME(3) NOT NULL,
    `updatedAt` DATETIME(3) NOT NULL,

    UNIQUE INDEX `DeletedUser_userId_key`(`userId`),
    PRIMARY KEY (`id`)
) DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;

-- AddForeignKey
ALTER TABLE `DeletedUser` ADD CONSTRAINT `DeletedUser_deletedById_fkey` FOREIGN KEY (`deletedById`) REFERENCES `OpsUser`(`id`) ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE `DeletedUser` ADD CONSTRAINT `DeletedUser_userId_fkey` FOREIGN KEY (`userId`) REFERENCES `User`(`id`) ON DELETE RESTRICT ON UPDATE CASCADE;
