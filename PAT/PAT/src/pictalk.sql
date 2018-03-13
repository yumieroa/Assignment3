--account table
CREATE TABLE "account"(
"acc_num" text NOT NULL,
"email" text,
"username" text,
"password" text
);

--category table
CREATE TABLE "category"(
"cat_num" text NOT NULL,
"cat_name" text
);

--child info table
CREATE TABLE "child_info"(
"child_num" text NOT NULL,
"first_name" text,
"last_name" text,
"birthdate" date,
"age" bigint,
"diagnosis" text
);

--food table
CREATE TABLE "food"(
"food_num" text NOT NULL,
"food_name" text
);

CREATE TABLE "toys"(
"toy_num" text NOT NULL,
"toy_name" text
);

--parent info table
CREATE TABLE "parent_info"(
"parent_num" text NOT NULL,
"first_name" text,
"last_name" text,
"birthdate" date,
"age" bigint
);



--stored procedures
--registration
-- create or REPLACE function registration(in par_username text,in par_email text, in par_password text, par_repeat text) RETURNS Text AS
-- 	$$
-- 	DECLARE
--     loc_repeat text;
--     loc_email    text;
-- 		loc_username text;
-- 		loc_password text;
--     loc_res      text;
--     begin
-- 			SELECT into loc_username "username", loc_email "email", loc_password "password" from account ;
-- 			if loc_username notnull and loc_password notnull THEN
--         loc_res =  loc_username;
--
--         insert into account (username,password,email) values (par_username,par_password,par_email);
-- 			else
-- 					loc_res =  'Error';
-- 			end if;
-- 			return loc_res;
-- 	END;
--
-- 	$$
-- 	LANGUAGE 'plpgsql' VOLATILE;
-- select registration('yumie','yumielouise@gmail.com','wassup','wassup');

--login
create function login(par_email text, par_password text) returns text
LANGUAGE plpgsql
AS $$
declare
    loc_eml text;
    loc_pwd text;
    loc_res text;
  begin
     select into loc_eml account.email from account
       where account.email = par_email and account.password = par_password;

     if loc_eml isnull then
       loc_res = 'Error';
     else
       loc_res = 'ok';
     end if;
     return loc_res;
  end;
$$;

--get password
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

--edit child info
-- create or replace function edit_child(par_childnum text, par_efirstc text, par_elastc text, par_ebirthc date, par_eagec bigint, par_edisorderc text) returns TABLE(first_name text, last_name text, birthdate date, age bigint, diagnosis text) as
-- $$
--   BEGIN
-- 			  update child_info set child_num = par_childnum, first_name = par_efirstc, last_name = par_elastc, birthdate = par_ebirthc, age = par_eagec, diagnosis = par_edisorderc
--         where child_info.child_num = par_childnum;
--
--          RETURN query select child_info.first_name, child_info.last_name, child_info.birthdate, child_info.age, child_info.diagnosis from child_info WHERE child_info.first_name = par_efirstc;
--   END
--  $$
--   LANGUAGE 'plpgsql' VOLATILE ;


create or replace function edit_child( in par_efirstc text, in par_elastc text, in par_ebirthc text, in par_eagec text, in par_edisorderc text) returns text as
$$
  declare
    loc_res text;

    loc_efirstc text;
    loc_elastc text;
    loc_ebirthc text;
    loc_eagec text;
    loc_edisorderc text;
  begin
     select into loc_efirstc first_name, loc_elastc last_name, loc_ebirthc birthdate, loc_eagec age, loc_edisorderc diagnosis from child_info;
     if par_elastc NOTNULL then

       delete from child_info;
       insert into child_info ( first_name, last_name, birthdate, age, diagnosis) values (par_efirstc,par_elastc,par_ebirthc,par_eagec,par_edisorderc);
       loc_res = 'ok';

     else
       loc_res = 'Error';
     end if;
     return loc_res;
  end;
$$
 language 'plpgsql';


