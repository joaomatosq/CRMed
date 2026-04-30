-- Project: Sao Rafael Hospital Scheduler

-- ==========================================
-- 1. SEQUENCES
-- ==========================================
CREATE SEQUENCE seq_patients START WITH 1 INCREMENT BY 1 NOCACHE NOCYCLE;
CREATE SEQUENCE seq_surgeons START WITH 1 INCREMENT BY 1 NOCACHE NOCYCLE;
CREATE SEQUENCE seq_appointments START WITH 1 INCREMENT BY 1 NOCACHE NOCYCLE;

-- ==========================================
-- 2. TABLES
-- ==========================================
CREATE TABLE patients
(
    id                    INTEGER NOT NULL,
    first_name            VARCHAR2(80) NOT NULL,
    last_name             VARCHAR2(80) NOT NULL,
    date_of_birth         DATE NOT NULL,
    medical_record_number VARCHAR2(50) NOT NULL,
    phone                 VARCHAR2(20),
    email                 VARCHAR2(100),
    created_at            DATE NOT NULL,
    updated_at            DATE
);
ALTER TABLE patients ADD CONSTRAINT patients_pk PRIMARY KEY (id);
ALTER TABLE patients ADD CONSTRAINT patients_medical_record_un UNIQUE (medical_record_number);

CREATE TABLE surgeons
(
    id             INTEGER NOT NULL,
    first_name     VARCHAR2(80) NOT NULL,
    last_name      VARCHAR2(80) NOT NULL,
    specialty      VARCHAR2(100) NOT NULL,
    license_number VARCHAR2(30) NOT NULL,
    email          VARCHAR2(100),
    phone          VARCHAR2(20),
    is_active      CHAR(1) NOT NULL,
    created_at     DATE NOT NULL,
    updated_at     DATE
);
ALTER TABLE surgeons ADD CONSTRAINT surgeons_pk PRIMARY KEY (id);
ALTER TABLE surgeons ADD CONSTRAINT surgeons_license_number_un UNIQUE (license_number);
ALTER TABLE surgeons ADD CONSTRAINT surgeons_is_active_ck CHECK (is_active IN ('0', '1'));

CREATE TABLE appointments
(
    id             INTEGER NOT NULL,
    patient_id     INTEGER NOT NULL,
    surgeon_id     INTEGER NOT NULL,
    procedure_name VARCHAR2(150) NOT NULL,
    scheduled_at   DATE NOT NULL,
    status         VARCHAR2(20) NOT NULL,
    notes          VARCHAR2(500),
    created_by     VARCHAR2(100) NOT NULL,
    created_at     DATE NOT NULL,
    updated_at     DATE
);
ALTER TABLE appointments ADD CONSTRAINT appointments_pk PRIMARY KEY (id);
ALTER TABLE appointments ADD CONSTRAINT appointments_status_ck
    CHECK (status IN ('Scheduled', 'Attended', 'Cancelled'));

-- ==========================================
-- 3. RELATIONSHIPS
-- ==========================================
ALTER TABLE appointments
    ADD CONSTRAINT appointments_patient_fk FOREIGN KEY (patient_id)
    REFERENCES patients (id);

ALTER TABLE appointments
    ADD CONSTRAINT appointments_surgeon_fk FOREIGN KEY (surgeon_id)
    REFERENCES surgeons (id);

-- ==========================================
-- 4. PERFORMANCE INDEXES
-- ==========================================
CREATE INDEX idx_appointments_scheduled_at ON appointments (scheduled_at);
CREATE INDEX idx_appointments_surgeon_status_schedule ON appointments (surgeon_id, status, scheduled_at);

-- ==========================================
-- 5. COMMENTS
-- ==========================================
COMMENT ON TABLE patients IS 'Patient registry used for appointment scheduling.';
COMMENT ON TABLE surgeons IS 'Doctor registry with license information.';
COMMENT ON TABLE appointments IS 'Appointments linked to one patient and one surgeon.';
COMMENT ON COLUMN surgeons.license_number IS 'Professional medical license identifier.';
COMMENT ON COLUMN appointments.status IS 'Allowed values: Scheduled, Attended, Cancelled.';
