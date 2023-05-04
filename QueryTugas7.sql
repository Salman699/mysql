-- Buat fungsi inputPelanggan()

CREATE FUNCTION inputPelanggan(

  IN p_kode VARCHAR(10),

  IN p_nama VARCHAR(45),

  IN p_jk CHAR(1),

  IN p_tmp_lahir VARCHAR(30),

  IN p_tgl_lahir DATE,

  IN p_email VARCHAR(45),

  IN p_kartu_id INT

) RETURNS INT

BEGIN

  INSERT INTO pelanggan (kode, nama, jk, tmp_lahir, tgl_lahir, email, kartu_id)

  VALUES (p_kode, p_nama, p_jk, p_tmp_lahir, p_tgl_lahir, p_email, p_kartu_id);

  RETURN LAST_INSERT_ID();

END;

-- Panggil fungsi inputPelanggan()

SELECT inputPelanggan('P002', 'mirlani', 'L', 'Kendari', '2023-01-01', 'mirlani@gmail.com', 1);

-- Buat fungsi showPelanggan()

CREATE FUNCTION showPelanggan()

RETURNS TABLE

AS

RETURN SELECT * FROM pelanggan;

-- Panggil fungsi showPelanggan()

SELECT * FROM showPelanggan();

-- Buat fungsi inputProduk()

CREATE FUNCTION inputProduk(

  IN p_kode VARCHAR(10),

  IN p_nama VARCHAR(45),

  IN p_harga_beli DOUBLE,

  IN p_harga_jual DOUBLE,

  IN p_stok INT,

  IN p_min_stok INT,

  IN p_jenis_produk_id INT

) RETURNS INT

BEGIN

  INSERT INTO produk (kode, nama, harga_beli, harga_jual, stok, min_stok, jenis_produk_id)

  VALUES (p_kode, p_nama, p_harga_beli, p_harga_jual, p_stok, p_min_stok, p_jenis_produk_id);

  RETURN LAST_INSERT_ID();

END;

-- Panggil fungsi inputProduk()

SELECT inputProduk('PR001', 'Product A', 10000, 12000, 10, 5, 1);

-- Buat fungsi showProduk()

CREATE FUNCTION showProduk()

RETURNS TABLE

AS

RETURN SELECT * FROM produk;

-- Panggil fungsi showProduk()

SELECT * FROM showProduk();

-- Buat fungsi totalPesanan()

CREATE FUNCTION totalPesanan(p_pelanggan_id INT)

RETURNS DOUBLE

BEGIN

  DECLARE total_pesanan DOUBLE;

  SELECT SUM(total) INTO total_pesanan FROM pesanan WHERE pelanggan_id = p_pelanggan_id;

  RETURN total_pesanan;

END;

-- Panggil fungsi totalPesanan()

SELECT totalPesanan(1);

-- Tampilkan seluruh pesanan dari semua pelanggan

SELECT pesanan.id, pesanan.tanggal, pesanan.total, pelanggan.nama, produk.nama

FROM pesanan

JOIN pelanggan ON pesanan.pelanggan_id = pelanggan.id

JOIN produk ON pesanan.produk_id = produk.id;

-- Buat tampilan pesanan_produk_vw

CREATE VIEW pesanan_produk_vw AS

SELECT pesanan.id AS pesanan_id, pesanan.tanggal, pesanan.total, pelanggan.nama AS pelanggan_nama, produk.nama AS produk_nama

FROM pesanan

JOIN pelanggan ON pesanan.pelanggan_id = pelanggan.id

JOIN produk ON pesanan.produk_id = produk.id;

-- Panggil tampilan pesanan_produk_vw

SELECT * FROM pesanan_produk_vw;
