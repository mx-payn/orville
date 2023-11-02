CREATE TABLE IF NOT EXISTS pilot
(
    id UUID PRIMARY KEY NOT NULL,

    first_name VARCHAR(50) NOT NULL,
    last_name VARCHAR(50) NOT NULL,
    date_of_birth DATE NOT NULL,
    email VARCHAR(100) NOT NULL,
    country_of_birth VARCHAR(50),
    height INTEGER,
    weight INTEGER,

    street VARCHAR(100),
    house_number VARCHAR(10),
    zip VARCHAR(10),
    city VARCHAR(50),
    country VARCHAR(50)
);
