CREATE TABLE animals (
    id integer PRIMARY KEY,
    name varchar(100),
    date_of_birth date,
    escape_attempts integer,
    neutered boolean,
    weight_kg decimal
);

ALTER TABLE animals
ADD COLUMN species VARCHAR(100);

CREATE TABLE owners (
    id SERIAL PRIMARY KEY,
    full_name VARCHAR(100),
	age INTEGER
);

CREATE TABLE species (
    id SERIAL PRIMARY KEY,
    name VARCHAR(50)
);

-- Make sure that id is set as autoincremented PRIMARY KEY
CREATE SEQUENCE my_serial AS integer START 1 OWNED BY animals.id;

ALTER TABLE animals ALTER COLUMN id SET DEFAULT nextval('my_serial');

-- Remove column species
ALTER TABLE animals
DROP COLUMN species

-- Add column species_id which is a foreign key referencing species table
ALTER TABLE animals 
ADD COLUMN species_id integer REFERENCES species(id)

-- Add column owner_id which is a foreign key referencing the owners table
ALTER TABLE animals 
ADD COLUMN owner_id integer REFERENCES owners(id)
