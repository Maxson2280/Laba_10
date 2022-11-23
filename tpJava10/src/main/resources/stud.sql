create tablespace stud LOCATION 'd:\dbEd/student';
create database students TABLESPACE stud;
\c students
create schema stud;

create table students(
                         id_students smallint primary key not null,
                         name varchar(255) not null,
                         series char(4) unique ,
                         number char(6) unique);

insert into students
values (1, 'Mark', 3312, 473298),
       (2,'Denis', 3506, 346598),
       (3,'Vitaliy', 3243, 380845),
       (4,'Artem', 3245, 406784),
       (5,'Polina', 3101, 113312);

create table subjects(
                         id_subjects smallint primary key,
                         name_subject char(45));

insert into subjects
values
    (1, 'Math'),
    (2, 'programming_technologies'),
    (3, 'electronics'),
    (4, 'algorithms'),
    (5,'data_management');

create table progress(
                         id_progress int primary key,
                         id_students int not null,
                         id_subjects int not null,
                         mark numeric(1) not null check (mark >= 2 and mark <= 5)
                             default 5,
                         constraint fk_id_students foreign key (id_students)
                             references students(id_students)
                             on DELETE cascade
                             on update cascade,
                         constraint fk_id_subjects foreign key (id_subjects)
                             references subjects(id_subjects)
                             on delete cascade
                             on update cascade
);



insert into progress
values
    ( 1,1,1, 5),
    ( 2,1,2, 2),
    ( 3,1,3, 3),
    ( 4,1,4, 2),
    ( 5,1,5, 5),

    ( 6,2,1, 2),
    ( 7,2,2, 2),
    ( 8,2,3, 3),
    ( 9,2,4, 4),
    ( 10,2,5, 5),

    ( 11,3,1, 5),
    ( 12,3,2, 2),
    ( 13,3,3, 4),
    ( 14,3,4, 4),
    ( 15,3,5, 5),

    ( 16,4,1, 5),
    ( 17,4,2, 2),
    ( 18,4,3, 3),
    ( 19,4,4, 2),
    ( 20,4,5, 5),

    ( 21,5,1, 4),
    ( 22,5,2, 4),
    ( 23,5,3, 4),
    ( 24,5,4, 2),
    ( 25,5,5, 5);

-- Вывести список студентов, сдавших определенный предмет, на оценку выше 3;
select name, mark  from students inner join progress p on students.id_students = p.id_students where mark > 3;
-- При удалении студента из таблицы, вся его успеваемость тоже должна быть удалена;
DELETE from students where name = 'Mark';
--  Посчитать средний бал по определенному предмету;
select   name_subject, avg(mark) from subjects inner join progress s on subjects.id_subjects = s.id_subjects group by name_subject;
-- Найти два предмета, которые сдали наибольшее количество студентов;
select  name_subject, count(id_students) as count_stud  from subjects inner join progress p on subjects.id_subjects = p.id_subjects  group by name_subject having min(mark) > 2 ;
-- Количество студентов которые сдали на оценки 4 и 5 по в порядке убывания
select count("mark"), name_subject, mark from progress inner join subjects s on s.id_subjects = progress.id_subjects inner join students s2 on s2.id_students = progress.id_students group by mark, name_subject having mark > 3 order by count(mark) desc offset 1 limit 3;

