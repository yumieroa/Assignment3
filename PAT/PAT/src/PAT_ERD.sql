/*
Created: 4/22/2017
Modified: 5/7/2017
Model: PostgreSQL 9.2
Database: PostgreSQL 9.2
*/


-- Table parent_info

CREATE TABLE "parent_info"(
 "parent_id" Varchar NOT NULL,
 "first_name" Varchar,
 "last_name" Varchar,
 "birthdate" Date,
 "age" Bigint,
 "address" Varchar,
 "relationship" Varchar,
 "acc_id" Varchar NOT NULL
)
;

-- Add keys for table parent_info

ALTER TABLE "parent_info" ADD CONSTRAINT "Key1" PRIMARY KEY ("parent_id","acc_id")
;

-- Table child_info

CREATE TABLE "child_info"(
 "child_id" Varchar NOT NULL,
 "first_name" Varchar,
 "last_name" Varchar,
 "birthdate" Date,
 "age" Bigint,
 "address" Varchar,
 "disorder" Varchar,
 "parent_id" Varchar NOT NULL,
 "acc_id" Varchar
)
;

-- Create indexes for table child_info

CREATE INDEX "IX_Relationship1" ON "child_info" ("parent_id","acc_id")
;

-- Add keys for table child_info

ALTER TABLE "child_info" ADD CONSTRAINT "Key2" PRIMARY KEY ("child_id")
;

-- Table main_categories

CREATE TABLE "main_categories"(
 "category_id" Varchar NOT NULL,
 "category_name" Varchar,
 "child_id" Varchar NOT NULL
)
;

-- Add keys for table main_categories

ALTER TABLE "main_categories" ADD CONSTRAINT "Key3" PRIMARY KEY ("category_id","child_id")
;

-- Table sub_categories

CREATE TABLE "sub_categories"(
 "sub_id" Varchar NOT NULL,
 "name" Varchar,
 "tapped" Boolean,
 "category_id" Varchar NOT NULL,
 "child_id" Varchar NOT NULL
)
;

-- Add keys for table sub_categories

ALTER TABLE "sub_categories" ADD CONSTRAINT "Key4" PRIMARY KEY ("sub_id","category_id","child_id")
;

-- Table food

CREATE TABLE "food"(
 "name" Varchar,
 "category_id" Varchar NOT NULL,
 "child_id" Varchar NOT NULL
)
;

-- Add keys for table food

ALTER TABLE "food" ADD CONSTRAINT "Key5" PRIMARY KEY ("category_id","child_id")
;

-- Table sub_food

CREATE TABLE "sub_food"(
 "food_id" Varchar NOT NULL,
 "sub_name" Varchar,
 "tapped" Boolean,
 "category_id" Varchar NOT NULL,
 "child_id" Varchar NOT NULL
)
;

-- Add keys for table sub_food

ALTER TABLE "sub_food" ADD CONSTRAINT "Key6" PRIMARY KEY ("food_id","category_id","child_id")
;

-- Table act_records

CREATE TABLE "act_records"(
 "record_id" Varchar NOT NULL,
 "date" Date,
 "time" Time,
 "sub_id" Varchar NOT NULL,
 "category_id" Varchar NOT NULL,
 "child_id" Varchar NOT NULL,
 "parent_id" Varchar NOT NULL,
 "acc_id" Varchar NOT NULL
)
;

-- Add keys for table act_records

ALTER TABLE "act_records" ADD CONSTRAINT "Key7" PRIMARY KEY ("record_id","sub_id","category_id","child_id","parent_id","acc_id")
;

-- Table nutritional_value

CREATE TABLE "nutritional_value"(
 "nut_id" Varchar NOT NULL,
 "casein" Varchar,
 "gluten" Varchar,
 "vit_c" Varchar,
 "vit_d" Varchar,
 "protein" Varchar,
 "calories" Varchar,
 "food_id" Varchar NOT NULL,
 "category_id" Varchar NOT NULL,
 "child_id" Varchar NOT NULL
)
;

