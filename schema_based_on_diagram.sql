create database clinic-database;
create table medical_histories (
    id serial primary key not null,
    admitted_at timestamp,
    patient_id int,
    status varchar(50),
    constraint fk_patient foreign key(patient_id) references patients(id)
);

create table patients (
    id serial primary key not null,
    name varchar(80),
    date_of_birth date
);

-----Create table named invoices----
CREATE TABLE invoices (
    id INT PRIMARY KEY GENERATED ALWAYS AS IDENTITY,
    total_amount decimal,
    generated_at timestamp,
    payed_at timestamp,
    medical_histories_id INT,
    FOREIGN KEY (medical_histories_id) REFERENCES medical_histories(id)
    ON UPDATE CASCADE
);

----Create table named invoices_items-----
CREATE TABLE invoices_items(
    id INT PRIMARY KEY ALWAYS GENERATED AS IDENTITY,
    unit_price decimal,
    quantity INT,
    total_price decimal,
    invoice_id INT,
    treatment_id INT,
    FOREIGN KEY (invoice_id) REFERENCES invoice(id)
    ON UPDATE CASCADE,
    FOREIGN KEY (treatment_id) REFERENCES treatments(id)
    ON UPDATE CASCADE
);


--Create treatment table
CREATE TABLE treatments(
    id INT PRIMARY KEY ALWAYS GENERATED AS IDENTITY NOT NULL,
    type varchar,
    name varchar
);

--Many to many relationship between medical_histories and treatments
CREATE TABLE medical_histories_treatments (
    id INT PRIMARY KEY ALWAYS GENERATED AS IDENTITY NOT NULL,
    medical_histories_id int,
    treatment_id int,
    FOREIGN KEY (medical_histories_id) REFERENCES medical_histories(id) ON UPDATE CASCADE,
    FOREIGN KEY (treatment_id) REFERENCES treatments(id) ON UPDATE CASCADE
);

CREATE INDEX ON medical_histories (patient_id);
CREATE INDEX ON invoices (medical_histories_id);
CREATE INDEX ON invoices_items (invoice_id);
CREATE INDEX ON invoices_items (treatment_id);
CREATE INDEX ON medical_histories_treatments (medical_histories_id);
CREATE INDEX ON medical_histories_treatments (treatment_id);

/*

-- add index to the patients table
CREATE INDEX patient_name_asc ON patients(name ASC);

OR

CREATE INDEX patient_name_id_index ON visits(name_id); 
*/

