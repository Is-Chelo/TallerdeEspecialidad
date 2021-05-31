-- GRAFO

-- TABLA CLIENTE   =   NODO	
CREATE TABLE cliente(
	id serial NOT NULL PRIMARY KEY,
	nombre varchar,
	latitud float,
	longitud float
);

-- TABLA RUTAS   =   ARCOS
CREATE SCHEMA IF NOT EXISTS rutas;
CREATE TABLE rutas.graph(
	id serial NOT NULL PRIMARY KEY,
	source int,
	target int,
	distancia float
);

-- INSERTAMOS A CLIENTES
INSERT INTO cliente(nombre, latitud, longitud) values ('La Recoleta', -19.054360013223178, -65.25398864728986);
INSERT INTO cliente(nombre, latitud, longitud) values ('Morro',-19.02642334891946, -65.24610218638061);
INSERT INTO cliente(nombre, latitud, longitud) values ('Estadium Patria', -19.03318057927173, -65.25783031853975);
INSERT INTO cliente(nombre, latitud, longitud) values ('Patacon',-19.026778466613955, -65.26936232144419);
INSERT INTO cliente(nombre, latitud, longitud) values ('Mercado Central',-19.041950903133287, -65.26427849190807);

INSERT INTO cliente(nombre, latitud, longitud) values ('ParqueBolivar',-19.04100227970769, -65.26532361635684);
INSERT INTO cliente(nombre, latitud, longitud) values ('Cementerio',-19.052493938227737, -65.26882908347841);
INSERT INTO cliente(nombre, latitud, longitud) values ('Hospital San Barbara',-19.044750676514315, -65.26742167648021);
INSERT INTO cliente(nombre, latitud, longitud) values ('EL tejar',-19.06199553368243, -65.27252920981795);
INSERT INTO cliente(nombre, latitud, longitud) values ('Parada Tarabuco',-19.04910588476073, -65.24678256451645);

-- Aumentar 
INSERT INTO cliente(nombre, latitud, longitud) values ('alto Munaypata',-19.01376960186104, -65.2628026627765);
INSERT INTO cliente(nombre, latitud, longitud) values ('Los Tarcos',-19.01652898475465, -65.27301987473552);
INSERT INTO cliente(nombre, latitud, longitud) values ('Plaza 25 de mayo',-19.047903156425114, -65.25972597845735);
INSERT INTO cliente(nombre, latitud, longitud) values ('Hospital Cristo de las Americas',-19.0451805410047, -65.268759214635);
INSERT INTO cliente(nombre, latitud, longitud) values ('Cancha Tocopilla',-19.034253449146277, -65.26452329032888);




-- INSERTAMOS LOS ARCOS 
INSERT INTO rutas.graph(id,source, target)values(1,1,2);
INSERT INTO rutas.graph(id,source, target)values(2,1,3);
INSERT INTO rutas.graph(id,source, target)values(3,2,1);
INSERT INTO rutas.graph(id,source, target)values(4,2,3);
INSERT INTO rutas.graph(id,source, target)values(5,2,5);
INSERT INTO rutas.graph(id,source, target)values(6,3,1);
INSERT INTO rutas.graph(id,source, target)values(7,3,2);
INSERT INTO rutas.graph(id,source, target)values(8,3,4);
INSERT INTO rutas.graph(id,source, target)values(9,3,5);
INSERT INTO rutas.graph(id,source, target)values(10,4,3);
INSERT INTO rutas.graph(id,source, target)values(11,4,5);
INSERT INTO rutas.graph(id,source, target)values(12, 5,2);
INSERT INTO rutas.graph(id,source, target)values(13,5,3);
INSERT INTO rutas.graph(id,source, target)values(14,5,4);

INSERT INTO rutas.graph(id,source, target)values(15,1,6);
INSERT INTO rutas.graph(id,source, target)values(16,1,7);
INSERT INTO rutas.graph(id,source, target)values(17,1,8);
INSERT INTO rutas.graph(id,source, target)values(18,6,1);
INSERT INTO rutas.graph(id,source, target)values(19,7,1);
INSERT INTO rutas.graph(id,source, target)values(20,8,1);
INSERT INTO rutas.graph(id,source, target)values(21,2,6);
INSERT INTO rutas.graph(id,source, target)values(22,6,2);
INSERT INTO rutas.graph(id,source, target)values(23,3,6);
INSERT INTO rutas.graph(id,source, target)values(24,3,7);
INSERT INTO rutas.graph(id,source, target)values(25,3,8);
INSERT INTO rutas.graph(id,source, target)values(26,3,9);