-- Add keys for table nutritional_value

ALTER TABLE "nutritional_value" ADD CONSTRAINT "Key8" PRIMARY KEY ("nut_id","food_id","category_id","child_id")
;

-- Table food_record

CREATE TABLE "food_record"(
 "record_id" Varchar NOT NULL,
 "date" Date,
 "time" Time,
 "nut_id" Varchar NOT NULL,
 "food_id" Varchar NOT NULL,
 "category_id" Varchar NOT NULL,
 "child_id" Varchar NOT NULL,
 "parent_id" Varchar NOT NULL,
 "acc_id" Varchar NOT NULL
)
;

-- Add keys for table food_record

ALTER TABLE "food_record" ADD CONSTRAINT "Key9" PRIMARY KEY ("record_id","nut_id","food_id","category_id","child_id","parent_id","acc_id")
;

-- Table account

CREATE TABLE "account"(
 "acc_id" Varchar NOT NULL,
 "username" Varchar,
 "email" Varchar,
 "password" Varchar
)
;

-- Add keys for table account

ALTER TABLE "account" ADD CONSTRAINT "Key10" PRIMARY KEY ("acc_id")
;

-- Create relationships section -------------------------------------------------

ALTER TABLE "child_info" ADD CONSTRAINT "creates account for" FOREIGN KEY ("parent_id", "acc_id") REFERENCES "parent_info" ("parent_id", "acc_id") ON DELETE NO ACTION ON UPDATE NO ACTION
;

ALTER TABLE "main_categories" ADD CONSTRAINT "interested in" FOREIGN KEY ("child_id") REFERENCES "child_info" ("child_id") ON DELETE NO ACTION ON UPDATE NO ACTION
;

ALTER TABLE "sub_categories" ADD CONSTRAINT "contains" FOREIGN KEY ("category_id", "child_id") REFERENCES "main_categories" ("category_id", "child_id") ON DELETE NO ACTION ON UPDATE NO ACTION
;

ALTER TABLE "food" ADD CONSTRAINT "has" FOREIGN KEY ("category_id", "child_id") REFERENCES "main_categories" ("category_id", "child_id") ON DELETE NO ACTION ON UPDATE NO ACTION
;

ALTER TABLE "sub_food" ADD CONSTRAINT "contains" FOREIGN KEY ("category_id", "child_id") REFERENCES "food" ("category_id", "child_id") ON DELETE NO ACTION ON UPDATE NO ACTION
;

ALTER TABLE "act_records" ADD CONSTRAINT "recorded to" FOREIGN KEY ("sub_id", "category_id", "child_id") REFERENCES "sub_categories" ("sub_id", "category_id", "child_id") ON DELETE NO ACTION ON UPDATE NO ACTION
;

ALTER TABLE "act_records" ADD CONSTRAINT "has access to" FOREIGN KEY ("parent_id", "acc_id") REFERENCES "parent_info" ("parent_id", "acc_id") ON DELETE NO ACTION ON UPDATE NO ACTION
;

ALTER TABLE "nutritional_value" ADD CONSTRAINT "has" FOREIGN KEY ("food_id", "category_id", "child_id") REFERENCES "sub_food" ("food_id", "category_id", "child_id") ON DELETE NO ACTION ON UPDATE NO ACTION
;

ALTER TABLE "food_record" ADD CONSTRAINT "recorded to" FOREIGN KEY ("nut_id", "food_id", "category_id", "child_id") REFERENCES "nutritional_value" ("nut_id", "food_id", "category_id", "child_id") ON DELETE NO ACTION ON UPDATE NO ACTION
;

ALTER TABLE "food_record" ADD CONSTRAINT "has access to" FOREIGN KEY ("parent_id", "acc_id") REFERENCES "parent_info" ("parent_id", "acc_id") ON DELETE NO ACTION ON UPDATE NO ACTION
;

