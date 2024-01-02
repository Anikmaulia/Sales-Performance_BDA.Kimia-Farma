-- Create datamart base: sales_performance
CREATE TABLE sales_performance AS(
	SELECT 
		pn.tanggal,
		pn.id_distributor,
		pn.id_customer,
		pn.unit AS kemasan,
		pn.harga,
		pn.jumlah_barang,
		(pn.harga * pn.jumlah_barang) AS pendapatan,
		CONCAT(pl.nama, '_', pl.cabang_sales) AS company_cabang,
		b.nama_barang
	FROM penjualan_table pn
	LEFT JOIN pelanggan_table pl ON pn.id_customer = pl.id_customer
	LEFT JOIN barang_table b ON pn.id_barang = b.kode_barang
	ORDER BY pn.tanggal
);

-- Check the datamart base table
SELECT * FROM sales_performance;