INSERT INTO rutas.graph(id,source, target)values(27,6,3);
INSERT INTO rutas.graph(id,source, target)values(28,7,3);
INSERT INTO rutas.graph(id,source, target)values(29,8,3);
INSERT INTO rutas.graph(id,source, target)values(30,9,3);

INSERT INTO rutas.graph(id,source, target)values(31,4,9);
INSERT INTO rutas.graph(id,source, target)values(32,4,8);
INSERT INTO rutas.graph(id,source, target)values(33,9,4);
INSERT INTO rutas.graph(id,source, target)values(34,8,4);

INSERT INTO rutas.graph(id,source, target)values(35,5,9);
INSERT INTO rutas.graph(id,source, target)values(36,9,5);


-- Aumentar 

INSERT INTO rutas.graph(id,source, target)values(37,6,14);
INSERT INTO rutas.graph(id,source, target)values(38,7,14);
INSERT INTO rutas.graph(id,source, target)values(39,7,8);
INSERT INTO rutas.graph(id,source, target)values(40,8,9);
INSERT INTO rutas.graph(id,source, target)values(41,9,10);
INSERT INTO rutas.graph(id,source, target)values(42,8,10);
INSERT INTO rutas.graph(id,source, target)values(43,8,14);
INSERT INTO rutas.graph(id,source, target)values(44,8,11);
INSERT INTO rutas.graph(id,source, target)values(45,10,14);
INSERT INTO rutas.graph(id,source, target)values(46,10,12);
INSERT INTO rutas.graph(id,source, target)values(47,10,11);
INSERT INTO rutas.graph(id,source, target)values(48,12,11);
INSERT INTO rutas.graph(id,source, target)values(49,11,13);
INSERT INTO rutas.graph(id,source, target)values(50,13,14);
INSERT INTO rutas.graph(id,source, target)values(51,8,7);

INSERT INTO rutas.graph(id,source, target)values(52,14,7);
INSERT INTO rutas.graph(id,source, target)values(53,8,7);
INSERT INTO rutas.graph(id,source, target)values(54,9,8);
INSERT INTO rutas.graph(id,source, target)values(55,10,9);
INSERT INTO rutas.graph(id,source, target)values(56,10,8);
INSERT INTO rutas.graph(id,source, target)values(57,14,8);
INSERT INTO rutas.graph(id,source, target)values(58,11,8);
INSERT INTO rutas.graph(id,source, target)values(59,14,10);
INSERT INTO rutas.graph(id,source, target)values(60,12,10);
INSERT INTO rutas.graph(id,source, target)values(61,11,10);
INSERT INTO rutas.graph(id,source, target)values(62,11,12);
INSERT INTO rutas.graph(id,source, target)values(63,13,11);
INSERT INTO rutas.graph(id,source, target)values(64,14,13);
INSERT INTO rutas.graph(id,source, target)values(65,7,8);
INSERT INTO rutas.graph(id,source, target)values(66,14,6);
INSERT INTO rutas.graph(id,source, target)values(67,15,10);
INSERT INTO rutas.graph(id,source, target)values(68,10,15);












-- FUNCION DEL ALGORITMO DIJSTRAK   CAMINO MAS CORTO
CREATE SCHEMA IF NOT EXISTS algoritmo;
CREATE OR REPLACE FUNCTION algoritmo.dijkstra (
  v_graph_sql TEXT
, i_source BIGINT
, i_target BIGINT
)
RETURNS TABLE (
  id BIGINT
, vertex BIGINT
, previous_vertex BIGINT
, cost DOUBLE PRECISION
) AS $$
DECLARE
  r_vertex RECORD;
  d_infinity DOUBLE PRECISION := 9999999999;
  i_current_vertex BIGINT;
  i_neighbour_vertex BIGINT;
  i_current_vertex_cost DOUBLE PRECISION;
