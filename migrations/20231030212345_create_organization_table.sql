CREATE TABLE IF NOT EXISTS organization(
    id UUID PRIMARY KEY NOT NULL,

    name VARCHAR(50) NOT NULL,
    email VARCHAR(100) NOT NULL,

    street VARCHAR(100),
    house_number VARCHAR(10),
    zip VARCHAR(10),
    city VARCHAR(50),
    country VARCHAR(50),

    ustid VARCHAR(20)
);
