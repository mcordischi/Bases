-- Ej 1 --



-- Ej 2 --
/* CHEQUEADO -- FUNCIONA */
SELECT MAX(amigos)
	FROM G25_cant_amigos;
-- DEBE devolver <500 luego de datos

SELECT * 
	FROM G25_amigo
	WHERE cod_usuario=cod_usuario_invitado;
-- Debe devolver vacio luego de completar con datos



-- Ej 3 --
/* CHEQUEADO -- FUNCIONA */
INSERT INTO G25_invitacion(cod_usuario_invitado,email) VALUES ('1','tincho@gmail.com');
INSERT INTO G25_usuario (cod_usuario,nombres,apellidos,email,nick) VALUES ('Test','Briar','Hopkins','tincho@gmail.com','Ciara');
--Permitido
INSERT INTO G25_usuario (cod_usuario,nombres,apellidos,email,nick) VALUES ('Test2','Briar','Hopkins','tincho@gmail.com','Ciara');
--fallido
INSERT INTO G25_usuario (cod_usuario,nombres,apellidos,email,nick) VALUES ('Test3','Briar','Hopkins','dsds@gmail.com','Ciara');
--fallido



-- Ej 4 --
/*CHEQUEADO -- FUNCIONA*/
SELECT * 
	FROM G25_tipo_actividad
	WHERE (nombre <> 'social') AND
		(nombre <> 'deportiva') AND
		(nombre <> 'cultural') ;
-- Debe devolver vacio


-- Ej 5 --
--TODO


-- Ej 6 --

INSERT INTO G25_comentario (cod_usuario,texto,tipo,cod_comentario) VALUES ('423','pretium aliquet, metus urna','Respuesta','1001');
INSERT INTO G25_respuesta VALUES ('1001','1');
--Permitido
INSERT INTO G25_original VALUES('1001','En muro');
--Fallar


-- Ej 7 --

--Ver datos