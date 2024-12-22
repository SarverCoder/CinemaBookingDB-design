# CinemaBookingDB-design

**CinemaBookingDB** is a robust and scalable database designed to manage and streamline cinema ticket booking systems. It offers a well-organized schema to handle the complexities of managing movies, theaters, showtimes, seating arrangements, user accounts, and ticket reservations.

# ERD Diagram
![rasm](https://github.com/SarverCoder/CinemaBookingDB-design/blob/f58b78d00fa9d87882e5b6f9fbef73a948968af3/Cinema%20ERD/cinemabookingERD.png)

## Features

- **Movies Database**: Store comprehensive movie details, including title, genre, duration, language, and release year.
- **Theater Management**: Organize multiple theaters, their locations, and screens.
- **Showtime Scheduling**: Efficiently manage movie schedules with customizable showtimes.
- **Seating Arrangements**: Maintain real-time availability and reservations for each screen.
- **User Accounts**: Track customer and admin profiles with roles and booking history.
- **Reservation System**: Seamlessly handle ticket booking, payment, and confirmation.

## Database Schema

The schema includes the following key entities:

- **Users**: Captures user information such as name, email, and roles (e.g., customer, admin).
- **Movies**: Contains details about movies including title, description, genre, language, and runtime.
- **Theaters**: Stores data about theater locations and their screens.
- **Screens**: Defines screen layouts and capacities.
- **Showtimes**: Links movies to specific theaters and screens at designated times.
- **Seats**: Represents individual seat arrangements with status (available/reserved).
- **Reservations**: Tracks customer bookings and payment details.

## Use Cases

CinemaBookingDB is ideal for:

- Cinema chains managing multiple locations.
- Online cinema ticket booking systems.
- Event planning for movie screenings.

## Compatibility

This database is designed to work with:

- PostgreSQL
- MySQL
- SQL Server
- SQLite

SQL scripts are included for creating and populating the database with sample data.

## Setup Instructions

1. Clone the repository:
   ```bash
   git clone https://github.com/SarverCoder/CinemaBookingDB-design.git
