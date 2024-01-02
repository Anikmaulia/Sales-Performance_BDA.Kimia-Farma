-- Create penjualan_table
CREATE TABLE penjualan_table (
	id_distributor VARCHAR(10),
	id_cabang VARCHAR(10),
	id_invoice VARCHAR(10),
	tanggal DATE,
	id_customer VARCHAR(10),
	id_barang VARCHAR(10),	
	jumlah_barang INTEGER,	
	unit VARCHAR(10),
	harga FLOAT,	
	mata_uang VARCHAR(10),	
	brand_id VARCHAR(10),
	lini VARCHAR(10),
	PRIMARY KEY (id_invoice)
);

-- Import data from csv file to penjualan_table
COPY penjualan_table(id_distributor, id_cabang, id_invoice, tanggal, id_customer, id_barang, jumlah_barang, unit, harga, mata_uang, brand_id, lini)
FROM 'C:\Users\anikm\Documents\penjualan_table.csv'
DELIMITER ',' CSV HEADER;

-- Handling invalid values in the 'unit' column to align it more accurately with the corresponding price data 
UPDATE penjualan_table
SET unit = CASE
	WHEN id_barang IN ('BRG0001', 'BRG0002', 'BRG0005', 'BRG0006') THEN 'TABLET'
	WHEN id_barang IN ('BRG0003', 'BRG0007', 'BRG0009', 'BRG0010') THEN 'BOTOL'
	ELSE 'KAPSUL'
END;

-- Handling invalid values in the 'id_barang' column, assuming that each product is sold under one brand and has the same price, and currently the price with the brand is already correct, so what needs to be handled is the 'id_barang'.
UPDATE penjualan_table
SET id_barang = CASE
	WHEN brand_id = 'BRND007' THEN 'BRG0007'
	WHEN brand_id = 'BRND008' THEN 'BRG0008'
	WHEN brand_id = 'BRND009' THEN 'BRG0009'
	WHEN brand_id = 'BRND010' THEN 'BRG0010'
	ELSE id_barang
END;

-- Check penjualan_table
SELECT * FROM penjualan_table;

-- Create pelanggan_table
CREATE TABLE pelanggan_table (
	id_customer VARCHAR(10),
	level VARCHAR(10),
	nama VARCHAR(20),
	id_cabang_sales	VARCHAR(10),
	cabang_sales VARCHAR(10),
	id_group VARCHAR(10),	
	grup VARCHAR(10),
	PRIMARY KEY (id_customer)
);

-- Import data from csv file to pelanggan_table
COPY pelanggan_table(id_customer, level, nama, id_cabang_sales, cabang_sales, id_group, grup)
FROM 'C:\Users\anikm\Documents\pelanggan_table.csv'
DELIMITER ',' CSV HEADER;

-- Check pelanggan_table
SELECT * FROM pelanggan_table;

-- Create barang_table
CREATE TABLE barang_table (
	kode_barang VARCHAR(10),
	sektor VARCHAR(10),
	nama_barang VARCHAR(50),	
	tipe VARCHAR(10),
	nama_tipe VARCHAR(15),	
	kode_lini VARCHAR(10),
	lini VARCHAR(10),
	kemasan VARCHAR(10),
	PRIMARY KEY (kode_barang)
);

-- Import data from csv file to barang_table
COPY barang_table(kode_barang, sektor, nama_barang, tipe, nama_tipe, kode_lini, lini, kemasan)
FROM 'C:\Users\anikm\Documents\barang_table.csv'
DELIMITER ',' CSV HEADER;

-- Handling invalid values in the 'kemasan' column to align with the data in the penjualan table 
UPDATE barang_table
SET kemasan = 'TABLET'
WHERE kemasan ='DUS';

-- Check barang_table
SELECT * FROM barang_table;

-- Make id_customer as foreign key for pelanggan_table
ALTER TABLE penjualan_table
ADD FOREIGN KEY (id_customer)
REFERENCES pelanggan_table;

-- Make id_barang as foreign key for barang_table
ALTER TABLE penjualan_table
ADD FOREIGN KEY (id_barang)
REFERENCES barang_table (kode_barang);