// MATCH ()-[r]-() WHERE id(r)=3 DELETE r;

MATCH (n)
DETACH DELETE n;

MATCH (n:Firm1)
WHERE n.name STARTS WITH 'Jo'
RETURN n;


MATCH (r {name:"TPI Manager"})<-[ri:IS] - (n)
WHERE ri.since = "01-11-2021"
RETURN ri,n;

MATCH (r {name:"Supplier Manager"})<-[ri:IS] - (n)
WHERE ri.since = "01-01-2021"
RETURN ri,n;


// All roles that have read entitlement on Supplier
MATCH (e:Entitlement) <- [er:CAN] - (r:Role) <- [rir:IS] - (i:Identity)
Where er.on="Supplier" AND e.name = "read"
RETURN i;

// All identities that can create on a supplier
MATCH (e:Entitlement) <- [er:CAN] - (r:Role) <- [ri:IS] - (i:Identity)
Where er.on="Supplier" AND e.name = "create"
RETURN i.name, ri.since, r.name, er.since, e.name;

MATCH (e:Entitlement) <- [er:CAN] - (r:Role) <- [ri:IS] - (i:Identity)
Where er.on="Supplier" AND e.name = "read"
RETURN i.name, ri.since, r.name, er.since, e.name;

MATCH (i:Identity) - [ri:IS] ->  (r:Role) - [er:CAN] -> (e:Entitlement)
Where er.on="Supplier" AND e.name = "read"
RETURN i.name, ri.since, r.name, er.since, e.name;

MATCH (e:Entitlement) <- [er:CAN] - (r:Role)
Where er.on="Supplier" AND e.name = "read"
RETURN count(r);

MATCH (e:Entitlement) <- [er:CAN] - (r:Role)
RETURN r, er;