-- create or replace function edit_child(par_childnum text, par_efirstc text, par_elastc text, par_ebirthc date, par_eagec bigint, par_ediagnosisc text) returns TABLE(fname text, lname text, email text, username text, password text, bio text) as
-- $$
--   BEGIN
-- 			  Update child_info set first_name = par_efirstc, last_name = par_elastc, birthdate = par_ebirthc, age = par_eagec, diagnosis = par_ediagnosisc
--         where child_info.child_num = par_childnum and account.acc_num = child_info.child_num;
--
--          RETURN  query select child_info.first_name, child_info.last_name, child_info.birthdate, child_info.age, child_info.diagnosis from child_info WHERE child_info.child_num = par_childnum;
--   END
--  $$
--   LANGUAGE 'plpgsql' VOLATILE ;

--get new child info
create or replace function getinfo_child(out text, out TEXT,  out text, out text,  out text) returns setof record as
$$

  select first_name, last_name, birthdate, age, diagnosis from child_info;
$$
 language 'sql';


select getinfo_child('Lea Lorraine', 'Roa', 'June 5, 2004', '13', 'Autism');

--edit parent's info
create or replace function edit_parent( in par_efirstp text, in par_elastp text, in par_ebirthp date, in par_eagep bigint, in par_rltnshp text) returns text as
$$
  declare
    loc_res text;

    loc_efirstp text;
    loc_elastp text;
    loc_ebirthp text;
    loc_eagep text;
    loc_rlntshp text;
  begin
     select into loc_efirstp first_name, loc_elastp last_name, loc_ebirthp birthdate, loc_eagep age, loc_rlntshp relationship from parent_info;
     if par_elastp NOTNULL then

       delete from parent_info;
       insert into parent_info (first_name, last_name, birthdate, age, relationship) values (par_efirstp,par_elastp,par_ebirthp,par_eagep,par_rltnshp);
       loc_res = 'ok';

     else
       loc_res = 'Error';
     end if;
     return loc_res;
  end;
$$
 language 'plpgsql';


create or replace function getinfo_parent(out text, out TEXT,  out date, out bigint, out text) returns setof record as
$$
  select first_name, last_name, birthdate, age, relationship from parent_info;
$$
 language 'sql';

select getinfo_child();

--edit settings
create or replace function edit_settings (in par_email text, in par_username text, in par_password text) returns text as
$$
  declare
    loc_res text;

    loc_email text;
    loc_username text;
    loc_password text;
  begin
     select into loc_email email, loc_username username, loc_password password from account;
     if par_email NOTNULL then

       delete from account;
       insert into account ( email, username, password) values (par_email,par_username,par_password);
       loc_res = 'ok';

     else
       loc_res = 'Error';
     end if;
     return loc_res;
  end;
$$
 language 'plpgsql';


create or replace function new_settings(out text, out TEXT,  out text) returns setof record as
$$
  select email, username, password from account;
$$
 language 'sql';

--food record
create or replace function egg_clicks(in par_egg text) returns text as
$$
  declare
    loc_res text;
    loc_var int;

  begin
     if par_egg NOTNULL then
        UPDATE food set clicks = clicks+1 where food_id = 1;
        UPDATE FOOD set calories_total=  (cast( calories as INT) * cast ( clicks as int ) ) where food_id = 1;
        UPDATE FOOD set protein_total=  (cast( protein as INT) * cast ( clicks as int ) ) where food_id = 1;
        UPDATE FOOD set cholesterol_total=  (cast( cholesterol as INT) * cast ( clicks as int ) ) where food_id = 1;
         loc_res = 'ok';
      else
       loc_res = 'Error';
     end if;
     return loc_res;
  end;
$$
 language 'plpgsql';

create or replace function hotdog_clicks(in par_hotdog text) returns text as
$$
  declare
    loc_res text;

  begin
     if par_hotdog NOTNULL then
        UPDATE food set clicks = clicks+1 where food_id = 2;
        UPDATE FOOD set calories_total=  (cast( calories as INT) * cast ( clicks as int ) ) where food_id = 2;
        UPDATE FOOD set protein_total=  (cast( protein as INT) * cast ( clicks as int ) ) where food_id = 2;
        UPDATE FOOD set cholesterol_total=  (cast( cholesterol as INT) * cast ( clicks as int ) ) where food_id = 2;
         loc_res = 'ok';
      else
       loc_res = 'Error';
     end if;
     return loc_res;
  end;
$$
 language 'plpgsql';

