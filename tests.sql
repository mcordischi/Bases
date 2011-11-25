----------
-- Ej 1 --
----------

 /*TESTEAR*/
--Hubo cambios

/* CHEQUEADO -- FUNCIONA */
--chequear en distintos momentos
SELECT categoria
	FROM G25_usuario
		WHERE cod_usuario='1';

-- DEBE DEVOLVER 'principiante'
INSERT INTO G25_comentario (cod_usuario,texto,tipo,cod_comentario) VALUES ('1','natoque penatibus et magnis dis parturient montes, nascetur ridiculus','Original','10001');
INSERT INTO G25_comentario (cod_usuario,texto,tipo,cod_comentario) VALUES ('1','pede. Praesent eu dui. Cum','Original','10002');
INSERT INTO G25_comentario (cod_usuario,texto,tipo,cod_comentario) VALUES ('1','auctor non, feugiat nec,','Respuesta','10003');
INSERT INTO G25_comentario (cod_usuario,texto,tipo,cod_comentario) VALUES ('1','Aenean eget','Respuesta','10004');
INSERT INTO G25_comentario (cod_usuario,texto,tipo,cod_comentario) VALUES ('1','tempor arcu. Vestibulum ut eros non enim commodo','Original','10005');
INSERT INTO G25_comentario (cod_usuario,texto,tipo,cod_comentario) VALUES ('1','Lorem ipsum dolor sit amet, consectetuer adipiscing elit. Etiam laoreet,','Respuesta','10006');
INSERT INTO G25_comentario (cod_usuario,texto,tipo,cod_comentario) VALUES ('1','lorem','Respuesta','10007');
INSERT INTO G25_comentario (cod_usuario,texto,tipo,cod_comentario) VALUES ('1','euismod enim. Etiam gravida molestie arcu. Sed eu nibh','Respuesta','10008');
INSERT INTO G25_comentario (cod_usuario,texto,tipo,cod_comentario) VALUES ('1','sed, sapien. Nunc','Respuesta','10009');
INSERT INTO G25_comentario (cod_usuario,texto,tipo,cod_comentario) VALUES ('1','Quisque tincidunt pede ac urna. Ut tincidunt','Respuesta','10010');
INSERT INTO G25_comentario (cod_usuario,texto,tipo,cod_comentario) VALUES ('1','nec tempus scelerisque, lorem','Original','10011');
INSERT INTO G25_comentario (cod_usuario,texto,tipo,cod_comentario) VALUES ('1','mauris elit, dictum eu, eleifend nec,','Respuesta','10012');
INSERT INTO G25_comentario (cod_usuario,texto,tipo,cod_comentario) VALUES ('1','magna. Nam ligula elit, pretium et, rutrum non,','Original','10013');
INSERT INTO G25_comentario (cod_usuario,texto,tipo,cod_comentario) VALUES ('1','aliquam adipiscing lacus. Ut','Respuesta','10014');
--DEBE DEVOLVER 'intermedio'
INSERT INTO G25_comentario (cod_usuario,texto,tipo,cod_comentario) VALUES ('1','enim, condimentum eget, volutpat ornare, facilisis eget, ipsum. Donec','Original','10015');
INSERT INTO G25_comentario (cod_usuario,texto,tipo,cod_comentario) VALUES ('1','Nunc ac sem ut dolor dapibus gravida. Aliquam tincidunt,','Respuesta','10016');
INSERT INTO G25_comentario (cod_usuario,texto,tipo,cod_comentario) VALUES ('1','placerat. Cras dictum ultricies ligula. Nullam enim. Sed nulla ante,','Original','10017');
INSERT INTO G25_comentario (cod_usuario,texto,tipo,cod_comentario) VALUES ('1','ultrices, mauris ipsum porta elit, a','Original','10018');
INSERT INTO G25_comentario (cod_usuario,texto,tipo,cod_comentario) VALUES ('1','commodo hendrerit. Donec','Respuesta','10019');
INSERT INTO G25_comentario (cod_usuario,texto,tipo,cod_comentario) VALUES ('1','Cras vehicula aliquet libero. Integer in magna. Phasellus','Respuesta','10020');
INSERT INTO G25_comentario (cod_usuario,texto,tipo,cod_comentario) VALUES ('1','non arcu. Vivamus sit amet risus. Donec egestas. Aliquam nec','Respuesta','10021');
INSERT INTO G25_comentario (cod_usuario,texto,tipo,cod_comentario) VALUES ('1','sed dictum','Original','10022');
INSERT INTO G25_comentario (cod_usuario,texto,tipo,cod_comentario) VALUES ('1','dui quis accumsan convallis, ante lectus convallis est,','Original','10023');
INSERT INTO G25_comentario (cod_usuario,texto,tipo,cod_comentario) VALUES ('1','Aliquam vulputate ullamcorper magna.','Original','10024');
INSERT INTO G25_comentario (cod_usuario,texto,tipo,cod_comentario) VALUES ('1','lectus, a sollicitudin orci sem eget massa.','Original','10025');
INSERT INTO G25_comentario (cod_usuario,texto,tipo,cod_comentario) VALUES ('1','In tincidunt congue','Respuesta','10026');
INSERT INTO G25_comentario (cod_usuario,texto,tipo,cod_comentario) VALUES ('1','sodales nisi magna','Respuesta','10027');
INSERT INTO G25_comentario (cod_usuario,texto,tipo,cod_comentario) VALUES ('1','Sed eu nibh vulputate mauris sagittis placerat. Cras dictum','Original','10028');
INSERT INTO G25_comentario (cod_usuario,texto,tipo,cod_comentario) VALUES ('1','egestas lacinia. Sed congue, elit sed consequat','Respuesta','10029');
INSERT INTO G25_comentario (cod_usuario,texto,tipo,cod_comentario) VALUES ('1','consectetuer adipiscing','Original','10030');
INSERT INTO G25_comentario (cod_usuario,texto,tipo,cod_comentario) VALUES ('1','eu odio tristique pharetra. Quisque','Original','10031');
INSERT INTO G25_comentario (cod_usuario,texto,tipo,cod_comentario) VALUES ('1','sagittis. Duis gravida. Praesent eu','Respuesta','10032');
INSERT INTO G25_comentario (cod_usuario,texto,tipo,cod_comentario) VALUES ('1','augue ac ipsum. Phasellus vitae mauris','Respuesta','10033');
INSERT INTO G25_comentario (cod_usuario,texto,tipo,cod_comentario) VALUES ('1','in consequat enim diam vel arcu. Curabitur ut odio vel','Respuesta','10034');
INSERT INTO G25_comentario (cod_usuario,texto,tipo,cod_comentario) VALUES ('1','orci luctus et ultrices posuere cubilia Curae; Donec tincidunt. Donec','Respuesta','10035');
INSERT INTO G25_comentario (cod_usuario,texto,tipo,cod_comentario) VALUES ('1','tellus sem mollis','Original','10036');
INSERT INTO G25_comentario (cod_usuario,texto,tipo,cod_comentario) VALUES ('1','mi tempor lorem, eget mollis lectus','Original','10037');
INSERT INTO G25_comentario (cod_usuario,texto,tipo,cod_comentario) VALUES ('1','auctor ullamcorper, nisl arcu iaculis enim, sit amet ornare','Original','10038');
INSERT INTO G25_comentario (cod_usuario,texto,tipo,cod_comentario) VALUES ('1','enim. Mauris quis turpis vitae purus gravida','Respuesta','10039');
INSERT INTO G25_comentario (cod_usuario,texto,tipo,cod_comentario) VALUES ('1','turpis. Nulla aliquet. Proin','Respuesta','10040');
INSERT INTO G25_comentario (cod_usuario,texto,tipo,cod_comentario) VALUES ('1','rutrum urna, nec luctus felis purus','Original','10041');
INSERT INTO G25_comentario (cod_usuario,texto,tipo,cod_comentario) VALUES ('1','massa rutrum magna. Cras convallis convallis dolor. Quisque tincidunt pede','Original','10042');
INSERT INTO G25_comentario (cod_usuario,texto,tipo,cod_comentario) VALUES ('1','leo. Vivamus nibh dolor, nonummy ac, feugiat non,','Original','10043');
INSERT INTO G25_comentario (cod_usuario,texto,tipo,cod_comentario) VALUES ('1','tincidunt tempus risus. Donec egestas. Duis ac arcu.','Original','10044');
INSERT INTO G25_comentario (cod_usuario,texto,tipo,cod_comentario) VALUES ('1','enim. Sed','Original','10045');
INSERT INTO G25_comentario (cod_usuario,texto,tipo,cod_comentario) VALUES ('1','consectetuer mauris id sapien. Cras dolor dolor, tempus non,','Respuesta','10046');
INSERT INTO G25_comentario (cod_usuario,texto,tipo,cod_comentario) VALUES ('1','leo, in lobortis tellus justo sit amet nulla.','Original','10047');
INSERT INTO G25_comentario (cod_usuario,texto,tipo,cod_comentario) VALUES ('1','quam','Original','10048');
INSERT INTO G25_comentario (cod_usuario,texto,tipo,cod_comentario) VALUES ('1','lorem, sit amet','Respuesta','10049');
INSERT INTO G25_comentario (cod_usuario,texto,tipo,cod_comentario) VALUES ('1','adipiscing elit. Etiam laoreet, libero et tristique','Original','10050');
INSERT INTO G25_comentario (cod_usuario,texto,tipo,cod_comentario) VALUES ('1','lectus. Nullam suscipit, est ac facilisis facilisis, magna','Respuesta','10051');
INSERT INTO G25_comentario (cod_usuario,texto,tipo,cod_comentario) VALUES ('1','placerat velit. Quisque varius. Nam porttitor scelerisque neque. Nullam','Original','10052');
INSERT INTO G25_comentario (cod_usuario,texto,tipo,cod_comentario) VALUES ('1','velit egestas lacinia. Sed congue, elit sed consequat auctor, nunc','Respuesta','10053');
INSERT INTO G25_comentario (cod_usuario,texto,tipo,cod_comentario) VALUES ('1','felis purus ac tellus.','Respuesta','10054');
INSERT INTO G25_comentario (cod_usuario,texto,tipo,cod_comentario) VALUES ('1','tempus mauris','Respuesta','10055');
INSERT INTO G25_comentario (cod_usuario,texto,tipo,cod_comentario) VALUES ('1','torquent per conubia nostra, per','Original','10056');
INSERT INTO G25_comentario (cod_usuario,texto,tipo,cod_comentario) VALUES ('1','Donec luctus aliquet odio. Etiam ligula tortor, dictum eu, placerat','Original','10057');
INSERT INTO G25_comentario (cod_usuario,texto,tipo,cod_comentario) VALUES ('1','eu lacus. Quisque imperdiet, erat nonummy','Respuesta','10058');
INSERT INTO G25_comentario (cod_usuario,texto,tipo,cod_comentario) VALUES ('1','dapibus rutrum, justo. Praesent luctus.','Original','10059');
INSERT INTO G25_comentario (cod_usuario,texto,tipo,cod_comentario) VALUES ('1','Etiam gravida molestie arcu. Sed eu nibh vulputate mauris sagittis','Respuesta','10060');
--DEBE Devolver 'senior'


