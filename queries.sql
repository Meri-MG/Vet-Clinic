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

-- Who was the last animal seen by William Tatcher?
SELECT animals.name, visits.date_of_visit FROM animals
JOIN visits
ON animals.id = visits.animals_id 
JOIN vets
ON vets.id = visits.vets_id
WHERE vets.id = 1
ORDER BY date_of_visit DESC
LIMIT 1
-- Blossom

-- How many different animals did Stephanie Mendez see?
SELECT COUNT(DISTINCT animals.name) FROM animals
JOIN visits
ON animals.id = visits.animals_id 
JOIN vets
ON vets.id = visits.vets_id
WHERE vets.id = 3;
-- 4

-- List all vets and their specialties, including vets with no specialties.
SELECT vets.name, species.name FROM vets
JOIN specializations
ON vets.id = specializations.vets_id
JOIN species
ON specializations.species_id = species.id;

-- List all animals that visited Stephanie Mendez between April 1st and August 30th, 2020.
SELECT animals.name FROM animals
JOIN visits
ON animals.id = visits.animals_id
JOIN vets
ON vets.id = visits.vets_id
WHERE vets.id = 3 AND visits.date_of_visit >='2020-04-04' AND visits.date_of_visit <='2020-08-30';
-- Agumon, Gabumon, Blossom

-- What animal has the most visits to vets?
SELECT COUNT(*) FROM visits
JOIN animals
ON animals.id = visits.animals_id
GROUP BY animals.name;
-- Pikachu and Angemon

-- Who was Maisy Smith's first visit?
SELECT animals.name FROM animals
JOIN visits
ON animals.id = visits.animals_id
JOIN vets 
ON vets.id = visits.vets_id
WHERE vets.id = 2
ORDER BY visits.date_of_visit
LIMIT 1;
-- Boarmon

-- Details for most recent visit: animal information, vet information, and date of visit.
SELECT * FROM animals
JOIN visits
ON animals.id = visits.animals_id
FULL JOIN vets 
ON vets.id = visits.vets_id
WHERE vets.id = 2
ORDER BY visits.date_of_visit DESC
LIMIT 1;

-- How many visits were with a vet that did not specialize in that animal's species?
SELECT COUNT(*) FROM visits
JOIN vets
ON vets.id = visits.vets_id
WHERE vets.id = 2
--6

-- What specialty should Maisy Smith consider getting? Look for the species she gets the most.
SELECT species.name, COUNT(visits.animals_id) FROM visits
JOIN vets
ON visits.vets_id = vets.id
FULL JOIN animals
ON visits.animals_id = animals.id
JOIN species 
ON species.id = animals.species_id
WHERE vets.id = 2
GROUP BY species.name;
-- Digimon