create or replace function pancakes_clicks(in par_pancakes text) returns text as
$$
  declare
    loc_res text;

  begin
     if par_pancakes NOTNULL then
        UPDATE food set clicks = clicks+1 where food_id = 3;
        UPDATE FOOD set calories_total=  (cast( calories as INT) * cast ( clicks as int ) ) where food_id = 3;
        UPDATE FOOD set protein_total=  (cast( protein as INT) * cast ( clicks as int ) ) where food_id = 3;
        UPDATE FOOD set cholesterol_total=  (cast( cholesterol as INT) * cast ( clicks as int ) ) where food_id = 3;
         loc_res = 'ok';
      else
       loc_res = 'Error';
     end if;
     return loc_res;
  end;
$$
 language 'plpgsql';

create or replace function cookies_clicks(in par_cookies text) returns text as
$$
  declare
    loc_res text;

  begin
     if par_cookies NOTNULL then
        UPDATE food set clicks = clicks+1 where food_id = 4;
        UPDATE FOOD set calories_total=  (cast( calories as INT) * cast ( clicks as int ) ) where food_id = 4;
        UPDATE FOOD set protein_total=  (cast( protein as INT) * cast ( clicks as int ) ) where food_id = 4;
        UPDATE FOOD set cholesterol_total=  (cast( cholesterol as INT) * cast ( clicks as int ) ) where food_id = 4;
         loc_res = 'ok';
      else
       loc_res = 'Error';
     end if;
     return loc_res;
  end;
$$
 language 'plpgsql';

create or replace function chicken_clicks(in par_chicken text) returns text as
$$
  declare
    loc_res text;

  begin
     if par_chicken NOTNULL then
        UPDATE food set clicks = clicks+1 where food_id = 5;
        UPDATE FOOD set calories_total=  (cast( calories as INT) * cast ( clicks as int ) ) where food_id = 5;
        UPDATE FOOD set protein_total=  (cast( protein as INT) * cast ( clicks as int ) ) where food_id = 5;
        UPDATE FOOD set cholesterol_total=  (cast( cholesterol as INT) * cast ( clicks as int ) ) where food_id = 5;
         loc_res = 'ok';
      else
       loc_res = 'Error';
     end if;
     return loc_res;
  end;
$$
 language 'plpgsql';

create or replace function burger_clicks(in par_burger text) returns text as
$$
  declare
    loc_res text;

  begin
     if par_burger NOTNULL then
        UPDATE food set clicks = clicks+1 where food_id = 6;
        UPDATE FOOD set calories_total=  (cast( calories as INT) * cast ( clicks as int ) ) where food_id = 6;
        UPDATE FOOD set protein_total=  (cast( protein as INT) * cast ( clicks as int ) ) where food_id = 6;
        UPDATE FOOD set cholesterol_total=  (cast( cholesterol as INT) * cast ( clicks as int ) ) where food_id = 6;
         loc_res = 'ok';
      else
       loc_res = 'Error';
     end if;
     return loc_res;
  end;
$$
 language 'plpgsql';

create or replace function bbq_clicks(in par_bbq text) returns text as
$$
  declare
    loc_res text;

  begin
     if par_bbq NOTNULL then
        UPDATE food set clicks = clicks+1 where food_id = 7;
        UPDATE FOOD set calories_total=  (cast( calories as INT) * cast ( clicks as int ) ) where food_id = 7;
        UPDATE FOOD set protein_total=  (cast( protein as INT) * cast ( clicks as int ) ) where food_id = 7;
        UPDATE FOOD set cholesterol_total=  (cast( cholesterol as INT) * cast ( clicks as int ) ) where food_id = 7;
         loc_res = 'ok';
      else
       loc_res = 'Error';
     end if;
     return loc_res;
  end;
$$
 language 'plpgsql';

create or replace function fries_clicks(in par_fries text) returns text as
$$
  declare
    loc_res text;

  begin
     if par_fries NOTNULL then
        UPDATE food set clicks = clicks+1 where food_id = 8;
        UPDATE FOOD set calories_total=  (cast( calories as INT) * cast ( clicks as int ) ) where food_id = 8;
        UPDATE FOOD set protein_total=  (cast( protein as INT) * cast ( clicks as int ) ) where food_id = 8;
        UPDATE FOOD set cholesterol_total=  (cast( cholesterol as INT) * cast ( clicks as int ) ) where food_id = 8;
         loc_res = 'ok';
      else
       loc_res = 'Error';
     end if;
     return loc_res;
  end;
