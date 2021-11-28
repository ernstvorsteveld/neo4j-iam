CREATE (n:Identity:Firm1 {name : 'John doe'});
CREATE (n:Identity:Firm1 {name : 'Major Tom'});

CREATE (n:Role:Firm1 {name : 'TPI Manager'});
CREATE (n:Role:Firm1 {name : 'Supplier Manager'});

CREATE (n:Entitlement:Firm1 {name : 'read'});
CREATE (n:Entitlement:Firm1 {name : 'create'});
CREATE (n:Entitlement:Firm1 {name : 'edit'});
CREATE (n:Entitlement:Firm1 {name : 'delete'});


MATCH
  (a:Identity),
  (b:Role)
WHERE a.name = 'John doe' AND b.name = 'TPI Manager'
CREATE (a)-[r:IS {since: "01-11-2021"}]->(b)
RETURN type(r);


MATCH
  (a:Identity),
  (b:Role)
WHERE a.name = 'Major Tom' AND b.name = 'Supplier Manager'
CREATE (a)-[r:IS {since: "01-01-2021"}]->(b)
RETURN type(r);


MATCH
  (a:Entitlement),
  (b:Role)
WHERE a.name = 'read' AND b.name = 'Supplier Manager'
CREATE (b)-[r:CAN {on: "Supplier", since: "01-01-2021"}]->(a)
RETURN r;

MATCH
  (a:Entitlement),
  (b:Role)
WHERE a.name = 'create' AND b.name = 'Supplier Manager'
CREATE (b)-[r:CAN {on: "Supplier", since: "01-01-2021"}]->(a)
RETURN type(r);

MATCH
  (a:Entitlement),
  (b:Role)
WHERE a.name = 'edit' AND b.name = 'Supplier Manager'
CREATE (b)-[r:CAN {on: "Supplier", since: "01-01-2021"}]->(a)
RETURN type(r);

MATCH
  (a:Entitlement),
  (b:Role)
WHERE a.name = 'delete' AND b.name = 'Supplier Manager'
CREATE (b)-[r:CAN {on: "Supplier", since: "01-01-2021"}]->(a)
RETURN type(r);


MATCH
  (a:Entitlement),
  (b:Role)
WHERE a.name = 'read' AND b.name = 'TPI Manager'
CREATE (b)-[r:CAN {on: "Supplier", since: "01-01-2021"}]->(a)
RETURN type(r);

// MATCH ()-[r]-() WHERE id(r)=3 DELETE r;

MATCH (n)
DETACH DELETE n;

MATCH (n:Firm1)
WHERE n.name STARTS WITH 'Jo'
RETURN n;


MATCH (r {name:"TPI Manager"})<-[ri:IS] - (n)
WHERE ri.since = "01-11-2021"
RETURN ri,n;

// All roles that have read entitlement on Supplier
MATCH (e:Entitlement) <- [er:CAN] - (r:Role) <- [rir:IS] - (i:Identity)
Where er.on="Supplier" AND e.name = "read"
RETURN i;

// All identities that can create on a supplier
MATCH (e:Entitlement) <- [er:CAN] - (r:Role) <- [ri:IS] - (i:Identity)
Where er.on="Supplier" AND e.name = "create"
RETURN i.name, ri.since, r.name, er.since, e.name;

MATCH (e:Entitlement) <- [er:CAN] - (r:Role)
Where er.on="Supplier" AND e.name = "read"
RETURN count(r);

MATCH (e:Entitlement) <- [er:CAN] - (r:Role)
RETURN r, er;
