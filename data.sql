-- insert Data into Animals table
INSERT INTO animals(id, name, date_of_birth, escape_attempts, neutered, weight_kg)
VALUES (1, 'Agumon', '2020-02-03', 0, true, 10.23);

INSERT INTO animals(id, name, date_of_birth, escape_attempts, neutered, weight_kg)
VALUES (2, 'Gabumon', '2018-11-15', 2, true, 8);

INSERT INTO animals(id, name, date_of_birth, escape_attempts, neutered, weight_kg)
VALUES (3, 'Pikachu', '2021-01-07', 1, false, 15.04);

INSERT INTO animals(id, name, date_of_birth, escape_attempts, neutered, weight_kg)
VALUES (4, 'Devimon', '2017-05-14', 5, true, 11);

INSERT INTO animals(id, name, date_of_birth, escape_attempts, neutered, weight_kg)
VALUES (5, 'Charmander', '2020-02-8', 0, false, -11);

INSERT INTO animals(id, name, date_of_birth, escape_attempts, neutered, weight_kg)
VALUES (6, 'Plantmon', '2022-11-15', 2, true, -5.7);

INSERT INTO animals(id, name, date_of_birth, escape_attempts, neutered, weight_kg)
VALUES (7, 'Squirtle', '1993-04-02', 3, false, -12.13);

INSERT INTO animals(id, name, date_of_birth, escape_attempts, neutered, weight_kg)
VALUES (8, 'Angemon', '2005-06-12', 1, true, -45);

INSERT INTO animals(id, name, date_of_birth, escape_attempts, neutered, weight_kg)
VALUES (9, 'Boarmon', '2005-06-07', 7, true, 20.4);

INSERT INTO animals(id, name, date_of_birth, escape_attempts, neutered, weight_kg)
VALUES (10, 'Blossom', '1998-02-13', 3, true, 17);

-- insert Data into Owners table
INSERT INTO owners(full_name, age)
VALUES ('Sam Smith', 34);

INSERT INTO owners(full_name, age)
VALUES ('Jennifer Orwell', 19);

INSERT INTO owners(full_name, age)
VALUES ('Bob', 45);

INSERT INTO owners(full_name, age)
VALUES ('Melody Pond', 77);

INSERT INTO owners(full_name, age)
VALUES ('Dean Winchester', 14);

INSERT INTO owners(full_name, age)
VALUES ('Jodie Whittaker', 38);

-- insert Data into Species table
INSERT INTO species(name)
VALUES ('Pokemon');

INSERT INTO species(name)
VALUES ('Digimon');

-- Modify inserted animals for species_id column
UPDATE animals
SET species_id = 2
WHERE name LIKE '%mon';

UPDATE animals
SET species_id = 1
WHERE name NOT LIKE '%mon';

-- Modify inserted animals for owner_id column
UPDATE animals
SET owner_id = 1
WHERE name = 'Agumon';

UPDATE animals
SET owner_id = 2
WHERE name IN ('Pikachu', 'Gabumon');

UPDATE animals
SET owner_id = 3
WHERE name IN ('Devimon', 'Plantmon');

UPDATE animals
SET owner_id = 4
WHERE name IN ('Charmander', 'Squirtle', 'Blossom');

UPDATE animals
SET owner_id = 5
WHERE name IN ('Angemon', 'Boarmon');
