CREATE TABLE IF NOT EXISTS landing_site(
    id UUID PRIMARY KEY NOT NULL,

    name VARCHAR(50) NOT NULL,
    height INTEGER NOT NULL
);

CREATE TABLE IF NOT EXISTS launch_site(
    id UUID PRIMARY KEY NOT NULL,

    name VARCHAR(50) NOT NULL,
    height INTEGER NOT NULL,

    landing_site_id UUID REFERENCES landing_site (id)
);

