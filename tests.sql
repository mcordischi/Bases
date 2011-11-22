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

INSERT INTO G25_invitacion(cod_usuario,email) VALUES ('1','tinchofm@gmail.com');
INSERT INTO G25_usuario (cod_usuario,nombres,apellidos,email,nick) VALUES ('Test','Briar','Hopkins','tinchofm@gmail.com','Ciara');
--Permitido
INSERT INTO G25_usuario (cod_usuario,nombres,apellidos,email,nick) VALUES ('Test2','Briar','Hopkins','tinchofm@gmail.com','Ciara');
--fallido
INSERT INTO G25_usuario (cod_usuario,nombres,apellidos,email,nick) VALUES ('Test3','Briar','Hopkins','dsds@gmail.com','Ciara');
--fallido

