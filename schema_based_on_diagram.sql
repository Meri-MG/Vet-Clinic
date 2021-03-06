-- CREATE DATABASE ACCORDING DIAGRAM

CREATE TABLE patients (
  id SERIAL PRIMARY KEY,
  name VARCHAR(100),
  date_of_birth date
)

CREATE TABLE medical_histories (
  id SERIAL PRIMARY KEY,
  admitted_at timestamp,
  patient_id integer NOT NULL,
  status VARCHAR(100),
  FOREIGN KEY (patient_id) REFERENCES patients (id) ON DELETE RESTRICT ON UPDATE CASCADE
)

CREATE TABLE treatments (
  id SERIAL PRIMARY KEY,
  type VARCHAR(100),
  name VARCHAR(100)
)

CREATE TABLE invoices (
  id SERIAL PRIMARY KEY,
  total_amount decimal,
  generated_at timestamp,
  payed_at timestamp,
  medical_history_id integer NOT NULL,
  FOREIGN KEY (medical_history_id) REFERENCES medical_histories (id) ON DELETE RESTRICT ON UPDATE CASCADE
)

CREATE TABLE invoice_items (
  id SERIAL PRIMARY KEY,
  unit_price decimal,
  quantity integer,
  total_price decimal,
  invoice_id integer NOT NULL,
  treatment_id integer NOT NULL,
  FOREIGN KEY (invoice_id) REFERENCES invoices (id) ON DELETE RESTRICT ON UPDATE CASCADE,
  FOREIGN KEY (treatment_id) REFERENCES treatments (id) ON DELETE RESTRICT ON UPDATE CASCADE
)

CREATE TABLE medical_histories_and_treatments (
  medical_history_id integer NOT NULL,
	treatment_id integer NOT NULL,
	FOREIGN KEY (medical_history_id) REFERENCES medical_histories (id) ON DELETE RESTRICT ON UPDATE CASCADE,
	FOREIGN KEY (treatment_id) REFERENCES treatments (id) ON DELETE RESTRICT ON UPDATE CASCADE
)

-- CREATE FK indexes
CREATE INDEX medical_histories_patient_index ON medical_histories(patient_id);
CREATE INDEX invoices_medical_history_index ON invoices (medical_history_id);
CREATE INDEX invoice_items_invoice_index ON invoice_items (invoice_id);
CREATE INDEX invoice_items_treatment_index ON invoice_items (treatment_id);
CREATE INDEX medical_hist_and_treat_medical_history_index ON medical_histories_and_treatments (medical_history_id);
CREATE INDEX medical_hist_and_treat_treatment_index ON medical_histories_and_treatments (treatment_id);

