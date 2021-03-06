PGDMP     /    -    	            y            bdtallerespecialidad    11.11    11.11     :           0    0    ENCODING    ENCODING        SET client_encoding = 'UTF8';
                       false            ;           0    0 
   STDSTRINGS 
   STDSTRINGS     (   SET standard_conforming_strings = 'on';
                       false            <           0    0 
   SEARCHPATH 
   SEARCHPATH     8   SELECT pg_catalog.set_config('search_path', '', false);
                       false            =           1262    26674    bdtallerespecialidad    DATABASE     ?   CREATE DATABASE bdtallerespecialidad WITH TEMPLATE = template0 ENCODING = 'UTF8' LC_COLLATE = 'Spanish_Bolivia.1252' LC_CTYPE = 'Spanish_Bolivia.1252';
 $   DROP DATABASE bdtallerespecialidad;
             postgres    false            )            2615    26697 	   algoritmo    SCHEMA        CREATE SCHEMA algoritmo;
    DROP SCHEMA algoritmo;
             postgres    false                        2615    26686    rutas    SCHEMA        CREATE SCHEMA rutas;
    DROP SCHEMA rutas;
             postgres    false            ?            1255    26716    calculodistanciatodos()    FUNCTION       CREATE FUNCTION algoritmo.calculodistanciatodos() RETURNS void
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
 1   DROP FUNCTION algoritmo.calculodistanciatodos();
    	   algoritmo       postgres    false    41                       1255    26698    dijkstra(text, bigint, bigint)    FUNCTION     =
  CREATE FUNCTION algoritmo.dijkstra(v_graph_sql text, i_source bigint, i_target bigint) RETURNS TABLE(id bigint, vertex bigint, previous_vertex bigint, cost double precision)
    LANGUAGE plpgsql SECURITY DEFINER
    SET search_path TO 'pggraph', 'pg_temp'
    AS $$
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
$$;
 V   DROP FUNCTION algoritmo.dijkstra(v_graph_sql text, i_source bigint, i_target bigint);
    	   algoritmo       postgres    false    41            ?            1255    26714 X   formula(integer, double precision, double precision, double precision, double precision)    FUNCTION     X  CREATE FUNCTION algoritmo.formula(i integer, l1 double precision, lon1 double precision, l2 double precision, lon2 double precision) RETURNS void
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
 ?   DROP FUNCTION algoritmo.formula(i integer, l1 double precision, lon1 double precision, l2 double precision, lon2 double precision);
    	   algoritmo       postgres    false    41            ?            1255    26713    calculodistanciatodos()    FUNCTION        CREATE FUNCTION rutas.calculodistanciatodos() RETURNS void
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
		PERFORM rutas.formula(i,l1,lon1,l2,lon2);
	i :=i+1;
	end Loop;

