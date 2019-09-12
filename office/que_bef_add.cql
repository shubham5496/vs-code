MATCH (v:Visitor)-[rel]->(t:Tree)
WHERE rel.date ='2015-07-11' AND t.id = 1482
WITH v,t
MATCH (v)-[rel]->(t)
WHERE rel.date < '2015-07-11' AND rel.action = 'addtocart'
RETURN v,rel,t