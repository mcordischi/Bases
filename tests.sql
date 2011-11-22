-- Ej 1 --



-- Ej 2 --

SELECT MAX(COUNT('X')
	FROM G25_amigo;
-- DEBE devolver <500 luego de datos

SELECT * 
	FROM G25_amigo
	WHERE cod_usuario=cod_usuario_invitado;
-- Debe devolver vacio luego de completar con datos



-- Ej 3 --

INSERT INTO G25_invitacion(cod_usuario,email) VALUES ('1','tincho@gmail.com');
INSERT INTO G25_usuario (cod_usuario,nombres,apellidos,email,nick) VALUES ('Test','Briar','Hopkins','tincho@gmail.com','Ciara');
--Permitido
INSERT INTO G25_usuario (cod_usuario,nombres,apellidos,email,nick) VALUES ('Test2','Briar','Hopkins','tincho@gmail.com','Ciara');
--fallido
INSERT INTO G25_usuario (cod_usuario,nombres,apellidos,email,nick) VALUES ('Test3','Briar','Hopkins','dsds@gmail.com','Ciara');
--fallido



-- Ej 4 --

SELECT * 
	FROM G25_actividad
	WHERE (id_tipo_act <> 'social') AND
		(id_tipo_act <> 'deportiva') AND
		(id_tipo_act <> 'cultural') ;
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