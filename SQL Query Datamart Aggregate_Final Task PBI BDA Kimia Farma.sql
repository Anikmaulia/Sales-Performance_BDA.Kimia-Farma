-- Create datamart aggregate: sales_aggregate
CREATE TABLE sales_aggregate AS(
	SELECT 
		nama_barang,	
		company_cabang,
		COUNT(tanggal) AS total_transaksi,
		COUNT(DISTINCT id_distributor) AS total_distributor,
		COUNT(DISTINCT id_customer) AS total_customer,
		SUM(pendapatan) AS total_pendapatan
	FROM sales_performance
	GROUP BY nama_barang, company_cabang
);

-- Check the datamart aggregat table
SELECT * FROM sales_aggregat;