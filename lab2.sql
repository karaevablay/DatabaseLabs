/* Laborotory work 2
Yerzhanov Abylay

 -------------------------------------------
 -- Task 1
create table employee(
    ID int not null,
    name varchar(20),
    surname varchar(20),
    position varchar(30),
    primary key (ID)
);


 /* Insert */
insert into employee(id, name, surname, position) 
values (10,'Yerzhanov','Abylay','iOS Dev',101);

 /* Update */
update employee
set fname = 'Aidar', lname = 'Nugmanov'
where id = 1;

 /* Delete */
delete from employee 
where position = 'Back End Dev';


 /* Select */
select *from employee;

 /* Delete */
drop table employee;
-----------------------------------------------


--task2
CREATE TABLE customers (
    id int NOT NULL PRIMARY KEY,
    full_name varchar(50) NOT NULL,
    timestamp timestamp NOT NULL,
    delivery_address text NOT NULL
);

CREATE TABLE orders (
    code int NOT NULL PRIMARY KEY,
    customer_id int REFERENCES customers(id),
    total_sum double precision NOT NULL CHECK(total_sum>0),
    is_paid boolean NOT NULL
);

create table products(
    id varchar,
    name varchar not null ,
    description text not null,
    price double precision,
    primary key (id)
);

CREATE TABLE order_items(
    order_code int REFERENCES orders(code),
    product_id varchar references products(id),
    quantity int NOT NULL CHECK ( quantity>0 ),
    PRIMARY KEY (order_code,product_id)
);


-------------------------------------------------------------------
-- Task3:


CREATE TABLE student(    
    id integer PRIMARY KEY,    
    full_name varchar(40) NOT NULL,    
    age integer NOT NULL,    
    birth_date date NOT NULL,    
    gender char(1) not null,    
    average_grade real NOT NULL,    
    self_information varchar,    
    dormitory_need boolean NOT NULL,    
    additional_info text,   
     CONSTRAINT id_pos CHECK ( id > 0 ),    
     CONSTRAINT age_limit CHECK ( age >= 16 AND age <= 25 ),    
     CONSTRAINT grade_limit CHECK ( average_grade >= 0 AND average_grade <= 4.0 )
);

CREATE TABLE instructor(    
    id integer PRIMARY KEY,    
    full_name varchar(40) NOT NULL,    
    age integer NOT NULL,    
    experience integer NOT NULL,  
    speaking_languages varchar,    
    are_remote_lessons_available boolean NOT NULL,
     CONSTRAINT id_pos CHECK ( id > 0 ),    
     CONSTRAINT experience_limit CHECK ( experience >= 1),
);



CREATE TABLE lesson_participant(    
    id integer PRIMARY KEY,    
    lesson_title varchar(30) NOT NULL,    
    teaching_instructor_id integer NOT NULL,  
    student_id integer NOT NULL, 
    room_id integer NOT NULL,    
    are_remote_lessons_available boolean NOT NULL,
     CONSTRAINT id_pos CHECK ( id > 0 ),
);

--------------------------------------------------------

--Task 4:
-- Insertion
insert into customers(full_name, delivery_address)
values ('Yerzhanov Abylay','Bayzakova street, Almaty');

-- Update
update customers
set full_name = 'James' 
where delivery_address = 'Bayzakova, Almaty';

-- Delete
delete from customers
where full_name = 'James';





