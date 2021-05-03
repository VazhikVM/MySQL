/*База данных call-center содержит информации о сотрудниках компании,
 занимаемые должности, заработной плате. Информация в данной базе данных дает возможность получить полную 
 информацию при необходимости.
 В БД предоставленны предстваления по всем персональным данным сотрудников и заработной плате, а таже процедура и триггер*/

DROP DATABASE IF EXISTS `call-center`;
CREATE DATABASE `call-center`;

USE `call-center`;

DROP TABLE IF EXISTS `users`;
CREATE TABLE `users`(
id SERIAL PRIMARY KEY,
login VARCHAR(30) UNIQUE NOT NULL,
user_password VARCHAR(20) NOT NULL,
create_date DATETIME DEFAULT NOW());

ALTER TABLE users ADD INDEX (login);

DROP TABLE IF EXISTS `department`;
CREATE TABLE `department`(
id SERIAL PRIMARY KEY,
dep_name VARCHAR(30) NOT NULL);

DROP TABLE IF EXISTS `post`;
CREATE TABLE `post`(
id SERIAL PRIMARY KEY,
post_name VARCHAR(20) NOT NULL
);

DROP TABLE IF EXISTS `profiles`;
CREATE TABLE `profiles`(
id SERIAL PRIMARY KEY,
user_id BIGINT UNSIGNED NOT NULL,
name VARCHAR(15),
last_name VARCHAR(15) NOT NULL,
middle_name VARCHAR(15) NOT NULL,
date_bith DATE NOT NULL,
city VARCHAR(15) NOT NULL,
phone BIGINT UNSIGNED UNIQUE,
dep_id BIGINT UNSIGNED NOT NULL,
post_id BIGINT UNSIGNED NOT NULL,
date_begin DATETIME DEFAULT NOW(),
FOREIGN KEY (user_id) REFERENCES users(id),
FOREIGN KEY (dep_id) REFERENCES department(id),
FOREIGN KEY (post_id) REFERENCES post(id));

DROP TABLE IF EXISTS `salary`;
CREATE TABLE `salary`(
id SERIAL PRIMARY KEY,
post_id BIGINT UNSIGNED NOT NULL,
salary BIGINT UNSIGNED NOT NULL,
bonus BIGINT UNSIGNED NOT NULL,
FOREIGN KEY (post_id) REFERENCES post(id));

DROP TABLE IF EXISTS `passport_data`;
CREATE TABLE `passport_data`(
id SERIAL PRIMARY KEY,
user_id BIGINT UNSIGNED NOT NULL,
seria_pass BIGINT UNSIGNED NOT NULL,
number_pass BIGINT UNSIGNED NOT NULL,
what_give VARCHAR(300) NOT NULL,
date_give DATE NOT NULL,
FOREIGN KEY (user_id) REFERENCES users(id));

DROP TABLE IF EXISTS `project`;
CREATE TABLE `project`(
id SERIAL PRIMARY KEY,
project_name VARCHAR(20) NOT NULL,
project_director BIGINT UNSIGNED NOT NULL,
FOREIGN KEY (project_director) REFERENCES users(id));

DROP TABLE IF EXISTS `users_project`;
CREATE TABLE `users_project`(
id SERIAL PRIMARY KEY,
user_id BIGINT UNSIGNED NOT NULL,
proj_id BIGINT UNSIGNED NOT NULL,
FOREIGN KEY (user_id) REFERENCES users(id),
FOREIGN KEY (proj_id) REFERENCES project(id));

INSERT INTO users(login, user_password, create_date) VALUES
	('user_1', 'qwerty', '01.04.2021'),
	('user_2', 'qwerty', '01.04.2021'),
	('user_3', 'qwerty', '02.04.2021'),
	('user_4', 'qwerty', '03.04.2021'),
	('user_5', 'qwerty', '05.04.2021'),
	('user_6', 'qwerty', '06.04.2021'),
	('user_7', 'qwerty', '07.04.2021'),
	('user_8', 'qwerty', '10.04.2021'),
	('user_9', 'qwerty', '11.04.2021'),
	('user_10', 'qwerty', '12.04.2021'),
	('user_11', 'qwerty', '12.11.2021');

INSERT INTO department (dep_name) VALUES
	('Аналитика'),
	('Входящая линия'),
	('Исходящая линия'),
	('Обработка претензий'),
	('Техническая поддержка'),
	('Обработка чатов'),
	('Мониторинг'),
	('Бухалтерия'),
	('Кадры'),
	('Обучение');

INSERT INTO post (post_name) VALUES
	('Аналитик'),
	('Оператор'),
	('Директор'),
	('Руководитель отдела'),
	('Руководитель группы'),
	('Специалист'),
	('Старший специалист'),
	('Бухалтер'),
	('Кадровый специалист'),
	('Тренер');