BEGIN
  CREATE TEMP TABLE IF NOT EXISTS dijkstra_graph (
    id BIGINT
  , source BIGINT
  , target BIGINT
  , cost DOUBLE PRECISION
  ) ON COMMIT DROP;

  CREATE TEMP TABLE IF NOT EXISTS dijkstra_result (
    id BIGINT
  , vertex BIGINT
  , previous_vertex BIGINT
  , cost DOUBLE PRECISION
  , is_visited BOOLEAN
  ) ON COMMIT DROP;

  DELETE FROM dijkstra_graph;
  DELETE FROM dijkstra_result;

  EXECUTE 'INSERT INTO dijkstra_graph (id, source, target, cost) ' || v_graph_sql;

  INSERT INTO dijkstra_result (id, vertex, previous_vertex, cost, is_visited)
  SELECT NULL::BIGINT, dg.source, NULL::BIGINT, d_infinity, FALSE FROM dijkstra_graph dg
  UNION
  SELECT NULL::BIGINT, dg.target, NULL::BIGINT, d_infinity, FALSE FROM dijkstra_graph dg;

  UPDATE dijkstra_result dr SET cost = 0 WHERE dr.vertex = i_source;

  LOOP
	i_current_vertex := NULL;

  	SELECT dr.vertex, dr.cost
  	INTO i_current_vertex, i_current_vertex_cost
  	FROM dijkstra_result dr
  	WHERE dr.is_visited = FALSE AND dr.cost < d_infinity
  	ORDER BY cost ASC
  	LIMIT 1;

  	EXIT WHEN i_current_vertex IS NULL OR (i_target IS NOT NULL AND i_current_vertex = i_target);

  	UPDATE dijkstra_result dr SET is_visited = TRUE WHERE dr.vertex = i_current_vertex;

	UPDATE dijkstra_result dr
	SET id = dg.id
	  , previous_vertex = i_current_vertex
	  , cost = i_current_vertex_cost + dg.cost
	FROM dijkstra_graph dg
	WHERE dr.vertex = dg.target
	  AND dr.is_visited = FALSE
	  AND dg.source = i_current_vertex
	  AND (i_current_vertex_cost + dg.cost) < dr.cost;

  END LOOP;

  IF i_target IS NULL THEN
  	RETURN QUERY SELECT dr.id, dr.vertex, dr.previous_vertex, dr.cost FROM dijkstra_result dr;
  ELSE
  	RETURN QUERY WITH RECURSIVE backtrack_dijkstra_result(id, vertex, previous_vertex, cost) AS (
  		SELECT dr.id, dr.vertex, dr.previous_vertex, dr.cost
  		FROM dijkstra_result dr
  		WHERE dr.vertex = i_target
  		
  		UNION ALL
  		
  		SELECT dr.id, dr.vertex, dr.previous_vertex, dr.cost
  		FROM dijkstra_result dr, backtrack_dijkstra_result bdr
  		WHERE dr.vertex = bdr.previous_vertex
  	) SELECT bdr.id, bdr.vertex, bdr.previous_vertex, bdr.cost
  	FROM backtrack_dijkstra_result bdr;
  END IF;
END
$$ LANGUAGE plpgsql
  SECURITY DEFINER
  SET search_path = pggraph, pg_temp;

-- CALCULO DE LA DISTANCIA DE DOS PUNTOS GEOGRAFICOS
CREATE or REPLACE FUNCTION algoritmo.formula(i int, l1 DOUBLE PRECISION, lon1 DOUBLE PRECISION, l2 DOUBLE PRECISION, lon2 DOUBLE PRECISION)
RETURNS void
LANGUAGE plpgsql
AS $$
DECLARE
	dlat DOUBLE PRECISION:=l1-l2;
	dlon DOUBLE PRECISION:=lon1-lon2;
	R DOUBLE PRECISION := 6372.795477598; 
	dista DOUBLE PRECISION:=0;
	b DOUBLE PRECISION:=0;
	rad DOUBLE PRECISION:=(3.1418/18);
BEGIN
	b := power(sin(rad*dlat/2),2) + cos(rad*l1) * cos(rad*l2) * power(sin(rad*dlon/2),2);
	dista := 2*R*asin(sqrt(b));
	dista := dista/10;	
	UPDATE rutas.graph set distancia = dista WHERE rutas.graph.id = i;
	
END $$;


-- FUNCION CALCULO DE LA DISTANCIA

