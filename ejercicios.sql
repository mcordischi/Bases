--Preguntas



-- Extras

ALTER TABLE G25_usuario
MODIFY (borrado DEFAULT 'NO');


--------------------------------------------------------------------
---------------------- Punto 1  ------------------------------------
--------------------------------------------------------------------



--Restricciones de dominio a categoria
ALTER TABLE G25_usuario
ADD CONSTRAINT RD_categoria
CHECK (categoria IN ('principiante','intermedio','senior'));

--Valor por default de categoria
ALTER TABLE G25_usuario
MODIFY (categoria DEFAULT 'principiante');



--Tabla con cantidad de comentarios
CREATE TABLE G25_comentarios_user(
	cod_usuario		 VARCHAR(20),
	ultimo_comentario DATE,
	cant_comentarios NUMERIC(10,0)
);

ALTER TABLE G25_comentarios_user
ADD CONSTRAINT pk_comentarios_user
	PRIMARY KEY(cod_usuario);

ALTER TABLE G25_comentarios_user
ADD CONSTRAINT fk_comentarios_user
	FOREIGN KEY(cod_usuario) REFERENCES G25_usuario(cod_usuario) ON DELETE CASCADE;
	
CREATE OR REPLACE TRIGGER G25_contador_comentarios	
AFTER INSERT ON G25_comentario
FOR EACH ROW
BEGIN
	DECLARE
	cont	INT;
BEGIN
	SELECT cant_comentarios into cont FROM G25_comentarios_user WHERE cod_usuario=:NEW.cod_usuario;
	cont:= cont+1;
	UPDATE  G25_comentarios_user SET cant_comentarios=cont WHERE cod_usuario=:NEW.cod_usuario;
	IF (cont = 50) THEN
		UPDATE  G25_usuario SET categoria='senior' WHERE cod_usuario=:NEW.cod_usuario;
	ELSIF (cont = 10) THEN
		UPDATE G25_usuario SET categoria='intermedio' WHERE cod_usuario=:NEW.cod_usuario;
	END IF;
END;
END;
/

--Agrega tupla en contador de comentarios cuando se da de alta en usuario
CREATE OR REPLACE TRIGGER G25_inic_contador_comentarios
AFTER INSERT ON G25_usuario
FOR EACH ROW
BEGIN
	INSERT INTO G25_comentarios_user VALUES (:NEW.cod_usuario,sysdate,0);
END;
/

---*** SOLUCION VIEJA ***---

-- Nota: Por problemas con tabla mutante, se generan dos triggers
----------------------------

--creación de tabla temporal
-- Por eficiencia no se genera con RIR
CREATE TABLE G25_temp_comentario (
	cod_usuario			VARCHAR(20)
	);

--Trigger que genera en tabla temporal
CREATE OR REPLACE TRIGGER G25_categoria_usuario_1
BEFORE INSERT ON G25_comentario
FOR EACH ROW
BEGIN
	INSERT INTO G25_temp_comentario VALUES (:NEW.cod_usuario);
END;
/
--Trigger que chequea datos
CREATE OR REPLACE TRIGGER G25_categoria_usuario_2
AFTER INSERT ON comentario
BEGIN
	DECLARE
	cur CURSOR FOR SELECT * FROM G25_temp_comentario;
	dato	G25_comentario.cod_usuario%type;
	cuenta	INTEGER;
	BEGIN
		OPEN cur;
		LOOP
			FETCH cur INTO dato;
			EXIT WHEN cur%notfound;
			SELECT COUNT('X') INTO cuenta FROM G25_comentario WHERE cod_usuario=dato;
			IF (cuenta > 50) THEN
				UPDATE  G25_usuario(categoria) SET ('avanzado') WHERE cod_usuario=dato;
			ELSIF (cuenta > 10) THEN
				UPDATE G25_usuario(categoria) SET ('intermedio') WHERE cod_usuario=dato;
			ELSE
				UPDATE G25_usuario(categoria) SET ('principiante') WHERE cod_usuario=dato;
			END IF;
		END LOOP;
		DELETE FROM aux_comentario ;
	END;
END;
/









--------------------------------------------------------------------
---------------------- Punto 2  ------------------------------------
--------------------------------------------------------------------


-- Chequeo de amistad con otra persona
ALTER TABLE G25_amigo
ADD CONSTRAINT check_invitacion
CHECK (cod_usuario_invitado <> cod_usuario);


