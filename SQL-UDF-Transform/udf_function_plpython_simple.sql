create or replace function inverse_int (a int) returns int as $$
return -a
$$ language plpythonu;

CREATE OR REPLACE FUNCTION simple_mapping(s anyelement, properties json)
  RETURNS table(customer_id int, expenses decimal(9,2), tax_due decimal(9,2))
  AS $$
    SELECT inverse_int(s.cust_id::int)::int, s.expenses::decimal(9,2),
           (properties->>'tax-ratio')::decimal(9,2)*s.expenses::decimal(9,2);
$$ LANGUAGE sql;


