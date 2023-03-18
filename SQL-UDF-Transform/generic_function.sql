CREATE FUNCTION transform(row anyelement, properties json)
RETURNS table(a int, b int, c int, d int) AS $$
SELECT row.a, row.b, row.c, row.a+row.b+(properties->>'delta')::int
$$ LANGUAGE sql