--Tabla que almacena contador de amigos
CREATE TABLE G25_cant_amigos(
	cod_usuario			VARCHAR(20),
	amigos				NUMERIC(3,0)
	);

ALTER TABLE G25_cant_amigos
ADD CONSTRAINT fk_cod_usuario
FOREIGN KEY (cod_usuario) REFERENCES G25_usuario(cod_usuario) ON DELETE CASCADE ;

ALTER TABLE G25_cant_amigos
ADD CONSTRAINT pk_cod_usuario
PRIMARY KEY (cod_usuario) ;

	
-- Valor default para cantidad amigos
ALTER TABLE G25_cant_amigos
	MODIFY (amigos DEFAULT 0) ;
	
-- Valor maximo para amigos	de cada usuario
ALTER TABLE G25_cant_amigos
	ADD CONSTRAINT cant_max_amigos
		CHECK (amigos<=500);

		
--Actualiza cantidad de amigos cuando se agrega a tabla de amigos		
CREATE OR REPLACE TRIGGER G25_agregar_amigo
AFTER INSERT ON G25_amigo
FOR EACH ROW
BEGIN
	UPDATE G25_cant_amigos SET amigos=amigos+1 WHERE cod_usuario=:NEW.cod_usuario OR cod_usuario=:NEW.cod_usuario_invitado ;
END;
/
--Actualiza cantidad de amigos cuando se elimina de tabla de amigos		
CREATE OR REPLACE TRIGGER G25_eliminar_amigo
AFTER DELETE ON G25_amigo
FOR EACH ROW
BEGIN
	UPDATE G25_cant_amigos SET amigos=amigos-1 WHERE cod_usuario=:OLD.cod_usuario OR cod_usuario=:OLD.cod_usuario_invitado ;
END;
/
	--Inicializa tabla de cantidad de amigos ante alta de usuario
	CREATE OR REPLACE TRIGGER G25_inic_cant_amigos
	AFTER INSERT ON G25_usuario
	FOR EACH ROW
	BEGIN
		INSERT INTO G25_cant_amigos(cod_usuario,amigos) VALUES (:NEW.cod_usuario,0);
	END;
	/




--------------------------------------------------------------------
---------------------- Punto 3  ------------------------------------
--------------------------------------------------------------------

ALTER TABLE G25_invitacion
	MODIFY (acepta DEFAULT 'NO');

CREATE OR REPLACE TRIGGER G25_confirmar_alta
BEFORE INSERT ON G25_usuario
FOR EACH ROW
BEGIN
	DECLARE
	aceptar G25_invitacion.acepta%type;
BEGIN
	SELECT acepta INTO aceptar 
		FROM G25_invitacion
		WHERE	email=:NEW.email;
	IF (aceptar = 'SI') THEN
		RAISE_APPLICATION_ERROR(-20005,'Email ya existente');
	ELSE
		UPDATE G25_invitacion SET acepta='SI' WHERE email=:NEW.email;
	END IF;
	EXCEPTION
	WHEN OTHERS THEN
		RAISE_APPLICATION_ERROR(-20005,'Email ya existente');
END;
END;
/




/**SOLUCION VIEJA

-- Nota: el sistema se idea para que un usuario, al registrarse, debe
-- tener su código de registro, el cual será su próximo cod_usuario. 
-- El sistema para chequear debe asegurarse que no exista el usuario
-- (ya automático) y que el código esté en la lista de invitaciones.
---------------------------------------------------------------------


CREATE OR REPLACE TRIGGER G25_confirmar_alta_old
BEFORE INSERT ON G25_usuario
FOR EACH ROW
BEGIN
	DECLARE
	cuenta	INTEGER;
BEGIN
	SELECT COUNT('X') INTO cuenta FROM G25_invitacion WHERE cod_usuario_invitado= :NEW.cod_usuario;
	IF (cuenta > 0) THEN
		RAISE_APPLICATION_ERROR(-20001,'Usuario no invitado');
	END IF;
END;
/
**/


--------------------------------------------------------------------
---------------------- Punto 4  ------------------------------------
--------------------------------------------------------------------


ALTER TABLE G25_tipo_actividad
ADD CONSTRAINT G25_RD_nombre
CHECK (nombre IN ('social','deportiva','cultural'));


