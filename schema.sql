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

-- Create a table named vets with the following columns:
CREATE TABLE vets(
  id SERIAL PRIMARY KEY,
  name VARCHAR(100),
  age INTEGER,
  date_of_graduation date
)

-- There is a many-to-many relationship between the tables species and vets: 
-- a vet can specialize in multiple species, and a species can have multiple 
-- vets specialized in it. Create a "join table" called specializations to handle this relationship.
CREATE TABLE specializations(
  vets_id integer NOT NULL,
  species_id integer NOT NULL,
  FOREIGN KEY (vets_id) REFERENCES vets (id) ON DELETE RESTRICT ON UPDATE CASCADE,
  FOREIGN KEY (species_id) REFERENCES species (id) ON DELETE RESTRICT ON UPDATE CASCADE,
)

-- There is a many-to-many relationship between the tables animals and vets: 
-- an animal can visit multiple vets and one vet can be visited by multiple animals. 
-- Create a "join table" called visits to handle this relationship, it should also keep track of the date of the visit.
CREATE TABLE visits(
  vets_id integer NOT NULL,
  animals_id integer NOT NULL,
  date_of_visit date,
  FOREIGN KEY (vets_id) REFERENCES vets (id) ON DELETE RESTRICT ON UPDATE CASCADE,
  FOREIGN KEY (animals_id) REFERENCES animals (id) ON DELETE RESTRICT ON UPDATE CASCADE,
)