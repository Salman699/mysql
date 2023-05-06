-- membuat fungsi inputPelanggan()
DELIMITER $$
CREATE FUNCTION inputPelanggan(kode VARCHAR(11), nama_pelanggan VARCHAR(255), jk VARCHAR(1), tmp_lahir VARCHAR(255), tgl_lahir DATE, email VARCHAR(255), kartu_id INT(11))
RETURNS INT(11)
DETERMINISTIC
BEGIN
  DECLARE id_pelanggan INT(11);
  
  -- memasukkan data pelanggan baru ke dalam tabel pelanggan
  INSERT INTO pelanggan (kode, nama_pelanggan, jk, tmp_lahir, tgl_lahir, email, kartu_id) VALUES (kode, nama_pelanggan, jk, tmp_lahir, tgl_lahir, email, kartu_id);
  
  -- menyimpan id pelanggan yang baru saja dibuat
  SET id_pelanggan = LAST_INSERT_ID();
  
  RETURN id_pelanggan;
END $$
DELIMITER ;

SELECT inputPelanggan('C011', 'Alex', 'L', 'Jakarta', '1996-05-12', 'alex@gmail.com', 2);


-- procedure
DELIMITER $$
CREATE PROCEDURE inputPelanggan(IN kode VARCHAR(11), IN nama_pelanggan VARCHAR(255), IN jk VARCHAR(1), IN tmp_lahir VARCHAR(255), IN tgl_lahir DATE, IN email VARCHAR(255), IN kartu_id INT(11), OUT id_pelanggan INT(11))
BEGIN
  -- memasukkan data pelanggan baru ke dalam tabel pelanggan
  INSERT INTO pelanggan (kode, nama_pelanggan, jk, tmp_lahir, tgl_lahir, email, kartu_id) VALUES (kode, nama_pelanggan, jk, tmp_lahir, tgl_lahir, email, kartu_id);
  
  -- menyimpan id pelanggan yang baru saja dibuat
  SET id_pelanggan = LAST_INSERT_ID();
END$$
DELIMITER ;

SELECT inputPelanggan('C012', 'Amara', 'P', 'Jakarta', '1996-05-12', 'amara@gmail.com', 2);



-- Buat fungsi showPelanggan(), setelah itu panggil fungsinya
DELIMITER $$
CREATE FUNCTION showPelanggan()
RETURNS TEXT
DETERMINISTIC
BEGIN
    DECLARE result TEXT;
    SET result = '';
    SELECT GROUP_CONCAT(CONCAT('ID: ', pelanggan.id, ', Kode: ', pelanggan.kode, ', Nama Pelanggan: ', pelanggan.nama_pelanggan) SEPARATOR '; ') INTO result FROM pelanggan;
    RETURN result;
END $$
DELIMITER ;

SELECT showPelanggan();

-- Procedure
DELIMITER $$
CREATE PROCEDURE showPelanggan()
BEGIN
    SELECT * FROM pelanggan;
END $$
DELIMITER ;

CALL showPelanggan();



-- Buat fungsi inputProduk(), setelah itu panggil fungsinya
DELIMITER $$
CREATE FUNCTION inputProduk(
    kode VARCHAR(10),
    nama VARCHAR(255),
    jenis_produk_id VARCHAR(255),
    harga_jual DOUBLE,
    harga_beli DOUBLE,
    stok INT(11),
    min_stok INT(11)
) RETURNS INT
DETERMINISTIC
BEGIN
    DECLARE id_produk INT;
    INSERT INTO produk (kode, nama, jenis_produk_id, harga_jual, harga_beli, stok, min_stok) 
    VALUES (kode, nama, jenis_produk_id, harga_jual, harga_beli, stok, min_stok);
    SET id_produk = LAST_INSERT_ID();
    RETURN id_produk;
END $$
DELIMITER ;

SELECT inputProduk('L002', 'Laptop ASUS', 5, 15000000, 10000000, 50, 10);


-- Procedure
DELIMITER $$
CREATE PROCEDURE inputProduk(
    IN kode VARCHAR(10),
    IN nama VARCHAR(255),
    IN jenis_produk_id VARCHAR(255),
    IN harga_jual DOUBLE,
    IN harga_beli DOUBLE,
    IN stok INT(11),
    IN min_stok INT(11)
)
BEGIN
    INSERT INTO produk (kode, nama, jenis_produk_id, harga_jual, harga_beli, stok, min_stok) 
    VALUES (kode, nama, jenis_produk_id, harga_jual, harga_beli, stok, min_stok);
END $$
DELIMITER ;
CALL inputProduk('L002', 'Laptop ASUS', 5, 15000000, 10000000, 50, 10);



-- Buat fungsi showProduk(), setelah itu panggil fungsinya
DELIMITER $$
CREATE FUNCTION showProduk()
RETURNS TEXT
DETERMINISTIC
BEGIN
    DECLARE result TEXT;
    SET result = '';
    SELECT GROUP_CONCAT(CONCAT('ID: ', produk.id, ', Kode: ', produk.kode, ', Nama: ', produk.nama, ', Harga Beli: ', produk.harga_beli, ', Harga Jual: ', produk.harga_jual, ', Stok: ', produk.stok, ', Minimum Stok: ', produk.min_stok) SEPARATOR '; ') INTO result FROM produk;
    RETURN result;