$$
 language 'plpgsql';

create or replace function marshmallow_clicks(in par_marshmallow text) returns text as
$$
  declare
    loc_res text;

  begin
     if par_marshmallow NOTNULL then
        UPDATE food set clicks = clicks+1 where food_id = 9;
        UPDATE FOOD set calories_total=  (cast( calories as INT) * cast ( clicks as int ) ) where food_id = 9;
        UPDATE FOOD set protein_total=  (cast( protein as INT) * cast ( clicks as int ) ) where food_id = 9;
        UPDATE FOOD set cholesterol_total=  (cast( cholesterol as INT) * cast ( clicks as int ) ) where food_id = 9;
         loc_res = 'ok';
      else
       loc_res = 'Error';
     end if;
     return loc_res;
  end;
$$
 language 'plpgsql';

create or replace function lollipop_clicks(in par_lollipop text) returns text as
$$
  declare
    loc_res text;

  begin
     if par_lollipop NOTNULL then
        UPDATE food set clicks = clicks+1 where food_id = 10;
        UPDATE FOOD set calories_total=  (cast( calories as INT) * cast ( clicks as int ) ) where food_id = 10;
        UPDATE FOOD set protein_total=  (cast( protein as INT) * cast ( clicks as int ) ) where food_id = 10;
        UPDATE FOOD set cholesterol_total=  (cast( cholesterol as INT) * cast ( clicks as int ) ) where food_id = 10;
         loc_res = 'ok';
      else
       loc_res = 'Error';
     end if;
     return loc_res;
  end;
$$
 language 'plpgsql';

create or replace function icecream_clicks(in par_icecream text) returns text as
$$
  declare
    loc_res text;

  begin
     if par_icecream NOTNULL then
        UPDATE food set clicks = clicks+1 where food_id = 11;
        UPDATE FOOD set calories_total=  (cast( calories as INT) * cast ( clicks as int ) ) where food_id = 11;
        UPDATE FOOD set protein_total=  (cast( protein as INT) * cast ( clicks as int ) ) where food_id = 11;
        UPDATE FOOD set cholesterol_total=  (cast( cholesterol as INT) * cast ( clicks as int ) ) where food_id = 11;
         loc_res = 'ok';
      else
       loc_res = 'Error';
     end if;
     return loc_res;
  end;
$$
 language 'plpgsql';

create or replace function halo_clicks(in par_halo text) returns text as
$$
  declare
    loc_res text;

  begin
     if par_halo NOTNULL then
        UPDATE food set clicks = clicks+1 where food_id = 12;
        UPDATE FOOD set calories_total=  (cast( calories as INT) * cast ( clicks as int ) ) where food_id = 12;
        UPDATE FOOD set protein_total=  (cast( protein as INT) * cast ( clicks as int ) ) where food_id = 12;
        UPDATE FOOD set cholesterol_total=  (cast( cholesterol as INT) * cast ( clicks as int ) ) where food_id = 12;
         loc_res = 'ok';
      else
       loc_res = 'Error';
     end if;
     return loc_res;
  end;
$$
 language 'plpgsql';

select egg_clicks('1');

CREATE SEQUENCE toy_id;
insert into clothes (cloth_name) values ('sweater');

--food record
create or replace function stack_clicks(in par_stack text) returns text as
$$
  declare
    loc_res text;

  begin
     if par_stack NOTNULL then
        UPDATE toys set clicks = clicks+1 where toy_id = 1;
         loc_res = 'ok';
      else
       loc_res = 'Error';
     end if;
     return loc_res;
  end;
$$
 language 'plpgsql';

create or replace function puzzle_clicks(in par_puzzle text) returns text as
$$
  declare
    loc_res text;

  begin
     if par_puzzle NOTNULL then
        UPDATE toys set clicks = clicks+1 where toy_id = 2;
         loc_res = 'ok';
      else
       loc_res = 'Error';
     end if;
     return loc_res;
  end;
$$
 language 'plpgsql';

