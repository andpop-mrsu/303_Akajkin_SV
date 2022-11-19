--добавление 5 пользователей
insert into users(name, email, gender, register_date, occupation)
    select 'Sergey Akaikin', 'akaikin02@mail.ru', 'male', date('now'), 'student';

insert into users(name, email, gender, register_date, occupation)
    select 'Daria Akimova', 'akimova03@gmail.com', 'female', date('now'), 'student';

insert into users(name, email, gender, register_date, occupation)
    select 'Anna Bugreeva', 'bugreeva@mail.ru', 'female', date('now'), 'student';

insert into users(name, email, gender, register_date, occupation)
    select 'Aleksey Artamonov', 'artamonov@mail.ru', 'male', date('now'), 'student';

insert into users(name, email, gender, register_date, occupation)
    select 'Yana Venediktova', 'venediktova@mail.ru', 'female', date('now'), 'student';

--добавление 3 фильмов

insert into movies(title, year) values
('The Gentlemen', 2019),
('The Green Knight', 2020),
('Once Upon a Time in Hollywood', 2019);

insert into movies_genres(movie_id, genre_id) select id, (select id from genres where name == 'Crime') from movies where title == 'The Gentlemen';
insert into movies_genres(movie_id, genre_id) select id, (select id from genres where name == 'Fantasy') from movies where title == 'The Green Knight';
insert into movies_genres(movie_id, genre_id) select id, (select id from genres where name == 'Comedy') from movies where title == 'Once Upon a Time in Hollywood';

--добавление 3 отзывов

insert into tags_contents(tag) values('very dynamic');
insert into tags(user_id, movie_id, tag_id, timestamp) select
                                                           (select id from users where name == 'Sergey Akaikin'),
                                                           (select id from movies where title == 'The Gentlemen'),
                                                           (select max(id) from tags),
                                                           strftime('%s', 'now');

insert into tags_contents(tag) values('interesting');
insert into tags(user_id, movie_id, tag_id, timestamp) select
                                                           (select id from users where name == 'Sergey Akaikin'),
                                                           (select id from movies where title == 'The Green Knight'),
                                                           (select max(id) from tags),
                                                           strftime('%s', 'now');

insert into tags_contents(tag) values('so funny');
insert into tags(user_id, movie_id, tag_id, timestamp) select
                                                           (select id from users where name == 'Sergey Akaikin'),
                                                           (select id from movies where title == 'Once Upon a Time in Hollywood'),
                                                           (select max(id) from tags),
                                                           strftime('%s', 'now');