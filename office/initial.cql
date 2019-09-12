CREATE CONSTRAINT ON (v:Visitor) ASSERT v.id IS UNIQUE;
CREATE CONSTRAINT ON (p:Product) ASSERT p.id IS UNIQUE;
CREATE CONSTRAINT ON (c:Catagory) ASSERT c.id IS UNIQUE;
CREATE CONSTRAINT ON (t:Tree) ASSERT t.id IS UNIQUE;

// Visitor, product , catagory.
USING PERIODIC COMMIT
LOAD CSV WITH HEADERS FROM
'file:///complete.csv' AS line
WITH line, SPLIT(line.timestamp_x, ' ') AS dt

MERGE (visitor:Visitor {id: TOINT(line.visitorid) })

MERGE  (product:Product {id: TOINT(line.itemid) })

MERGE  (catagory:Catagory {id: TOINT(line.categoryid) })

MERGE  (tree:Tree {id: TOINT(line.parentid) })

MERGE (product)-[:Inside]->(catagory)

MERGE (catagory)-[:Parent]->(tree)

CREATE (visitor)-[v:event]->(product)

set v.action = line.event
set v.date = dt[1]
set v.time = dt[2]
set v.transection = CASE line.transactionid? WHEN 'null' THEN false ELSE line.transactionid

//




CREATE CONSTRAINT ON (v:Visitor) ASSERT v.id IS UNIQUE;
CREATE CONSTRAINT ON (t:Tree) ASSERT t.id IS UNIQUE;

// Visitor, product , catagory.
USING PERIODIC COMMIT
LOAD CSV WITH HEADERS FROM
'file:///complete.csv' AS line
WITH line, SPLIT(line.timestamp_x, ' ') AS dt

MERGE (visitor:Visitor {id: TOINT(line.visitorid) })

MERGE  (tree:Tree {id: TOINT(line.parentid) })

CREATE (visitor)-[e:event]->(tree)
x = line.event
set e.x = TRUE
set e.date = dt[1]
set e.time = dt[2]