create or replace function doodle_clicks(in par_doodle text) returns text as
$$
  declare
    loc_res text;

  begin
     if par_doodle NOTNULL then
        UPDATE toys set clicks = clicks+1 where toy_id = 3;
         loc_res = 'ok';
      else
       loc_res = 'Error';
     end if;
     return loc_res;
  end;
$$
 language 'plpgsql';

create or replace function rattle_clicks(in par_rattle text) returns text as
$$
  declare
    loc_res text;

  begin
     if par_rattle NOTNULL then
        UPDATE toys set clicks = clicks+1 where toy_id = 4;
         loc_res = 'ok';
      else
       loc_res = 'Error';
     end if;
     return loc_res;
  end;
$$
 language 'plpgsql';

create or replace function ball_clicks(in par_ball text) returns text as
$$
  declare
    loc_res text;

  begin
     if par_ball NOTNULL then
        UPDATE toys set clicks = clicks+1 where toy_id = 5;
         loc_res = 'ok';
      else
       loc_res = 'Error';
     end if;
     return loc_res;
  end;
$$
 language 'plpgsql';

create or replace function swing_clicks(in par_swing text) returns text as
$$
  declare
    loc_res text;

  begin
     if par_swing NOTNULL then
        UPDATE toys set clicks = clicks+1 where toy_id = 6;
         loc_res = 'ok';
      else
       loc_res = 'Error';
     end if;
     return loc_res;
  end;
$$
 language 'plpgsql';

create or replace function lego_clicks(in par_lego text) returns text as
$$
  declare
    loc_res text;

  begin
     if par_lego NOTNULL then
        UPDATE toys set clicks = clicks+1 where toy_id = 7;
         loc_res = 'ok';
      else
       loc_res = 'Error';
     end if;
     return loc_res;
  end;
$$
 language 'plpgsql';

create or replace function trampoline_clicks(in par_trmpln text) returns text as
$$
  declare
    loc_res text;

  begin
     if par_trmpln NOTNULL then
        UPDATE toys set clicks = clicks+1 where toy_id = 8;
         loc_res = 'ok';
      else
       loc_res = 'Error';
     end if;
     return loc_res;
  end;
$$
 language 'plpgsql';

create or replace function car_clicks(in par_car text) returns text as
$$
  declare
    loc_res text;

  begin
     if par_car NOTNULL then
        UPDATE toys set clicks = clicks+1 where toy_id = 9;
         loc_res = 'ok';
      else
       loc_res = 'Error';
     end if;
     return loc_res;
  end;
$$
 language 'plpgsql';

create or replace function teddy_clicks(in par_teddy text) returns text as
$$
  declare
    loc_res text;

  begin
     if par_teddy NOTNULL then
        UPDATE toys set clicks = clicks+1 where toy_id = 10;
         loc_res = 'ok';
      else
       loc_res = 'Error';
     end if;
     return loc_res;
  end;
$$
 language 'plpgsql';

create or replace function flash_clicks(in par_flash text) returns text as
$$
  declare
    loc_res text;

  begin
     if par_flash NOTNULL then
        UPDATE toys set clicks = clicks+1 where toy_id = 11;
         loc_res = 'ok';
      else
       loc_res = 'Error';
     end if;
     return loc_res;
  end;
$$
 language 'plpgsql';

create or replace function slide_clicks(in par_slide text) returns text as
$$
  declare
    loc_res text;

  begin
     if par_slide NOTNULL then
        UPDATE toys set clicks = clicks+1 where toy_id = 12;
         loc_res = 'ok';
      else
       loc_res = 'Error';
     end if;
     return loc_res;
  end;
$$
 language 'plpgsql';

--places record

create or replace function jollibee_clicks(in par_jolly text) returns text as
$$
  declare
    loc_res text;

  begin
     if par_jolly NOTNULL then
        UPDATE places set clicks = clicks+1 where place_id = 1;
         loc_res = 'ok';
      else
       loc_res = 'Error';
     end if;
     return loc_res;
  end;
$$
 language 'plpgsql';

create or replace function church_clicks(in par_church text) returns text as
$$
  declare
    loc_res text;

  begin
     if par_church NOTNULL then
        UPDATE places set clicks = clicks+1 where place_id = 2;
         loc_res = 'ok';
      else
       loc_res = 'Error';
     end if;
     return loc_res;
  end;
