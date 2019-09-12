CREATE CONSTRAINT ON (v:Visitor) ASSERT v.id IS UNIQUE;
CREATE CONSTRAINT ON (t:Tree) ASSERT t.id IS UNIQUE;
// Visitor, product , catagory.
USING PERIODIC COMMIT
LOAD CSV WITH HEADERS FROM
'file:///complete.csv' AS line
MERGE (visitor:Visitor {id: TOINT(line.visitorid) })
MERGE  (tree:Tree {id: TOINT(line.parentid) })