INSERT INTO profiles(user_id, name, last_name, middle_name, date_bith, city, phone, dep_id, post_id) VALUES
	(1,'Иван', 'Ивайлов', 'Иванович','1991-05-30', 'Москва', '79089089080', 3, 2),
	(2,'Максим', 'Орлов', 'Николаевич','1990-10-15', 'Воронеж', '79009080080', 2, 2),
	(3,'Дмитрий', 'Казаков', 'Иванович', '1997-02-01', 'Москва', '79109089000', 5, 1),
	(4,'Виталий', 'Ивайлов', 'Макарович','1989-12-12', 'Москва', '79015082080', 5, 6),
	(5,'Анастасия', 'Михайлова', 'Артемовна', '1993-11-13', 'Воронеж', '79609060090', 10, 9),
	(6,'Давид', 'Избранов', 'Львович', '1991-07-19', 'Москва', '79506503321', 4, 3),
	(7,'Арон', 'Николаев', 'Николаевич', '1990-05-14', 'Москва', '79809801236', 8, 10),
	(8,'Светлана', 'Газиева', 'Анатольевна', '1991-03-21', 'Воронеж', '79603216598', 9, 9),
	(9,'Гансий', 'Гаризов', 'Гарсиевич', '1996-11-16', 'Москва', '798456321456', 6, 8),
	(10,'Мария', 'Марьева', 'Геннадиевна', '1999-03-03', 'Воронеж', '79639514568', 2, 2),
	(11,'Мария', 'Марьева', 'Геннадиевна', '1999-05-03', 'Воронеж', '79639514458', 1, 1);

INSERT INTO salary(post_id, salary, bonus) VALUES
	(1, '45000', '40000'),
	(2, '15000', '10000'),
	(3, '65000', '40000'),
	(4, '55000', '35000'),
	(5, '45000', '35000'),
	(6, '25000', '25000'),
	(7, '25000', '27000'),
	(8, '50000', '20000'),
	(9, '40000', '20000'),
	(10, '25000', '15000');

INSERT INTO passport_data(user_id, seria_pass, number_pass, what_give, date_give) VALUES
	(1, '9092', '123456', 'Отделом ОФМС по Воронежу', '2010-12-01'),
	(2, '6511', '951753', 'Отделом ОФМС по Иркутску', '2003-06-06'),
	(3, '6512', '654123', 'Отделом ОФМС по Москве', '2015-03-22'),
	(4, '7514', '456852', 'Отделом ОФМС по Воронежу', '2010-12-15'),
	(5, '7541', '521346', 'Отделом ОФМС по Павловску', '2001-06-01'),
	(6, '8216', '632475', 'Отделом ОФМС по Уральску', '2020-03-31'),
	(7, '7894', '456456', 'Отделом ОФМС по Москве', '2000-12-15'),
	(8, '3156', '963145', 'Отделом ОФМС по Воронежу', '1990-10-01'),
	(9, '7852', '530698', 'Отделом ОФМС по Курску', '1995-09-30'),
	(10, '9999', '963854', 'Отделом ОФМС по Черкесску', '2002-02-05');

INSERT INTO project(project_name, project_director) VALUES
	('Входящий', 4),
	('Исходящий', 5),
	('Чаты', 5),
	('Обучение и развитие', 5),
	('Мониторинг', 5),
	('Подбор персонала', 5),
	('Тех поддержка', 4),
	('Аналитика', 4),
	('Входящие орифлейн', 4),
	('Входящие макдональдс', 4);

INSERT INTO users_project(user_id, proj_id) VALUES
	(1, 1),
	(2, 3),
	(3, 2),
	(4, 5),
	(5, 2),
	(6, 8),
	(7, 4),
	(8, 10),
	(9, 9),
	(10, 7);

CREATE OR REPLACE VIEW `users_data` AS
SELECT
	users.id,
	users.login,
	profiles.name,
	profiles.last_name,
	profiles.middle_name,
	profiles.date_bith,
	profiles.city,
	profiles.phone,
	passport_data.seria_pass,
	passport_data.number_pass,
	passport_data.what_give,
	passport_data.date_give
FROM 
	users JOIN profiles JOIN passport_data
	ON users.id = profiles.user_id AND users.id = passport_data.user_id;

SELECT * FROM users_data;

CREATE OR REPLACE VIEW `users_post_salary` AS
SELECT
	users.id,
	users.login,
	profiles.name,
	profiles.last_name,
	post.post_name,
	department.dep_name,
	salary.salary,
	salary.bonus,
	salary.salary + salary.bonus AS ALL_SALARY
FROM 
	users JOIN profiles JOIN post JOIN department JOIN salary
	ON users.id = profiles.user_id AND
	profiles.post_id =  post.id AND
	profiles.dep_id = department.id AND
	post.id = salary.post_id
ORDER BY users.id;

select * from users_post_salary;

DELIMITER &&
CREATE TRIGGER correct_date_bith BEFORE INSERT ON profiles
FOR EACH ROW
BEGIN 
	IF NEW.date_bith >= NOW() THEN 
		SIGNAL SQLSTATE '50000' SET MESSAGE_TEXT = 'Проверти дату рождения';
	END IF;
END &&
DELIMITER ;

DROP PROCEDURE IF EXISTS NOTIFICATION_OF_THE_DATE_OF_BIRTH;
DELIMITER &&
CREATE PROCEDURE NOTIFICATION_OF_THE_DATE_OF_BIRTH()
BEGIN
	SELECT * FROM profiles
	WHERE DATE_FORMAT(date_bith, '%m') =  DATE_FORMAT(NOW(), '%m');
END
DELIMITER ;

CALL NOTIFICATION_OF_THE_DATE_OF_BIRTH();

 
