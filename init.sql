-- ========================================================
-- SOAL 3: MEMBUAT SKEMA DAN TABEL
-- ========================================================

-- Create Schema SALAM
CREATE SCHEMA IF NOT EXISTS SALAM;

-- Create Table mahasiswas (Primary Key, Unique, Check Constraint)
CREATE TABLE SALAM.mahasiswas (
    id SERIAL PRIMARY KEY,
    nim VARCHAR(20) UNIQUE NOT NULL,
    nama VARCHAR(100) NOT NULL,
    email VARCHAR(100) UNIQUE NOT NULL,
    ipk NUMERIC(3,2) CHECK (ipk >= 0.00 AND ipk <= 4.00),
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

-- ========================================================
-- PEMBUKTIAN SOAL 3 (CONSTRAINT)
-- ========================================================

-- 1. Insert Data Valid (Berhasil)
INSERT INTO SALAM.mahasiswas (nim, nama, email, ipk) 
VALUES ('1247050124', 'Sekarmaji', 'sekarmaji@salam.ac.id', 3.85);

-- 2. Uji Unique Constraint (Gagal - NIM Duplikat)
-- INSERT INTO SALAM.mahasiswas (nim, nama, email, ipk) 
-- VALUES ('1247050124', 'Seseorang', 'lain@salam.ac.id', 3.50);

-- 3. Uji Check Constraint (Gagal - IPK > 4.00)
-- INSERT INTO SALAM.mahasiswas (nim, nama, email, ipk) 
-- VALUES ('1247050999', 'Budi', 'budi@salam.ac.id', 4.50);


-- ========================================================
-- SOAL 4: USER DAN ROLE
-- ========================================================

-- 1. backend_dev (Role: CRUD semua table)
CREATE USER backend_dev WITH PASSWORD 'pass_backend123';
GRANT USAGE ON SCHEMA SALAM TO backend_dev;
GRANT SELECT, INSERT, UPDATE, DELETE ON ALL TABLES IN SCHEMA SALAM TO backend_dev;
ALTER DEFAULT PRIVILEGES IN SCHEMA SALAM GRANT SELECT, INSERT, UPDATE, DELETE ON TABLES TO backend_dev;

-- 2. bi_dev (Role: hanya read/select semua table/view)
CREATE USER bi_dev WITH PASSWORD 'pass_bi123';
GRANT USAGE ON SCHEMA SALAM TO bi_dev;
GRANT SELECT ON ALL TABLES IN SCHEMA SALAM TO bi_dev;
ALTER DEFAULT PRIVILEGES IN SCHEMA SALAM GRANT SELECT ON TABLES TO bi_dev;

-- 3. data_engineer (Role: CREATE, MODIFY, DROP semua objects, CRUD semua table)
CREATE USER data_engineer WITH PASSWORD 'pass_de123';
GRANT ALL PRIVILEGES ON SCHEMA SALAM TO data_engineer;
GRANT ALL PRIVILEGES ON ALL TABLES IN SCHEMA SALAM TO data_engineer;
ALTER DEFAULT PRIVILEGES IN SCHEMA SALAM GRANT ALL PRIVILEGES ON TABLES TO data_engineer;


-- ========================================================
-- PEMBUKTIAN SOAL 4 (ROLE & PRIVILEGES)
-- ========================================================

-- Pembuktian bi_dev:
-- LOGIN sebagai bi_dev di DBeaver:
-- SELECT * FROM SALAM.mahasiswas; -- BERHASIL
-- INSERT INTO SALAM.mahasiswas (nim, nama, email, ipk) VALUES ('1247050001', 'Test', 'test@mail.com', 3.0); -- GAGAL (Permission Denied)

-- Pembuktian backend_dev:
-- LOGIN sebagai backend_dev di DBeaver:
-- INSERT INTO SALAM.mahasiswas (nim, nama, email, ipk) VALUES ('1247050001', 'Test', 'test@mail.com', 3.0); -- BERHASIL
-- DROP TABLE SALAM.mahasiswas; -- GAGAL (Must be owner of table)