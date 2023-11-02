CREATE TABLE IF NOT EXISTS tandem_flight(
    id UUID PRIMARY KEY NOT NULL,

    date_and_time TIMESTAMPTZ NOT NULL,
    duration INTEGER NOT NULL,
    comment TEXT,

    pilot_id UUID REFERENCES pilot (id),
    passenger_id UUID REFERENCES passenger (id),
    organization_id UUID REFERENCES organization (id),

    launch_site_id UUID REFERENCES launch_site (id),
    landing_site_id UUID REFERENCES landing_site (id)
);