$$
 language 'plpgsql';

create or replace function mcdo_clicks(in par_mcdo text) returns text as
$$
  declare
    loc_res text;

  begin
     if par_mcdo NOTNULL then
        UPDATE places set clicks = clicks+1 where place_id = 3;
         loc_res = 'ok';
      else
       loc_res = 'Error';
     end if;
     return loc_res;
  end;
$$
 language 'plpgsql';

create or replace function school_clicks(in par_sch text) returns text as
$$
  declare
    loc_res text;

  begin
     if par_sch NOTNULL then
        UPDATE places set clicks = clicks+1 where place_id = 4;
         loc_res = 'ok';
      else
       loc_res = 'Error';
     end if;
     return loc_res;
  end;
$$
 language 'plpgsql';

create or replace function pool_clicks(in par_pool text) returns text as
$$
  declare
    loc_res text;

  begin
     if par_pool NOTNULL then
        UPDATE places set clicks = clicks+1 where place_id = 5;
         loc_res = 'ok';
      else
       loc_res = 'Error';
     end if;
     return loc_res;
  end;
$$
 language 'plpgsql';

create or replace function play_clicks(in par_play text) returns text as
$$
  declare
    loc_res text;

  begin
     if par_play NOTNULL then
        UPDATE places set clicks = clicks+1 where place_id = 6;
         loc_res = 'ok';
      else
       loc_res = 'Error';
     end if;
     return loc_res;
  end;
$$
 language 'plpgsql';

create or replace function beach_clicks(in par_play text) returns text as
$$
  declare
    loc_res text;

  begin
     if par_play NOTNULL then
        UPDATE places set clicks = clicks+1 where place_id = 7;
         loc_res = 'ok';
      else
       loc_res = 'Error';
     end if;
     return loc_res;
  end;
$$
 language 'plpgsql';

create or replace function mall_clicks(in par_play text) returns text as
$$
  declare
    loc_res text;

  begin
     if par_play NOTNULL then
        UPDATE places set clicks = clicks+1 where place_id = 8;
         loc_res = 'ok';
      else
       loc_res = 'Error';
     end if;
     return loc_res;
  end;
$$
 language 'plpgsql';

--clothes record
create or replace function panty_clicks(in par_panty text) returns text as
$$
  declare
    loc_res text;

  begin
     if par_panty NOTNULL then
        UPDATE clothes set clicks = clicks+1 where cloth_id = 1;
         loc_res = 'ok';
      else
       loc_res = 'Error';
     end if;
     return loc_res;
  end;
$$
 language 'plpgsql';

create or replace function shorts_clicks(in par_shrt text) returns text as
$$
  declare
    loc_res text;

  begin
     if par_shrt NOTNULL then
        UPDATE clothes set clicks = clicks+1 where cloth_id = 2;
         loc_res = 'ok';
      else
       loc_res = 'Error';
     end if;
     return loc_res;
  end;
$$
 language 'plpgsql';

create or replace function shirt_clicks(in par_shrt text) returns text as
$$
  declare
    loc_res text;

  begin
     if par_shrt NOTNULL then
        UPDATE clothes set clicks = clicks+1 where cloth_id = 3;
         loc_res = 'ok';
      else
       loc_res = 'Error';
     end if;
     return loc_res;
  end;
$$
 language 'plpgsql';

create or replace function jacket_clicks(in par_jacket text) returns text as
$$
  declare
    loc_res text;

  begin
     if par_jacket NOTNULL then
        UPDATE clothes set clicks = clicks+1 where cloth_id = 4;
         loc_res = 'ok';
      else
       loc_res = 'Error';
     end if;
     return loc_res;
  end;
$$
 language 'plpgsql';

create or replace function dress_clicks(in par_dress text) returns text as
$$
  declare
    loc_res text;

  begin
     if par_dress NOTNULL then
        UPDATE clothes set clicks = clicks+1 where cloth_id = 5;
         loc_res = 'ok';
      else
       loc_res = 'Error';
     end if;
     return loc_res;
  end;
$$
 language 'plpgsql';


