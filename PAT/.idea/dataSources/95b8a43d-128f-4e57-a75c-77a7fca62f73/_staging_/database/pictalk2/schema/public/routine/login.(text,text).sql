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