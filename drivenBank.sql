-- Create database
CREATE DATABASE "drivenBank";

-- Create customers table
CREATE TABLE customers (
	id serial NOT NULL PRIMARY KEY,
    "fullName" text NOT NULL,
	cpf varchar(11) NOT NULL UNIQUE,
    email text NOT NULL UNIQUE,
    password text NOT NULL
);

--Create customerPhones table
CREATE TYPE phone AS ENUM ('landline', 'mobile')
CREATE TABLE "customerPhones" (
	id serial NOT NULL PRIMARY KEY,
  	"customerId" integer NOT NULL REFERENCES customers(id),
  	number VARCHAR(11) NOT NULL,
  	type phone
);

--Create states table
CREATE TABLE "states" (
	id serial NOT NULL PRIMARY KEY,
  	name text NOT NULL UNIQUE
);

--Create cities table
CREATE TABLE "cities" (
	id serial NOT NULL PRIMARY KEY,
  	name text NOT NULL,
	"stateId" integer NOT NULL REFERENCES states(id)
);

--Create customerAddresses table
CREATE TABLE "customerAddresses" (
	id serial NOT NULL PRIMARY KEY,
  	"customerId" integer NOT NULL REFERENCES customers(id),
  	street text NOT NULL,
	number integer NOT NULL,
  	complement text,
	"postalCode" VARCHAR(8) NOT NULL,
	"cityId" integer NOT NULL REFERENCES cities(id)
);

-- Create bankAccount table
CREATE TABLE "bankAccount" (
	id serial NOT NULL PRIMARY KEY,
  	"customerId" integer NOT NULL REFERENCES customers(id),
  	"accountNumber" integer NOT NULL UNIQUE,
	agency VARCHAR(4) NOT NULL,
  	"openDate" date NOT NULL DEFAULT NOW(),
	"closeDate" date NOT NULL DEFAULT NULL
);

--Create transactions table
CREATE TYPE transaction AS ENUM ('deposit', 'withdraw')
CREATE TABLE "transactions" (
	id serial NOT NULL PRIMARY KEY,
  	"bankAccountId" integer NOT NULL REFERENCES "bankAccount"(id),
    amount text NOT NULL,
    type text NOT NULL
  	time time NOT NULL,
	description text,
  	cancelled boolean NOT NULL DEFAULT false
);

--Create creditCards table 
CREATE TABLE "creditCards" (
	id serial NOT NULL PRIMARY KEY,
  	"bankAccountId" integer NOT NULL REFERENCES "bankAccount"(id),
  	name text NOT NULL,
	number integer NOT NULL UNIQUE,
  	"securityCode" CHAR(3) NOT NULL,
	"expirationMonth" CHAR(2) NOT NULL,
    "expirationYear" CHAR(4) NOT NULL,
    password CHAR(6) NOT NULL,
    limit text NOT NULL
);