----------
-- Ej 2 --
----------
/* CHEQUEADO -- FUNCIONA */
-- 2da prueba -> OK
SELECT MAX(amigos)
	FROM G25_cant_amigos;
-- DEBE devolver <500 luego de datos

SELECT * 
	FROM G25_amigo
	WHERE cod_usuario=cod_usuario_invitado;
-- Debe devolver vacio luego de completar con datos


----------
-- Ej 3 --
----------
/* CHEQUEADO -- FUNCIONA */
INSERT INTO G25_invitacion(cod_usuario_invitado,email) VALUES ('1','tincho@gmail.com');
INSERT INTO G25_usuario (cod_usuario,nombres,apellidos,email,nick) VALUES ('Test','Briar','Hopkins','tincho@gmail.com','Ciara');
--Permitido
INSERT INTO G25_usuario (cod_usuario,nombres,apellidos,email,nick) VALUES ('Test2','Briar','Hopkins','tincho@gmail.com','Ciara');
--fallido
INSERT INTO G25_usuario (cod_usuario,nombres,apellidos,email,nick) VALUES ('Test3','Briar','Hopkins','dsds@gmail.com','Ciara');
--fallido


----------
-- Ej 4 --
----------
/*CHEQUEADO -- FUNCIONA*/
SELECT * 
	FROM G25_tipo_actividad
	WHERE (nombre <> 'social') AND
		(nombre <> 'deportiva') AND
		(nombre <> 'cultural') ;
