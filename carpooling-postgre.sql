CREATE TABLE _user_ (
   id_user SERIAL PRIMARY KEY,
   first_name VARCHAR(100) NOT NULL,
   last_name VARCHAR(100) NOT NULL,
   mail VARCHAR(500) NOT NULL,
   status BOOLEAN,
   password VARCHAR(50) NOT NULL,
   profil_picture VARCHAR(4000),
   notif_mail BOOLEAN NOT NULL,
   phone_notif BOOLEAN NOT NULL,
   application_notif BOOLEAN NOT NULL
);

CREATE TABLE student (
   id_student SERIAL PRIMARY KEY,
   trainning_name VARCHAR(1000) NOT NULL,
   start_date DATE,
   end_date DATE,
   id_user INT NOT NULL,
   UNIQUE(id_user),
   FOREIGN KEY(id_user) REFERENCES _user_(id_user)
);

CREATE TABLE trainning (
   id_trainning SERIAL PRIMARY KEY,
   name VARCHAR(100) NOT NULL,
   start_date DATE NOT NULL,
   end_date DATE NOT NULL
);

CREATE TABLE training_center (
   id_training_center SERIAL PRIMARY KEY,
   opening_time TIME NOT NULL,
   adress_center VARCHAR(50) NOT NULL,
   closing_time TIME NOT NULL,
   center_name VARCHAR(2000) NOT NULL
);

CREATE TABLE role (
   id_role SERIAL PRIMARY KEY,
   _name_ VARCHAR(50) NOT NULL,
   user_type BOOLEAN NOT NULL
);

CREATE TYPE fuel_type AS ENUM('ESSENCE', 'GAZOLE', 'SUPERETHANOL', 'GPL', 'ELECTRIQUE');

CREATE TABLE fuel (
   id_fuel SERIAL PRIMARY KEY,
   "type" fuel_type NOT NULL,
   price DECIMAL(10,2)
);

CREATE TYPE vehicle_category AS ENUM('COMPACT', 'BERLINE', 'BREAK', '4x4', 'MONOSPACE', 'UTILITAIRE');

CREATE TABLE vehicle_type (
   id_vehicle_type SERIAL PRIMARY KEY,
   "type" vehicle_category NOT NULL
);

CREATE TABLE cosumtion_estimation (
   id_cosumtion_estimation SERIAL PRIMARY KEY,
   consum_value DECIMAL(15,2) NOT NULL,
   Id_vehicle_type INT NOT NULL,
   id_fuel INT NOT NULL,
   FOREIGN KEY(Id_vehicle_type) REFERENCES vehicle_type(Id_vehicle_type),
   FOREIGN KEY(id_fuel) REFERENCES fuel(id_fuel)
);

CREATE TABLE condition_user (
   Id_condition_user SERIAL PRIMARY KEY,
   text VARCHAR(8000)
);

CREATE TABLE employee (
   id_employee SERIAL PRIMARY KEY,
   is_admin BOOLEAN NOT NULL,
   condition_use VARCHAR(5000),
   contract_duration INT NOT NULL,
   id_role INT NOT NULL,
   id_user INT NOT NULL,
   UNIQUE(id_user),
   FOREIGN KEY(id_role) REFERENCES role(id_role),
   FOREIGN KEY(id_user) REFERENCES _user_(id_user)
);

CREATE TABLE vehicle (
   id_vehicle SERIAL PRIMARY KEY,
   model VARCHAR(50) NOT NULL,
   place_number INT DEFAULT 4 NOT NULL,
   Id_cosumtion_estimation INT NOT NULL,
   Id_vehicle_type INT NOT NULL,
   FOREIGN KEY(Id_cosumtion_estimation) REFERENCES cosumtion_estimation(Id_cosumtion_estimation),
   FOREIGN KEY(Id_vehicle_type) REFERENCES vehicle_type(Id_vehicle_type)
);