CREATE or REPLACE FUNCTION algoritmo.formula(i int, l1 DOUBLE PRECISION, lon1 DOUBLE PRECISION, l2 DOUBLE PRECISION, lon2 DOUBLE PRECISION)
RETURNS void
LANGUAGE plpgsql
AS $$
DECLARE
	dlat DOUBLE PRECISION:=l1-l2;
	dlon DOUBLE PRECISION:=lon1-lon2;
	R DOUBLE PRECISION := 6372.795477598; 
	dista DOUBLE PRECISION:=0;
	b DOUBLE PRECISION:=0;
	rad DOUBLE PRECISION:=(3.1418/18);
BEGIN
	b := power(sin(rad*dlat/2),2) + cos(rad*l1) * cos(rad*l2) * power(sin(rad*dlon/2),2);
	dista := 2*R*asin(sqrt(b));
	dista := dista/10;	
	UPDATE rutas.graph set distancia = dista WHERE rutas.graph.id = i;
	
END $$;



-- ACTUALIZAMOS LA DISTANCIA DE LA TABLA RUTA.GRAPH CON LA FORMULA  TODAAA LA TABLA
CREATE or REPLACE FUNCTION algoritmo.calculodistanciaTodos()
RETURNS void
LANGUAGE plpgsql
AS $$
DECLARE
	i int := 1;
	l1 DOUBLE PRECISION:=0;
	lon1 DOUBLE PRECISION:=0;
	l2 DOUBLE PRECISION:=0;
	lon2 DOUBLE PRECISION:=0;
	total int := (SELECT Count(id) FROM rutas.graph); 
BEGIN

While(i<=total)
	Loop
		l1 = (SELECT latitud from rutas.graph r INNER JOIN cliente c ON r.source = c.id WHERE r.id=i );
		lon1 = (SELECT longitud from rutas.graph r INNER JOIN cliente c ON r.source = c.id WHERE r.id=i );
		l2 = (SELECT latitud from rutas.graph r INNER JOIN cliente c ON r.target = c.id WHERE r.id=i );
		lon2 = (SELECT longitud from rutas.graph r INNER JOIN cliente c ON r.target = c.id WHERE r.id=i );
		PERFORM algoritmo.formula(i,l1,lon1,l2,lon2);
	i :=i+1;
	end Loop;

END $$;


-- ACTUALIZAMOS LA DISTANCIA DE LA TABLA RUTAS.GRAPH POR ID
CREATE or REPLACE FUNCTION rutas.calculodistanciaUnaTupla(id int)
RETURNS void
LANGUAGE plpgsql
AS $$
DECLARE
	i int := 1;
	l1 DOUBLE PRECISION:=0;
	lon1 DOUBLE PRECISION:=0;
	l2 DOUBLE PRECISION:=0;
	lon2 DOUBLE PRECISION:=0;
	total int := (SELECT Count(id) FROM rutas.graph); 
BEGIN
	l1 = (SELECT latitud from rutas.graph r INNER JOIN cliente c ON r.source = c.id WHERE r.id=id);
	lon1 = (SELECT longitud from rutas.graph r INNER JOIN cliente c ON r.source = c.id WHERE r.id=id );
	l2 = (SELECT latitud from rutas.graph r INNER JOIN cliente c ON r.target = c.id WHERE r.id=id );
	lon2 = (SELECT longitud from rutas.graph r INNER JOIN cliente c ON r.target = c.id WHERE r.id=id );
	PERFORM rutas.formula(id,l1,lon1,l2,lon2);
END $$;







-- CONSULTAS
SELECT algoritmo.calculodistanciaTodos() -- LLENAMOS LA TABLA RUTAS.GRAPH CON LAS DISTANCIAS OBTENIDASS 
SELECT * FROM rutas.graph -- DATOS DE LA TABLA RUTAS


SELECT * FROM algoritmo.dijkstra('SELECT * FROM rutas.graph', 1, 5);   -- sacamos la ruta de inicio = 1 y el destino = 5
SELECT * FROM cliente -- DATOS DE LA TABLA CLIENTES


SELECT * FROM algoritmo.dijkstra('SELECT * FROM rutas.graph', 1, 5) d INNER JOIN cliente c ON d.vertex = c.id;   -- sacamos la ruta de inicio = 1 y el destino = 5




