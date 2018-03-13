create function egg_clicks(egg integer) returns text
LANGUAGE plpgsql
AS $$
declare
    loc_res text;
  begin
    UPDATE food set clicks = clicks+1 where food_id = 1;
    loc_res = 'ok';
    return loc_res;
  end;
$$;
