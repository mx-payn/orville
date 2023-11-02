CREATE TABLE IF NOT EXISTS passenger(
    id UUID PRIMARY KEY NOT NULL,

    first_name VARCHAR(50) NOT NULL,
    last_name VARCHAR(50) NOT NULL,
    date_of_birth DATE NOT NULL,
    country_of_birth VARCHAR(50),
    height INTEGER,
    weight INTEGER,
    email VARCHAR(100)
);
