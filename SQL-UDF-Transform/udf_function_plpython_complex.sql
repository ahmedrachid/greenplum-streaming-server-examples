CREATE TYPE transformer_type AS (
    customer_id int,
    expenses decimal(9,2),
    tax_due decimal(9,2)
);
create or replace function transform_python (cust_id int, expenses decimal(9,2), tax_ratio decimal(9,2))
returns transformer_type as $$
    return {'customer_id':int(cust_id), 'expenses': -1 * expenses, 'tax_due':float(tax_ratio * expenses) }
$$ language plpythonu;

CREATE OR REPLACE FUNCTION simple_mapping(s anyelement, properties json)
  RETURNS table(customer_id int, expenses decimal(9,2), tax_due decimal(9,2))
  AS $$
    SELECT transform_python(s.cust_id::int, s.expenses::decimal(9,2),
           (properties->>'tax-ratio')::decimal(9,2));
$$ LANGUAGE sql;