CREATE TABLE trip (
   id_trip SERIAL PRIMARY KEY,
   "type" VARCHAR(50) NOT NULL,
   start_adress VARCHAR(50) NOT NULL,
   hour_start TIME NOT NULL,
   end_adress VARCHAR(1000) NOT NULL,
   price DECIMAL(15,2) NOT NULL,
   comment VARCHAR(50),
   id_user INT NOT NULL,
   Id_training_center INT NOT NULL,
   FOREIGN KEY(id_user) REFERENCES _user_(id_user),
   FOREIGN KEY(Id_training_center) REFERENCES training_center(Id_training_center)
);

CREATE TABLE regular (
   id_regular SERIAL PRIMARY KEY,
   start_date DATE NOT NULL,
   end_date DATE,
   day_trip VARCHAR(50) NOT NULL,
   descriptif VARCHAR(4000),
   Id_trip INT NOT NULL,
   UNIQUE(Id_trip),
   FOREIGN KEY(Id_trip) REFERENCES trip(Id_trip)
);

CREATE TABLE punctual (
   id_punctual SERIAL PRIMARY KEY,
   _day_ VARCHAR(50) NOT NULL,
   Id_trip INT NOT NULL,
   UNIQUE(Id_trip),
   FOREIGN KEY(Id_trip) REFERENCES trip(Id_trip)
);

CREATE TABLE comment (
   Id_comment SERIAL PRIMARY KEY,
   text_comment VARCHAR(50),
   id_user INT NOT NULL,
   Id_trip INT NOT NULL,
   FOREIGN KEY(id_user) REFERENCES _user_(id_user),
   FOREIGN KEY(Id_trip) REFERENCES trip(Id_trip)
);

CREATE TABLE trainer (
   id_trainer SERIAL PRIMARY KEY,
   referent BOOLEAN NOT NULL,
   id_employee INT NOT NULL,
   UNIQUE(id_employee),
   FOREIGN KEY(id_employee) REFERENCES employee(id_employee)
);

CREATE TABLE notif (
   id_notif SERIAL PRIMARY KEY,
   referent_message VARCHAR(50) NOT NULL,
   phone_number VARCHAR(50) NOT NULL,
   Id_trip INT NOT NULL,
   FOREIGN KEY(Id_trip) REFERENCES trip(Id_trip)
);

CREATE TABLE taiks (
   id_student INT,
   id_trainning INT,
   PRIMARY KEY(id_student, id_trainning),
   FOREIGN KEY(id_student) REFERENCES student(id_student),
   FOREIGN KEY(id_trainning) REFERENCES trainning(id_trainning)
);

CREATE TABLE supervise (
   id_trainer INT,
   id_trainning INT,
   refere BOOLEAN NOT NULL,
   add_formation VARCHAR(50),
   PRIMARY KEY(id_trainer, id_trainning),
   FOREIGN KEY(id_trainer) REFERENCES trainer(id_trainer),
   FOREIGN KEY(id_trainning) REFERENCES trainning(id_trainning)
);

CREATE TYPE notification_type AS ENUM('APPLICATION', 'EMAIL', 'SMS');

CREATE TABLE receives (
   id_user INT,
   id_notif INT,
   "type" notification_type NOT NULL,
   PRIMARY KEY(id_user, id_notif),
   FOREIGN KEY(id_user) REFERENCES _user_(id_user),
   FOREIGN KEY(id_notif) REFERENCES notif(id_notif)
);

CREATE TABLE _order_ (
   id_vehicle INT,
   Id_trip INT,
   PRIMARY KEY(id_vehicle, Id_trip),
   FOREIGN KEY(id_vehicle) REFERENCES vehicle(id_vehicle),
   FOREIGN KEY(Id_trip) REFERENCES trip(Id_trip)
);

CREATE TABLE _using (
   id_user INT,
   id_vehicle INT,
   PRIMARY KEY(id_user, id_vehicle),
   FOREIGN KEY(id_user) REFERENCES _user_(id_user),
   FOREIGN KEY(id_vehicle) REFERENCES vehicle(id_vehicle)
);

CREATE TABLE reservation (
   id_user INT,
   Id_trip INT,
   validate_trip BOOLEAN NOT NULL,
   PRIMARY KEY(id_user, Id_trip),
   FOREIGN KEY(id_user) REFERENCES _user_(id_user),
   FOREIGN KEY(Id_trip) REFERENCES trip(Id_trip)
);
