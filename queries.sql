SELECT * FROM animals WHERE name LIKE '%mon';

SELECT name FROM animals WHERE date_of_birth >= '2016-01-01' AND date_of_birth <= '2019-01-01';

SELECT name FROM animals WHERE neutered = true AND escape_attempts < 3;

SELECT date_of_birth FROM animals WHERE name IN ('Agumon', 'Pikachu');

SELECT name, escape_attempts FROM animals WHERE weight_kg > 10.5;

SELECT * FROM animals WHERE neutered = true;

SELECT * FROM animals WHERE name != 'Gabumon';

SELECT * FROM animals WHERE weight_kg BETWEEN 10.4 AND 17.4;

-- Transactions
-- Inside a transaction update the animals table by setting the species column to 
-- unspecified. Verify that change was made. Then roll back the change and verify that 
-- species columns went back to the state before transaction.
BEGIN;
UPDATE animals
SET species = 'unspecified';
SELECT species from animals;
ROLLBACK;
SELECT species from animals;

-- Update the animals table by setting the species column to digimon 
-- for all animals that have a name ending in mon.
BEGIN;
UPDATE animals 
SET species = 'digimon'
WHERE name LIKE '%mon';
SELECT species from animals;

-- Update the animals table by setting the species column to 
-- pokemon for all animals that don't have species already set.
BEGIN;
UPDATE animals 
SET species = 'pokemon'
WHERE name NOT LIKE '%mon';
COMMIT;
SELECT species from animals;

-- Inside a transaction delete all records in the animals table, then roll back the transaction.
BEGIN;
DELETE FROM animals;
ROLLBACK;
SELECT * from animals;

-- Delete all animals born after Jan 1st, 2022
BEGIN;
DELETE FROM animals
WHERE date_of_birth > '2022-01-01';
-- Create a savepoint for the transaction
SAVEPOINT del1;

-- Update all animals' weight to be their weight multiplied by -1
BEGIN;
UPDATE animals
SET weight_kg = weight_kg * (-1);
ROLLBACK TO SAVEPOINT del1;

-- Update all animals' weights that are negative to be their weight multiplied by -1
BEGIN;
UPDATE animals
SET weight_kg = weight_kg * (-1)
WHERE weight_kg < 0;
COMMIT;
SELECT * from animals;

-- Write queries to answer the questions
-- How many animals are there?
SELECT COUNT(*) FROM animals; //10

-- How many animals have never tried to escape?
SELECT COUNT(escape_attempts) FROM animals
WHERE escape_attempts = 0; //2

-- What is the average weight of animals?
SELECT AVG(weight_kg) FROM animals; //15.55...

-- Who escapes the most, neutered or not neutered animals?
SELECT neutered, AVG(escape_attempts) FROM animals
GROUP BY neutered;

-- What is the minimum and maximum weight of each type of animal?
SELECT species, MAX(weight_kg), MIN(weight_kg) FROM animals
GROUP BY species;

-- What is the average number of escape attempts per animal type of those born between 1990 and 2000?
SELECT species, AVG(escape_attempts) FROM animals
WHERE date_of_birth BETWEEN '1990-01-01' AND '2001-01-01'
GROUP BY species;

-- answer questions
-- What animals belong to Melody Pond?
SELECT name FROM animals
JOIN owners
ON animals.owner_id = owners.id
WHERE full_name = 'Melody Pond';

-- List of all animals that are pokemon (their type is Pokemon)
SELECT animals.name FROM animals
JOIN species
ON animals.species_id = species.id
WHERE species_id = 1

-- List all owners and their animals, remember to include those that don't own any animal
SELECT name, full_name FROM animals
RIGHT JOIN owners
ON animals.owner_id = owners.id

-- How many animals are there per species?
SELECT COUNT(*) FROM animals
JOIN species
ON animals.species_id = species.id 
GROUP BY species;

-- List all Digimon owned by Jennifer Orwell
SELECT name FROM animals
JOIN owners
ON animals.owner_id = owners.id 
WHERE full_name = 'Jennifer Orwell' AND species_id = 2;

-- List all animals owned by Dean Winchester that haven't tried to escape
SELECT name FROM animals
JOIN owners
ON animals.owner_id = owners.id 
WHERE full_name = 'Dean Winchester' AND escape_attempts = 0;

-- Who owns the most animals?
SELECT COUNT(*) FROM animals
JOIN owners
ON animals.owner_id = owners.id 
GROUP BY owners.full_name;