-------------------------------------------------------------------
---------------------- Punto 5  ------------------------------------
--------------------------------------------------------------------
/*5. Un usuario solo podrá visitar paseos donde pueda desarrollar actividades de su interés o bien paseos 
que no tienen ninguna actividad asociada. Si el usuario no puede realizar una visita porque no se 
desarrollan las actividades de su interés deberá quedar registrado en una tabla Paseo_Fallido con los 
siguientes datos: usuario, todas las actividades de interés del usuario en cuestión, nombre del paseo,
las actividades del paseo que quería realizar y fecha.*/


/*--TODO--TODO--TODO--TODO--TODO--TODO--TODO--TODO--TODO--TODO--TODO--TODO--TODO--TODO--TODO--TODO--TODO--TODO*/
-- Terminar agregando en tabla todas las actividades del usuario y del lugar

DROP TABLE G25_paseo_fallido ;
DROP TABLE G25_visita_fallida_tmp;

CREATE TABLE G25_paseo_fallido(
	cod_fallo		NUMERIC(10,0),
	cod_usuario		VARCHAR(20),
	cod_paseo		NUMERIC(10,0),
	cod_ciudad		NUMERIC(10,0),
	fecha			DATE
);

CREATE TABLE G25_visita_fallida_tmp(
	cod_visita		VARCHAR(20)
);


-- Nota: se decidi? poner como pk solo un codigo para simplicidad en la clave(eficiencia)	
ALTER TABLE G25_paseo_fallido
	ADD CONSTRAINT pk_paseo_fallido
		PRIMARY KEY (cod_fallo);
		
ALTER TABLE G25_paseo_fallido
	ADD CONSTRAINT fk_paseo_fallido_usuario
		FOREIGN KEY (cod_usuario) REFERENCES G25_usuario(cod_usuario);
		
ALTER TABLE G25_paseo_fallido
	ADD CONSTRAINT fk_paseo_fallido_paseo
		FOREIGN KEY (cod_paseo,cod_ciudad) REFERENCES G25_paseo(cod_paseo,cod_ciudad);
		
-- Auto incremento para paseo_fallido		
DROP SEQUENCE G25_ctr_pk_paseo_fallido ;
CREATE SEQUENCE G25_ctr_pk_paseo_fallido		
START WITH 1
INCREMENT BY 1;

CREATE OR REPLACE TRIGGER G25_confirmacion_paseo
BEFORE INSERT ON G25_visita
FOR EACH ROW
BEGIN
	DECLARE
		cuenta INTEGER;
BEGIN
	--chequear que haya actividades relacionadas al paseo
	SELECT COUNT('X') INTO cuenta FROM G25_realizada_en WHERE  cod_paseo= :NEW.cod_paseo AND cod_ciudad= :NEW.cod_ciudad; 
	IF (cuenta > 0) THEN
		--chequear que haya actividades en comun entre el usuario y el paseo
		SELECT COUNT('X') INTO cuenta
	    FROM (
		      SELECT id_actividad FROM G25_realizada_en WHERE cod_paseo= :NEW.cod_paseo AND cod_ciudad= :NEW.cod_ciudad
			  INTERSECT
			  SELECT id_actividad FROM G25_interesa_act WHERE cod_usuario= :NEW.cod_usuario
			  );
		IF (cuenta == 0) THEN
			--Paseo fallido
			/* FALTA : armar una lista concatenada de todas las actividades de interés del usuario en cuestión,
                       y otra con todas las actividades del paseo que quería realizar */
			
			INSERT INTO G25_paseo_fallido VALUES (ctr_pk_paseo_fallido.nextVal,:NEW.cod_usuario,:NEW.cod_paseo,:NEW.cod_ciudad,SYSDATE);
			--Evita tabla mutante
			INSERT INTO G25_visita_fallida_tmp VALUES (:NEW.cod_visita);
			--TODO PROBAR QUE GRABE
			--RAISE_APPLICATION_ERROR(-20002,'Paseo prohibido');
		END IF;
	END IF;
END;	
END;
/

CREATE OR REPLACE TRIGGER G25_confirmacion_paseo_st
AFTER INSERT ON G25_VISITA
DECLARE
	I G25_visita_fallida_tmp%ROWTYPE;
BEGIN
	FOR I IN ( SELECT * FROM G25_visita_fallida_tmp ) LOOP
		DELETE G25_VISITA WHERE cod_visita = I.cod_visita;
	END LOOP;
	DELETE FROM G25_visita_fallida_tmp;
END;
/


--------------------------------------------------------------------
---------------------- Punto 6  ------------------------------------
--------------------------------------------------------------------
-- Nota: Se supondrá que el orden de insercion en la tabla es: 
-- Comentario -> Original o respuesta -> en_muro o visita
-- Por lo que se hace un trigger para cada tabla chequeando que el dato
-- se encuentre en su tabla superior
---------------------------------------------------------------------


