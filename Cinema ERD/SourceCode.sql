
--Cinema Booking App Database--
create database cinemabookdb;

create type enum_user_role as enum('admin','customer','moderator','guest');

create table users(
    user_id int primary key generated always as identity,
    name varchar(100) not null,
    email varchar(255) not null unique ,
    password varchar(60) not null ,
    role enum_user_role default 'customer',
    phone varchar(40) null,
    created_at timestamp default current_timestamp
);

create type enum_movie_genre as enum ('Action',
    'Adventure',
    'Comedy',
    'Drama',
    'Fantasy',
    'Horror',
    'Mystery',
    'Romance',
    'Science Fiction',
    'Thriller',
    'Western',
    'Animation',
    'Documentary');

create table movies(
    movie_id int primary key generated always as identity,
    title varchar(255) not null ,
    description text null,
    genre enum_movie_genre not null ,
    duration_minutes int not null ,
    release_date date not null ,
    rating int check ( rating >= 0 and rating <= 10 ),
    poster_url varchar(255) null,
    created_at timestamp default current_timestamp
);

create table cinemas (
    cinema_id int primary key generated always as identity,
    name varchar(255) not null,
    location varchar(255) not null,
    created_at timestamp default current_timestamp
);

create table screens (
    screen_id int primary key generated always as identity,
    cinema_id int,
    name varchar(100) not null ,
    capacity int not null ,

    constraint fk_cinema_id foreign key (cinema_id)
    references cinemas(cinema_id)

);

create type enum_seat_type as enum(
    'Standard',
    'Premium',
    'VIP',
    'Balcony',
    'Recliner',
    'Couple');

create table seats (
    seat_id int primary key generated always as identity,
    screen_id int,
    seat_number char(2) not null ,
    seat_type enum_seat_type not null,

    constraint fk_screen_id foreign key (screen_id) references screens(screen_id)
);

create table showtimes(
    showtime_id int primary key generated always as identity,
    screen_id int,
    movie_id int,
    start_time timestamp not null,
    end_time timestamp not null,
    price decimal(10,2) not null,

    constraint fk_screen_id foreign key (screen_id) references screens(screen_id),
    constraint fk_movie_id foreign key (movie_id) references movies(movie_id)
);

create type enum_booking_status as enum (
    'Pending',         -- Rezervatsiya kutish holatida
    'Confirmed',       -- Rezervatsiya tasdiqlangan
    'Cancelled',       -- Rezervatsiya bekor qilingan
    'Completed',       -- Rezervatsiya bajarilgan
    'Failed',          -- Rezervatsiya amalga oshmagan
    'NoShow'    );

create table bookings (
    booking_id int primary key generated always as identity,
    user_id int,
    showtime_id int,
    booking_date timestamp default current_timestamp,
    total_price decimal(10,2) not null,
    status enum_booking_status default 'Pending',

    foreign key (user_id) references users(user_id),
    foreign key (showtime_id) references showtimes(showtime_id)
);

create table booking_details(
    booking_detail_id int primary key generated always as identity ,
    booking_id int,
    seat_id int,
    price decimal(10,2) not null ,
    foreign key (booking_id) references bookings(booking_id),
    foreign key (seat_id) references seats(seat_id)
);

create type enum_pay_status as enum('pending','completed','failed');

create table payments (
    payment_id int primary key generated always as identity ,
    booking_id int,
    payment_date timestamp default current_timestamp,
    amount decimal(10,2) not null,
    payment_method varchar(50) not null ,
    status enum_pay_status default 'pending',

    foreign key (booking_id) references bookings(booking_id)

);

--SQL Mock Data Script for All Tables--

--insert users
INSERT INTO Users (user_id, name, email, password, role, phone, created_at) VALUES
(default, 'Alice Smith', 'alice@gmail.com', 'hashed_password1', 'customer', '1234567890', '2024-01-01 10:00:00'),
(default, 'Bob Johnson', 'bob@gmail.com', 'hashed_password2', 'admin', '0987654321', '2024-01-02 11:00:00'),
(default, 'Charlie Brown', 'charlie@hotmail.com', 'hashed_password3', 'customer', '1122334455', '2024-01-03 12:00:00');