ALTER TABLE "parent_info" ADD CONSTRAINT "Relationship1" FOREIGN KEY ("acc_id") REFERENCES "account" ("acc_id") ON DELETE NO ACTION ON UPDATE NO ACTION
;




--STORED PROCEDURES--

--create new account--
create or replace function newaccount(par_acc_id Varchar, par_username Varchar, par_email Varchar, par_password Varchar) returns text as
$$
  declare
    loc_id text;
    loc_res text;
  begin
     select into loc_id acc_id from account where acc_id = par_acc_id;
     if loc_id isnull then

       insert into account (acc_id, email, username, password) values (par_acc_id, par_email, par_username, par_password);
       loc_res = 'OK';

     else
       loc_res = 'ID EXIST';
     end if;
     return loc_res;
  end;
$$
 language 'plpgsql';
--select newaccount('abc123', 'lemniscates', 'yeah12345');

--supply parent info--
create or replace function newparent(par_parent_id Varchar,
  par_first_name Varchar,
  par_last_name Varchar,
  par_birthdate Date,
  par_age Bigint,
  par_address Varchar,
  par_relationship Varchar) returns text as
$$
  declare
    loc_id text;
    loc_res text;
  begin
     select into loc_id parent_id from parent_info where parent_id = par_parent_id;
     if loc_id isnull then

       insert into parent_info (parent_id, first_name, last_name, birthdate, age, address, relationship) values (par_parent_id, par_first_name, par_last_name, par_birthdate, par_age, par_address, par_relationship);
       loc_res = 'OK';

     else
       loc_res = 'ID EXIST';
     end if;
     return loc_res;
  end;
$$
 language 'plpgsql';
--select newaccount('abc123', 'lemniscates', 'yeah12345');


--supply info for child--
create or replace function newchild(par_child_id Varchar,
  par_first_name Varchar,
  par_last_name Varchar,
  par_birthdate Date,
  par_age Bigint,
  par_address Varchar,
  par_disorder Varchar) returns text as
$$
  declare
    loc_id text;
    loc_res text;
  begin
     select into loc_id child_id from child_info where child_id = par_child_id
      and child_id = par_child_id;
     if loc_id isnull then

       insert into child_info (child_id, first_name, last_name, birthdate, age, address, disorder) values (par_child_id, par_first_name, par_last_name, par_birthdate, par_age, par_address, par_disorder);
       loc_res = 'OK';

     else
       loc_res = 'ID EXIST';
     end if;
     return loc_res;
  end;
$$
 language 'plpgsql';
--select newaccount('abc123', 'lemniscates', 'yeah12345');

--log in--
create or replace function login(in par_email  text, in par_password text) returns text as
$$
  declare
    loc_eml text;
    loc_pwd text;
    loc_res text;
  begin
     select into loc_eml, email, loc_pwd, password from account
       where email = par_email and password = par_password;

     if loc_eml isnull AND loc_pwd isnull then
       loc_res = 'Error';
     else
       loc_res = 'ok';
     end if;
     return loc_res;
  end;
$$
 language 'plpgsql' VOLATILE;

--accounts available--

insert into account values ('2017-0001', 'eloisaroa', 'eloisacroa@yahoo.com', 'helloworld');

--get password--

create or replace function getpassword(par_email text) returns text as
$$
  declare
    loc_password text;
  begin
     select into loc_password password from account where email = par_email;
     if loc_password isnull then
       loc_password = 'null';
     end if;
     return loc_password;
 end;
$$
 language 'plpgsql';

select getpassword('helloworld');

--uploading--
create or replace function upload(in par_foodname  text) returns text as
$$
  declare
    loc_fdnm text;
    loc_res text;
  begin
     select into loc_fdnm, food_name from food
       where food_name = par_foodname;

     if loc_fdnm isnull then
       loc_res = 'Error';
     else
       loc_res = 'ok';
     end if;
     return loc_res;
  end;
$$
 language 'plpgsql' VOLATILE;
