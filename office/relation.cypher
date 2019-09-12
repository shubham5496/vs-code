LOAD CSV WITH HEADERS FROM
'file:///complete.csv' AS line
WITH line, SPLIT(line.timestamp_x, ' ') AS dt
MATCH (visitor:Visitor {id: TOINT(line.visitorid) })
MATCH  (tree:Tree {id: TOINT(line.parentid) })
CALL apoc.create.relationship(visitor,line.event,{action:line.event,date:dt[0],time:dt[1]},tree) YIELD rel
RETURN rel