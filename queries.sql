SELECT * FROM animals WHERE name LIKE '%mon';
SELECT name FROM animals WHERE date_of_birth >= '2016-01-01' AND date_of_birth <= '2019-01-01';
SELECT name FROM animals WHERE neutered = true AND escape_attempts < 3;
SELECT date_of_birth FROM animals WHERE name IN ('Agumon', 'Pikachu');
SELECT name, escape_attempts FROM animals WHERE weight_kg > 10.5;
SELECT * FROM animals WHERE neutered = true;
SELECT * FROM animals WHERE name != 'Gabumon';
SELECT * FROM animals WHERE weight_kg BETWEEN 10.4 AND 17.4;

-- Transactions
BEGIN;
UPDATE animals
SET species = 'unspecified';
ROLLBACK;
BEGIN;
UPDATE animals 
SET species = 'digimon'
WHERE name LIKE '%mon';
BEGIN;
UPDATE animals 
SET species = 'pokemon'
WHERE name NOT LIKE '%mon';
COMMIT;
BEGIN;
DELETE FROM animals;
ROLLBACK;
BEGIN;
DELETE FROM animals
WHERE date_of_birth > '2022-01-01';
SAVEPOINT del1;
BEGIN;
UPDATE animals
SET weight_kg = weight_kg * (-1);
ROLLBACK TO SAVEPOINT del1;
BEGIN;
UPDATE animals
SET weight_kg = weight_kg * (-1)
WHERE weight_kg < 0;
COMMIT;
-- Write queries to answer the questions
SELECT COUNT(*) FROM animals; //10
SELECT COUNT(escape_attempts) FROM animals
WHERE neutered = false; //3
SELECT AVG(weight_kg) FROM animals; //15.55...
SELECT SUM(escape_attempts) FROM animals
WHERE neutered = false; // 4
SELECT SUM(escape_attempts) FROM animals
WHERE neutered = true; // 20
SELECT MAX(weight_kg) FROM animals
WHERE species = 'digimon'; // 45
SELECT MIN(weight_kg) FROM animals
WHERE species = 'digimon'; // 5.7
SELECT MAX(weight_kg) FROM animals
WHERE species = 'pokemon'; // 17
SELECT MIN(weight_kg) FROM animals
WHERE species = 'pokemon'; // 11
SELECT AVG(escape_attempts) FROM animals
WHERE date_of_birth BETWEEN '1990-01-01' AND '2001-01-01' AND species = 'pokemon';
SELECT AVG(escape_attempts) FROM animals
WHERE date_of_birth BETWEEN '1990-01-01' AND '2001-01-01' AND species = 'digimon';


