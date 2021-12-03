CREATE (n:Identity:Firm1 {name : 'John doe'});
CREATE (n:Identity:Firm2 {name : 'John doe'});
CREATE (n:Identity:Firm1 {name : 'Major Tom'});

CREATE (n:Role:Firm1 {name : 'TPI Manager'});
CREATE (n:Role:Firm1 {name : 'Supplier Manager'});

CREATE (n:Entitlement:Firm1 {name : 'read'});
CREATE (n:Entitlement:Firm1 {name : 'create'});
CREATE (n:Entitlement:Firm1 {name : 'edit'});
CREATE (n:Entitlement:Firm1 {name : 'delete'});

CREATE (e:Event:Firm1 {name : 'Login Success'});
CREATE (e:Event:Firm1 {name : 'Login Failed'});
CREATE (e:Event:Firm1 {name : 'Password Reset Requested'});
CREATE (e:Event:Firm1 {name : 'Password Reset Success'});


MATCH
  (a:Identity:Firm1),
  (e:Event:Firm1)
WHERE a.name = 'Major Tom' AND e.name = 'Login Failed'
CREATE (a)-[ae:PERFORMED {on: "03-11-2021", count: 3}]->(e)
RETURN type(ae);

MATCH
  (a:Identity:Firm1),
  (e:Event:Firm1)
WHERE a.name = 'Major Tom' AND e.name = 'Password Reset Requested'
CREATE (a)-[ae:PERFORMED {on: "03-11-2021", count: 1}]->(e)
RETURN type(ae);

MATCH
  (a:Identity:Firm1),
  (e:Event:Firm1)
WHERE a.name = 'Major Tom' AND e.name = 'Password Reset Success'
CREATE (a)-[ae:PERFORMED {on: "03-11-2021", count: 1}]->(e)
RETURN type(ae);

MATCH
  (a:Identity:Firm1),
  (e:Event:Firm1)
WHERE a.name = 'Major Tom' AND e.name = 'Login Success'
CREATE (a)-[ae:PERFORMED {on: "03-11-2021", count:1}]->(e)
RETURN type(ae);




MATCH
  (a:Identity:Firm1),
  (e:Event:Firm1)
WHERE a.name = 'John doe' AND e.name = 'Login Success'
CREATE (a)-[ae:PERFORMED {on: "01-11-2021", count:1}]->(e)
RETURN type(ae);

MATCH
  (a:Identity:Firm1),
  (e:Event:Firm1)
WHERE a.name = 'John doe' AND e.name = 'Login Failed'
CREATE (a)-[ae:PERFORMED {on: "02-11-2021", count:2}]->(e)
RETURN type(ae);

MATCH
  (a:Identity:Firm1),
  (e:Event:Firm1)
WHERE a.name = 'John doe' AND e.name = 'Login Success'
CREATE (a)-[ae:PERFORMED {on: "02-11-2021", count: 1}]->(e)
RETURN type(ae);



MATCH
  (a:Identity:Firm1),
  (b:Role:Firm1)
WHERE a.name = 'John doe' AND b.name = 'TPI Manager'
CREATE (a)-[r:IS {since: "01-11-2021"}]->(b)
RETURN type(r);


MATCH
  (a:Identity:Firm1),
  (b:Role:Firm1)
WHERE a.name = 'Major Tom' AND b.name = 'Supplier Manager'
CREATE (a)-[r:IS {since: "01-01-2021"}]->(b)
RETURN type(r);


MATCH
  (a:Entitlement:Firm1),
  (b:Role:Firm1)
WHERE a.name = 'read' AND b.name = 'Supplier Manager'
CREATE (b)-[r:CAN {on: "Supplier", since: "01-01-2021"}]->(a)
RETURN r;

MATCH
  (a:Entitlement:Firm1),
  (b:Role:Firm1)
WHERE a.name = 'create' AND b.name = 'Supplier Manager'
CREATE (b)-[r:CAN {on: "Supplier", since: "01-01-2021"}]->(a)
RETURN type(r);

MATCH
  (a:Entitlement:Firm1),
  (b:Role:Firm1)
WHERE a.name = 'edit' AND b.name = 'Supplier Manager'
CREATE (b)-[r:CAN {on: "Supplier", since: "01-01-2021"}]->(a)
RETURN type(r);

MATCH
  (a:Entitlement:Firm1),
  (b:Role:Firm1)
WHERE a.name = 'delete' AND b.name = 'Supplier Manager'
CREATE (b)-[r:CAN {on: "Supplier", since: "01-01-2021"}]->(a)
RETURN type(r);


MATCH
  (a:Entitlement:Firm1),
  (b:Role:Firm1)
WHERE a.name = 'read' AND b.name = 'TPI Manager'
CREATE (b)-[r:CAN {on: "Supplier", since: "01-01-2021"}]->(a)
RETURN type(r);