create or replace function skirt_clicks(in par_skirt text) returns text as
$$
  declare
    loc_res text;

  begin
     if par_skirt NOTNULL then
        UPDATE clothes set clicks = clicks+1 where cloth_id = 6;
         loc_res = 'ok';
      else
       loc_res = 'Error';
     end if;
     return loc_res;
  end;
$$
 language 'plpgsql';

create or replace function pants_clicks(in par_pants text) returns text as
$$
  declare
    loc_res text;

  begin
     if par_pants NOTNULL then
        UPDATE clothes set clicks = clicks+1 where cloth_id = 7;
         loc_res = 'ok';
      else
       loc_res = 'Error';
     end if;
     return loc_res;
  end;
$$
 language 'plpgsql';

create or replace function sweater_clicks(in par_sweater text) returns text as
$$
  declare
    loc_res text;

  begin
     if par_sweater NOTNULL then
        UPDATE clothes set clicks = clicks+1 where cloth_id = 8;
         loc_res = 'ok';
      else
       loc_res = 'Error';
     end if;
     return loc_res;
  end;
$$
 language 'plpgsql';

--get food clicks
create function getclicks_food(OUT character varying, OUT integer, OUT character varying, OUT character varying, OUT character varying, OUT character varying, OUT character varying, OUT character varying, OUT character varying, OUT character varying) returns SETOF record
LANGUAGE SQL
AS $$
select food_name, clicks, casein, gluten, calories, calories_total, protein, protein_total, cholesterol, cholesterol_total  from food  where clicks > 0 order by food_id;
$$;


--get toys clicks
create or replace function getclicks_toys(out text, out int) returns setof record as
$$

  select toy_name, clicks from toys where clicks > 0 order by toy_id;
$$
 language 'sql';

--get places clicks
create or replace function getclicks_places(out text, out int) returns setof record as
$$

  select place_name, clicks from places where clicks > 0 order by place_id;
$$
 language 'sql';


--get clothes clicks
create or replace function getclicks_clothes(out text, out int) returns setof record as
$$

  select cloth_name, clicks from clothes where clicks > 0 order by cloth_id;
$$
 language 'sql';

--delete food records
create or replace function delete_food(in par_del text) returns text as
$$
  declare
    loc_res text;

  begin
     if par_del NOTNULL then
        UPDATE food SET clicks = 0, calories_total = 0, protein_total = 0, cholesterol_total =0;
         loc_res = 'ok';
      else
       loc_res = 'Error';
     end if;
     return loc_res;
  end;
$$
 language 'plpgsql';

--delete toys records
create or replace function delete_toys(in par_del text) returns text as
$$
  declare
    loc_res text;

  begin
     if par_del NOTNULL then
        UPDATE toys SET clicks = 0;
         loc_res = 'ok';
      else
       loc_res = 'Error';
     end if;
     return loc_res;
  end;
$$
 language 'plpgsql';

--delete places records
create or replace function delete_places(in par_del text) returns text as
$$
  declare
    loc_res text;

  begin
     if par_del NOTNULL then
        UPDATE places SET clicks = 0;
         loc_res = 'ok';
      else
       loc_res = 'Error';
     end if;
     return loc_res;
  end;
$$
 language 'plpgsql';

--delete clothes records
create or replace function delete_clothes(in par_del text) returns text as
$$
  declare
    loc_res text;

  begin
     if par_del NOTNULL then
        UPDATE clothes SET clicks = 0;
         loc_res = 'ok';
      else
       loc_res = 'Error';
     end if;
     return loc_res;
  end;
$$
 language 'plpgsql';

--upload photos
	create or REPLACE FUNCTION upload_food(IN par_fdname text, IN par_fdimg text) RETURNS text AS
  $$
  DECLARE
    loc_res text;
  BEGIN
      INSERT INTO food(food_name, food_img)
      VALUES (par_fdname, par_fdimg);
    loc_res = 'stored';
    return loc_res;
  END;
  $$

  LANGUAGE 'plpgsql' VOLATILE;




-- --upload photo
-- create or replace function upload( in par_name text, in par_img text) returns text as
-- $$
--   declare
--     loc_res text;
--     loc_name text;
--     loc_img text;
--
--   begin
--      select into loc_name food_name, loc_img food_img from food;
--