-- Debe devolver vacio

----------
-- Ej 5 --
--TODO

----------
-- Ej 6 --
----------
/*CHEQUEADO -- FUNCIONA*/
INSERT INTO G25_comentario (cod_usuario,texto,tipo,cod_comentario) VALUES ('111','magna tellus faucibus leo, in lobortis tellus justo sit amet','Original','1');
INSERT INTO G25_original(cod_comentario,tipodeorig) VALUES('1','En muro');
INSERT INTO G25_comentario (cod_usuario,texto,tipo,cod_comentario) VALUES ('423','pretium aliquet, metus urna','Respuesta','1001');
INSERT INTO G25_respuesta(cod_comentario,cod_original) VALUES ('1001','1');
--Permitido
INSERT INTO G25_original VALUES('1001','En muro');
--Fallar

----------
-- Ej 7 --
----------
--Ver datos



----------
-- Ej 8 --
----------
/* CHEQUEADO -- FUNCIONA */
INSERT INTO G25_usuario (cod_usuario,nombres,apellidos,email,nick,fecha_nacimiento) VALUES ('XX','Briar','Hopkins','sit.amet.massa@non.edu','Ciara','01/01/1980');

INSERT INTO G25_comentario (cod_usuario,texto,tipo,cod_comentario) VALUES ('XX','at, iaculis quis, pede. Praesent eu','Original','1100');
INSERT INTO G25_original(cod_comentario,tipodeorig) VALUES (1100,'en_visita');
INSERT INTO G25_en_visita(cod_comentario,cod_visita) VALUES (1100,1);

----------
-- Ej 9 --
----------
/* CHEQUEADO -- FUNCIONA */
--Luego de cargar paseos de datos.sql
UPDATE G25_paseo SET descripcion='Muy bueno' WHERE cod_ciudad=2 AND cod_paseo=5;
DELETE FROM G25_paseo WHERE cod_ciudad=2 AND cod_paseo=5;


----------
-- Ej 10--
----------
/* CHEQUEADO-- FUNCIONA*/
--Se hizo cambio luego de test para correcto funcionamiento
--Realiza correctamente el procedimiento, ver si no se pisa con trigger ej 9
EXECUTE G25_paseo_recovery (sysdate-1);
