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
SELECT species from animals;
ROLLBACK;
SELECT species from animals;

BEGIN;
UPDATE animals 
SET species = 'digimon'
WHERE name LIKE '%mon';
SELECT species from animals;

BEGIN;
UPDATE animals 
SET species = 'pokemon'
WHERE name NOT LIKE '%mon';
COMMIT;
SELECT species from animals;

BEGIN;
DELETE FROM animals;
ROLLBACK;
SELECT * from animals;

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
SELECT * from animals;

-- Write queries to answer the questions
SELECT COUNT(*) FROM animals; //10

SELECT COUNT(escape_attempts) FROM animals
WHERE escape_attempts = 0; //2

SELECT AVG(weight_kg) FROM animals; //15.55...

SELECT neutered, AVG(escape_attempts) FROM animals
GROUP BY neutered;

SELECT species, MAX(weight_kg), MIN(weight_kg) FROM animals
GROUP BY species;

SELECT species, AVG(escape_attempts) FROM animals
WHERE date_of_birth BETWEEN '1990-01-01' AND '2001-01-01'
GROUP BY species;