END $$;
 -   DROP FUNCTION rutas.calculodistanciatodos();
       rutas       postgres    false    18                       1255    26717 !   calculodistanciaunatupla(integer)    FUNCTION     ?  CREATE FUNCTION rutas.calculodistanciaunatupla(id integer) RETURNS void
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
 :   DROP FUNCTION rutas.calculodistanciaunatupla(id integer);
       rutas       postgres    false    18                       1255    26695    dijkstra(text, bigint, bigint)    FUNCTION     9
  CREATE FUNCTION rutas.dijkstra(v_graph_sql text, i_source bigint, i_target bigint) RETURNS TABLE(id bigint, vertex bigint, previous_vertex bigint, cost double precision)
    LANGUAGE plpgsql SECURITY DEFINER
    SET search_path TO 'pggraph', 'pg_temp'
    AS $$
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
$$;
 R   DROP FUNCTION rutas.dijkstra(v_graph_sql text, i_source bigint, i_target bigint);
       rutas       postgres    false    18            ?            1255    26696 X   formula(integer, double precision, double precision, double precision, double precision)    FUNCTION     T  CREATE FUNCTION rutas.formula(i integer, l1 double precision, lon1 double precision, l2 double precision, lon2 double precision) RETURNS void
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
 ?   DROP FUNCTION rutas.formula(i integer, l1 double precision, lon1 double precision, l2 double precision, lon2 double precision);
       rutas       postgres    false    18            ?            1259    57922    cliente    TABLE     ?   CREATE TABLE public.cliente (
    id integer NOT NULL,
    nombre character varying,
    latitud double precision,
    longitud double precision
);
    DROP TABLE public.cliente;
       public         postgres    false            ?            1259    57920    cliente_id_seq    SEQUENCE     ?   CREATE SEQUENCE public.cliente_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;
 %   DROP SEQUENCE public.cliente_id_seq;
       public       postgres    false    239            >           0    0    cliente_id_seq    SEQUENCE OWNED BY     A   ALTER SEQUENCE public.cliente_id_seq OWNED BY public.cliente.id;
            public       postgres    false    238            ?            1259    57933    graph    TABLE     ~   CREATE TABLE rutas.graph (
    id integer NOT NULL,
    source integer,
    target integer,
    distancia double precision
);
    DROP TABLE rutas.graph;
       rutas         postgres    false    18            ?            1259    57931    graph_id_seq    SEQUENCE     ?   CREATE SEQUENCE rutas.graph_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;
 "   DROP SEQUENCE rutas.graph_id_seq;
       rutas       postgres    false    241    18            ?           0    0    graph_id_seq    SEQUENCE OWNED BY     ;   ALTER SEQUENCE rutas.graph_id_seq OWNED BY rutas.graph.id;
            rutas       postgres    false    240            ?
           2604    57925 
   cliente id    DEFAULT     h   ALTER TABLE ONLY public.cliente ALTER COLUMN id SET DEFAULT nextval('public.cliente_id_seq'::regclass);
 9   ALTER TABLE public.cliente ALTER COLUMN id DROP DEFAULT;
       public       postgres    false    239    238    239            ?
           2604    57936    graph id    DEFAULT     b   ALTER TABLE ONLY rutas.graph ALTER COLUMN id SET DEFAULT nextval('rutas.graph_id_seq'::regclass);
 6   ALTER TABLE rutas.graph ALTER COLUMN id DROP DEFAULT;
       rutas       postgres    false    241    240    241            5          0    57922    cliente 
   TABLE DATA               @   COPY public.cliente (id, nombre, latitud, longitud) FROM stdin;
    public       postgres    false    239   ?;       7          0    57933    graph 
   TABLE DATA               =   COPY rutas.graph (id, source, target, distancia) FROM stdin;
    rutas       postgres    false    241   ?=       @           0    0    cliente_id_seq    SEQUENCE SET     =   SELECT pg_catalog.setval('public.cliente_id_seq', 15, true);
            public       postgres    false    238            A           0    0    graph_id_seq    SEQUENCE SET     :   SELECT pg_catalog.setval('rutas.graph_id_seq', 1, false);
            rutas       postgres    false    240            ?
           2606    57930    cliente cliente_pkey 
   CONSTRAINT     R   ALTER TABLE ONLY public.cliente
    ADD CONSTRAINT cliente_pkey PRIMARY KEY (id);
 >   ALTER TABLE ONLY public.cliente DROP CONSTRAINT cliente_pkey;
       public         postgres    false    239            ?
           2606    57938    graph graph_pkey 
   CONSTRAINT     M   ALTER TABLE ONLY rutas.graph
    ADD CONSTRAINT graph_pkey PRIMARY KEY (id);
 9   ALTER TABLE ONLY rutas.graph DROP CONSTRAINT graph_pkey;
       rutas         postgres    false    241            5     x?ER?j?@]K_?H????lL??B?e7Y?re??~}???.?Ĉ3?	?K???<ki ?&aҔ?	̡yPyD???l??ŭ??u^???@e$bϐYA???J??IZj??k9??S?V?e?dD?I,??a?\???<8?%?????yg3sVU?,?w?fR$f??J?:,}9??a8?K????))??D???????PZ???mx???OYvdJ??-??$)??I??[k?)??e??r?LH#??r??"???z?u?^ƵL??r????^???IRS&?#?!{$?????[?_?V??E??1P?e8Ì);X??-??f9??G??o}?A$qg?d??^?9????? M?ֹ{????????l4E??(??(?J?@?,???2_7?~?V?ʶ???*??d? ???D???????-Jw?S???Vh?C???n(??8K????!???㒩\?/???/UJ??=ne?????MrlK?s??/͡????n???8M??Cq$ț?= ?XfhDw?i?|l?????{      7   ?  x?}U??1??b??>zq?u???`aR ???G?~"NdD??,q??????#??;??t??Ɔ??g?Z&!?%Ңׁ???'1IFk?獩X??y??b?XS???2ye??@??JRKr?eB??È?*1UwPF??.????y:??k?l'D??Z????????I@?A?a?I1?e?T???(u???5t;a?J(4t+?L"b???'???;??b???L;???螨?Ik??Q?vWF??W????????	??p?m ?q?|%?K?֫΋?֫O??߽????K'3F?@D??euU z!??)DYp?:??^55?W9b?3<?T%۠?q5p?+2Z o?yg???(??P?:j<?X]???,?8?????gT??????ģ'T??????~?????eU?!q`vw?&c&?6??r????|?Qر.??'?????Mx?+o?n?F??χ?G1??=?E??a?x?Jp???3???@????f?jFeM?
p???'8?g?~???A???sX?u?g?I1?+r?E????liLU?f???pX???????f??T?n??+j5??ݜV3?91??bF?ӔV3??	??}z?jF؛GW3???xK?????[:?|?4????h?ξ??{?_??O?     