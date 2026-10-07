

DROP TABLE IF EXISTS users_hobbies;
DROP TABLE IF EXISTS likes;
DROP TABLE IF EXISTS matches;
DROP TABLE IF EXISTS users;
DROP TABLE IF EXISTS genders;
DROP TABLE IF EXISTS cities;
DROP TABLE IF EXISTS countries;
DROP TABLE IF EXISTS hobbies;
	
CREATE TABLE genders (
	id INT PRIMARY KEY NOT NULL AUTO_INCREMENT,
	name VARCHAR(100) NOT NULL UNIQUE
);

CREATE TABLE countries (
    id INT PRIMARY KEY NOT NULL AUTO_INCREMENT,
    country_name VARCHAR(100) NOT NULL UNIQUE
);

CREATE TABLE hobbies (
    id INT PRIMARY KEY not null AUTO_INCREMENT,
    hobby_name VARCHAR(100) NOT NULL unique
);


CREATE TABLE cities (
    id INT PRIMARY KEY NOT NULL AUTO_INCREMENT,
    city_name VARCHAR(100) NOT NULL,
    country_id INT NOT NULL,
    FOREIGN KEY (country_id) REFERENCES countries(id) ON DELETE CASCADE
);

CREATE TABLE users (
    id INT PRIMARY KEY AUTO_INCREMENT,
    name VARCHAR(60) NOT NULL,
    surname VARCHAR(60) NOT NULL,
    email VARCHAR(60) NOT NULL,
    phone_number VARCHAR(20),
    password_hash VARCHAR(255) NOT NULL,
    age INT NOT NULL,
    bio TEXT,
    gender_id INT NOT NULL,
    country_id INT,
    city_id INT,
    FOREIGN KEY (gender_id) REFERENCES genders(id) ON DELETE RESTRICT,
    FOREIGN KEY (country_id) REFERENCES countries(id) ON DELETE SET NULL,
    FOREIGN KEY (city_id) REFERENCES cities(id) ON DELETE SET NULL
);


CREATE TABLE users_hobbies (
    users_id INT NOT NULL,
    hobbies_id INT NOT NULL,
    PRIMARY KEY(users_id, hobbies_id),
    FOREIGN KEY(users_id) REFERENCES users(id) ON DELETE CASCADE,
    FOREIGN KEY(hobbies_id) REFERENCES hobbies(id) ON DELETE CASCADE
);
CREATE TABLE likes(
	id INT PRIMARY KEY AUTO_INCREMENT,
    users_id int NOT NULL,
    liked_id int NOT NULL,
    foreign key (users_id)REFERENCES users(id) ON DELETE CASCADE,
    foreign key(liked_id) REFERENCES users(id)ON DELETE CASCADE,
    check(users_id<>liked_id),
    UNIQUE KEY unique_like_pair (users_id, liked_id)
    );
    create table matches(
    id INT PRIMARY KEY AUTO_INCREMENT,
    userA_id INT NOT NULL,
    userB_id INT NOT NULL,
    createdAt timestamp default current_timestamp,
    foreign key(userA_id)REFERENCES users(id) ON DELETE CASCADE,
    foreign key(userB_id)REFERENCES users(id) ON DELETE CASCADE,
    UNIQUE KEY unique_match ((LEAST(userA_id,userB_id)), (GREATEST(userA_id, userB_id))),
    CHECK(userA_id<>userB_id)
    );


insert into hobbies (hobby_name)values('reading'),('sport'),('music'),('cooking'),('chess'),('meditation'),('plants'),('psychology'),('dancing');
select * from hobbies;
insert into genders(name) values('male'),('female');
select * from genders;
insert into countries(country_name)values('Kazakhstan'),('Russia'),('The UK'),('The USA'),('Canada'),('China'),('Japan'),('Italy');
select * from countries;
insert into cities(country_id,city_name)values(1,'Astana'),(1,'Almaty'),(1,'Aqtobe'),(1,'Aktau'),(1,'Pavlodar'),(1,'Oskemen'),(1,'Karaganda'),(1,'Atyray');
insert into cities(country_id,city_name)values(2,'Moscow'),(2,'Saint-Petersburg'),(2,'Kazan'),(2,'Koliningrad'),(2,'Ufa'),(2,'Sochi');
insert into cities(country_id,city_name)values(3,'London'),(3,'Edinburg'),(3,'Belfast'),(3,'Liverpool'),(3,'Manchester'),(3,'Bristol'),(3,'Oxford');
insert into cities(country_id,city_name)values(4,'Washington'),(4,'Chicago'),(4,'New York'),(4,'Las Vegas'),(4,'Los Angeles'),(4,'San Francisco');
insert into cities(country_id,city_name)values(5,'Toronto'),(5,'Vancouver'),(5,'Montreal'),(5,'Ontario'),(5,'Qeubec'),(5,'Alberta');
insert into cities(country_id,city_name)values(6,'Beijin'),(6,'Hong Kong'),(6,'Shanghai'),(6,'Guangzhou'),(6,'Hangzhou'),(6,'Xi’an');
insert into cities(country_id,city_name)values(7,'Tokyo'),(7,'Osaka'),(7,'Kyoto'),(7,'Fukuoka'),(7,'Kobe'),(7,'Nagoya');
insert into cities(country_id,city_name)values(8,'Rome'),(8,'Venice'),(8,'Florence'),(8,'Milan'),(8,'Capri'),(8,'Naples');

select * from cities;






SELECT * FROM users;
SELECT * FROM users_hobbies;
SELECT * FROM likes;
SELECT * FROM matches;