CREATE OR REPLACE TRIGGER G25_corresp_original
AFTER INSERT ON G25_original
FOR EACH ROW
BEGIN
	DECLARE
	cuenta INT;
BEGIN
	SELECT COUNT('X') INTO cuenta FROM G25_comentario C WHERE (C.cod_comentario = :NEW.cod_comentario) AND (C.tipo = 'original') ;
	IF (cuenta=0) THEN
		RAISE_APPLICATION_ERROR(-20003,'Error de jerarquia original');
	END IF;
END;
END;
/


CREATE OR REPLACE TRIGGER G25_corresp_respuesta
AFTER INSERT ON G25_respuesta
FOR EACH ROW
BEGIN
	DECLARE
	cuenta INT;
BEGIN
	SELECT COUNT('X') INTO cuenta FROM G25_comentario C WHERE (C.cod_comentario = :NEW.cod_comentario) AND (C.tipo = 'respuesta') ;
	IF (cuenta=0) THEN
		RAISE_APPLICATION_ERROR(-20004,'Error de jerarquia respuesta');
	END IF;
END;
END;
/



CREATE OR REPLACE TRIGGER G25_corresp_en_muro
AFTER INSERT ON G25_en_muro
FOR EACH ROW
BEGIN
	DECLARE
	cuenta INT;
BEGIN
	SELECT COUNT('X') INTO cuenta FROM G25_original O WHERE (O.cod_comentario = :NEW.cod_comentario) AND (C.tipo = 'en muro') ;
	IF (cuenta=0) THEN
		RAISE_APPLICATION_ERROR(-20005,'Error de jerarquia en muro');
	END IF;
END;
END;
/



CREATE OR REPLACE TRIGGER G25_corresp_en_visita
AFTER INSERT ON G25_en_visita
FOR EACH ROW
BEGIN
	DECLARE
	cuenta INT;
BEGIN
	SELECT COUNT('X') INTO cuenta FROM G25_original O WHERE (O.cod_comentario = :NEW.cod_comentario) AND (C.tipo = 'en visita') ;
	IF (cuenta=0) THEN
		RAISE_APPLICATION_ERROR(-20006,'Error de jerarquia en visita');
	END IF;
END;
END;
/


--------------------------------------------------------------------
---------------------- Punto 7  ------------------------------------
--------------------------------------------------------------------

 

SELECT *
FROM
	(SELECT * 
		FROM G25_realizada_en 
		WHERE id_actividad IN (SELECT id_actividad 
								FROM G25_actividad 
								WHERE nombre_actividad LIKE 'caminata%' ) 
				AND cod_ciudad = (SELECT cod_ciudad 
									FROM G25_ciudad 
									WHERE nombre_ciudad ='Tandil')
	)
	NATURAL JOIN (SELECT nombre_paseo,cod_paseo,cod_ciudad FROM G25_paseo)	
	NATURAL JOIN (SELECT id_actividad,nombre_actividad,elemento_necesario FROM G25_actividad )
		
	;
/* TODO Buscar foto	*/



--------------------------------------------------------------------
---------------------- Punto 8  ------------------------------------
--------------------------------------------------------------------


CREATE TABLE G25_comentarios_edad(
	mes	CHAR(2),
	ano	CHAR(4),
	grupo 	VARCHAR(7),
	cantidad NUMERIC(5,0)
);

ALTER TABLE G25_comentarios_edad
	ALTER cantidad SET DEFAULT 0 ;

ALTER TABLE G25_comentarios_edad
	ADD CONSTRAINT RD_grupo
		CHECK (grupo IN ('ninos','jovenes','adultos'));

ALTER TABLE G25_comentarios_edad
	ADD CONSTRAINT pk_comentarios_edad
		PRIMARY KEY(mes,ano,grupo);


CREATE OR REPLACE TRIGGER G25_contador_com_edad
AFTER INSERT ON G25_comentario
FOR EACH ROW
BEGIN
	DECLARE
	fecha	DATE;