END $$
DELIMITER ;

SELECT showProduk();


-- Procedure
DELIMITER $$
CREATE PROCEDURE showProduk()
BEGIN
    SELECT * FROM produk;
END $$
DELIMITER ;

CALL showProduk();


-- Buat fungsi totalPesanan(), setelah itu panggil fungsinya
DELIMITER $$
CREATE FUNCTION totalPesanan()
RETURNS TEXT
DETERMINISTIC
BEGIN
  DECLARE result TEXT;
  SELECT CONCAT('Kode Pelanggan: ', pelanggan.kode, ', Nama Pelanggan: ', pelanggan.nama_pelanggan, ', Total Produk: ', SUM(pesanan_items.qty), ', Total Harga: ', SUM(pesanan_items.qty * pesanan_items.harga)) INTO result
  FROM pesanan_items
  JOIN pesanan ON pesanan_items.pesanan_id = pesanan.id
  JOIN pelanggan ON pesanan.pelanggan_id = pelanggan.id
  GROUP BY pelanggan.kode, pelanggan.nama_pelanggan
  LIMIT 1;
  RETURN result;
END $$
DELIMITER ;

SELECT totalPesanan();


-- Procedure
DELIMITER $$
BEGIN
  SELECT pelanggan.kode AS kode_pelanggan, pelanggan.nama_pelanggan, SUM(pesanan_items.qty) AS total_produk, SUM(pesanan_items.qty * pesanan_items.harga) AS total_harga
  FROM pesanan_items
  JOIN pesanan ON pesanan_items.pesanan_id = pesanan.id
  JOIN pelanggan ON pesanan.pelanggan_id = pelanggan.id
  GROUP BY pelanggan.kode, pelanggan.nama_pelanggan;
END $$
DELIMITER ;
CALL totalPesanan();


-- Buat Function untuk menampilkan seluruh pesanan dari semua pelanggan
DELIMITER $$
CREATE FUNCTION showPesananAll()
RETURNS TEXT
DETERMINISTIC
BEGIN
  DECLARE result TEXT;
  SELECT CONCAT('Pesanan ID: ', pesanan.id, ', Tanggal: ', pesanan.tanggal, ', Kode Pelanggan: ', pelanggan.kode, ', Nama Pelanggan: ', pelanggan.nama_pelanggan, ', Kode Produk: ', produk.kode, ', Nama Produk: ', produk.nama, ', Jumlah: ', pesanan_items.qty, ', Harga Satuan: ', produk.harga_jual, ', Total Harga: ', pesanan_items.qty * produk.harga_jual) INTO result
    FROM pesanan
    JOIN pelanggan ON pesanan.pelanggan_id = pelanggan.id
    JOIN pesanan_items ON pesanan.id = pesanan_items.pesanan_id
    JOIN produk ON pesanan_items.produk_id = produk.id
    WHERE pesanan.id = pesanan_id
    LIMIT 1;
  RETURN result;
END $$
DELIMITER ;
SELECT showPesananAll();

-- Procedure
DELIMITER $$
CREATE PROCEDURE showAllPesanan()
BEGIN
  SELECT pesanan.id AS pesanan_id, pesanan.tanggal, pelanggan.kode AS pelanggan_kode, pelanggan.nama_pelanggan, produk.kode AS produk_kode, produk.nama AS nama_produk, pesanan_items.qty, produk.harga_jual, SUM(pesanan_items.qty * pesanan_items.harga) AS total_harga
    FROM pesanan
    JOIN pelanggan ON pesanan.pelanggan_id = pelanggan.id
    JOIN pesanan_items ON pesanan.id = pesanan_items.pesanan_id
    JOIN produk ON pesanan_items.produk_id = produk.id
    GROUP BY pesanan.id, produk.id, pesanan_items.id, pelanggan.id;
END $$
DELIMITER ;
CALL showAllPesanan();


-- buatkan query panjang di atas menjadi sebuah view baru: pesanan_produk_vw (menggunakan join dari table pesanan,pelanggan dan produk)
CREATE VIEW pesanan_produk_vw AS
SELECT pesanan.id AS pesanan_id, pesanan.tanggal, pelanggan.kode AS pelanggan_kode, pelanggan.nama_pelanggan, produk.kode AS produk_kode, produk.nama AS nama_produk, pesanan_items.qty, produk.harga_jual, SUM(pesanan_items.qty * pesanan_items.harga) AS total_harga
    FROM pesanan
    JOIN pelanggan ON pesanan.pelanggan_id = pelanggan.id
    JOIN pesanan_items ON pesanan.id = pesanan_items.pesanan_id
    JOIN produk ON pesanan_items.produk_id = produk.id
    GROUP BY pesanan.id, produk.id, pesanan_items.id, pelanggan.id;

SELECT * FROM pesanan_produk_vw;