--insert movies
INSERT INTO Movies ( title, description, genre, duration_minutes, release_date, rating, poster_url, created_at) VALUES
( 'Inception', 'A mind-bending thriller.', 'Adventure', 148, '2010-07-16', 8.8, 'inception_poster.jpg', '2024-01-01 10:00:00'),
( 'The Matrix', 'A computer hacker learns about the true nature of reality.', 'Action', 136, '1999-03-31', 8.7, 'matrix_poster.jpg', '2024-01-02 11:00:00'),
( 'Titanic', 'A romantic drama on the ill-fated ship.', 'Drama', 195, '1997-12-19', 7.9, 'titanic_poster.jpg', '2024-01-03 12:00:00');

--insert cinemas
INSERT INTO Cinemas ( name, location, created_at) VALUES
( 'Downtown Cinema', '123 Main Street, City Center', '2024-01-01 10:00:00'),
( 'Uptown Theater', '456 Uptown Avenue, Suburbs', '2024-01-02 11:00:00'),
( 'Parkside Cineplex', '789 Park Lane, Riverside', '2024-01-03 12:00:00');

--insert screens
INSERT INTO Screens ( cinema_id, name, capacity) VALUES
( 1, 'Screen 1', 100),
( 1, 'Screen 2', 120),
( 2, 'Screen A', 150);

--insert seats
INSERT INTO Seats ( screen_id, seat_number, seat_type) VALUES
( 1, 'A1', 'VIP'),
( 1, 'A2', 'Standard'),
( 2, 'B1', 'Balcony');

--insert showtimes
INSERT INTO Showtimes ( screen_id, movie_id, start_time, end_time, price) VALUES
( 1, 1, '2024-01-10 14:00:00', '2024-01-10 16:30:00', 10.00),
( 2, 2, '2024-01-11 18:00:00', '2024-01-11 20:30:00', 12.50),
( 3, 3, '2024-01-12 20:00:00', '2024-01-12 23:15:00', 15.00);

--insert booking
INSERT INTO Bookings ( user_id, showtime_id, booking_date, total_price, status) VALUES
( 1, 1, '2024-01-05 10:00:00', 10.00, 'Confirmed'),
( 2, 2, '2024-01-06 11:30:00', 25.00, 'Pending'),
( 3, 3, '2024-01-07 15:45:00', 15.00, 'Cancelled');

--insert booking details
INSERT INTO Booking_Details ( booking_id, seat_id, price) VALUES
( 1, 1, 10.00),
( 2, 2, 12.50),
( 3, 3, 15.00);

--insert payments
INSERT INTO Payments ( booking_id, payment_date, amount, payment_method, status) VALUES
( 1, '2024-01-05 10:15:00', 10.00, 'Credit Card', 'completed'),
( 2, '2024-01-06 11:45:00', 25.00, 'PayPal', 'completed'),
( 3, '2024-01-07 16:00:00', 15.00, 'Cash', 'failed');


--SQL Tasks for Database - Operators, WHERE, DISTINCT, ORDER BY, LIKE, and Aliases--

--operators
select * from users
where user_id < 100 and (role = 'admin' or role = 'customer');

select * from movies
where (rating between 7 and 9) and (duration_minutes > 90);

select * from bookings
where total_price > 50 and status <> 'Cancelled';

select * from payments
where amount > 100 or payment_method = 'Credit Card';

--where
select * from users
where email like '%gmail.com';

select * from movies
where rating >= 8;

select * from bookings
where user_id = 3 ;

select * from showtimes
where movie_id = 5 and start_time::time > '18:00:00';

--distinct
select distinct movies.genre from movies;

select distinct location from cinemas;

select distinct status from bookings;

select distinct start_time from showtimes;

--order by

select name as most_resent from users
order by created_at desc;

select * from movies
order by release_date asc ;

select * from bookings
order by total_price desc ;

select * from payments
order by payment_date desc;

--like

select * from users
where name like 'A%';

select * from movies
where title ilike '%love%';

select * from bookings
where cast(booking_date as text) like '2024-%';

select * from cinemas
where name ilike '%theater';

--aliases

select user_id as "User ID", name as "Full Name", email as "Email Addres" from users;

select title as "Movie Title", release_date as "Release Date", rating as "Viewer Rating"  from movies;

select booking_date as "Booking Date", status as "Booking Status", total_price as "Amount Paid" from bookings;

select start_time as "Show Start Time", price as "Ticket price", screen_id as "Screen ID"  from showtimes;