BEGIN
	SELECT fecha_nacimiento INTO fecha FROM usuario WHERE cod_usuario=:NEW.cod_usuario;
	fecha= sysdate-fecha;
	IF (extract(year from fecha)>21) THEN
		UPDATE TABLE G25_comentarios_edad SET cantidad=cantidad+1 WHERE mes=extract(month from sysdate) 
									AND ano=extract(month from sysdate) AND grupo='adultos';	
	ELSIF (extract(year from fecha)>14) THEN
		UPDATE TABLE G25_comentarios_edad SET cantidad=cantidad+1 WHERE mes=extract(month from sysdate) 
									AND ano=extract(month from sysdate) AND grupo='jovenes';	
	ELSE 
		UPDATE TABLE G25_comentarios_edad SET cantidad=cantidad+1 WHERE mes=extract(month from sysdate) 
									AND ano=extract(month from sysdate) AND grupo='ninos';	
	END IF;
END;
END;



--------------------------------------------------------------------
---------------------- Punto 9  ------------------------------------
--------------------------------------------------------------------

-- Tabla que almacena toda la informacion necesaria
CREATE TABLE G25_log_paseo(
	id_log		NUMERIC(10),
	cod_paseo	NUMERIC(10),
	cod_ciudad	NUMERIC(10),
	fecha		DATE,
	accion		VARCHAR(10),
	nombre_paseo	VARCHAR(150),
	descripcion	VARCHAR(255),
	cod_usuario	VARCHAR(20)
);

--secuencia para pk de logeo
CREATE SEQUENCE G25_pk_log_paseo		
START WITH 1
INCREMENT BY 1;


-- pk log_paseo
ALTER TABLE G25_log_paseo
	ADD CONSTRAINT pk_log_paseo
		PRIMARY KEY(id_log);

-- Restriccion de dominio para la accion
ALTER TABLE G25_log_paseo
	ADD CONSTRAINT RD_accion
		CHECK(accion IN ('DELETE','INSERT','UPDATE'));



CREATE OR REPLACE TRIGGER G25_logging_paseo
AFTER INSERT OR DELETE OR UPDATE ON G25_paseo
BEGIN
	IF INSERTING THEN
		INSERT INTO G25_log_paseo(cod_paseo,cod_ciudad,fecha,accion,nombre_paseo,descripcion,cod_usuario) 
			VALUES (:NEW.cod_paseo,:NEW.cod_ciudad,sysdate,'INSERT',:NEW.nombre_paseo,:NEW.descripcion,:NEW.cod_usuario);
	ELSIF DELETING THEN		
		INSERT INTO G25_log_paseo(cod_paseo,cod_ciudad,fecha,accion,nombre_paseo,descripcion,cod_usuario) 
			VALUES (:OLD.cod_paseo,:OLD.cod_ciudad,sysdate,'DELETE',:OLD.nombre_paseo,:OLD.descripcion,:OLD.cod_usuario);
	ELSIF UPDATING THEN
		INSERT INTO G25_log_paseo(cod_paseo,cod_ciudad,fecha,accion,nombre_paseo,descripcion,cod_usuario) 
			VALUES (:NEW.cod_paseo,:NEW.cod_ciudad,sysdate,'UPDATE',:OLD.nombre_paseo,:OLD.descripcion,:OLD.cod_usuario);
END;


--------------------------------------------------------------------
---------------------- Punto 10  ------------------------------------
--------------------------------------------------------------------


CREATE OR REPLACE PROCEDURE G25_paseo_recovery (IN fecha_max DATE) AS
	cur CURSOR;
	accion	G25_log_paseo%ROWTYPE;
BEGIN
	OPEN cur FOR (SELECT * FROM G25_log_paseo WHERE fecha > fecha_max ORDER BY fecha);
	IF cur%isopen THEN
		LOOP
			FETCH cur INTO accion
			EXIT WHEN cur%notfound;
			IF ( accion.accion = 'INSERT'	)	THEN
				DELETE FROM G25_paseo WHERE cod_paseo=accion.cod_paseo AND cod_ciudad=accion.cod_ciudad;
			ELSIF ( accion.accion = 'DELETE') THEN
				INSERT INTO G25_paseo(cod_ciudad,cod_paseo,nombre_paseo,descripcion,cod_usuario) 
							VALUES (accion.cod_ciudad,accion.cod_paseo,accion.nombre_paseo,accion.descripcion,accion.cod_usuario);
			ELSE 
				UPDATE G25_paseo SET nombre_paseo=accion.nombre_paseo AND descripcion=accion.descripcion AND cod_usuario=accion.cod_usuario
							WHERE cod_paseo=accion.cod_paseo AND cod_ciudad=accion.cod_ciudad;
			END IF;
		END LOOP;
	END IF;
END;
/