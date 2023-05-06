-- Buat trigger untuk mengecek pembayaran
DELIMITER //
CREATE TRIGGER update_status_pembayaran BEFORE INSERT ON pembayaran
FOR EACH ROW
BEGIN
    DECLARE total_bayar DECIMAL(10, 2);
    DECLARE total_pesanan DECIMAL(10, 2);

    -- Ambil total pembayaran dari tabel pembayaran
    SELECT SUM(jumlah) INTO total_bayar FROM pembayaran WHERE pesanan_id = NEW.pesanan_id;

    -- Ambil total pesanan dari tabel pesanan
    SELECT total INTO total_pesanan FROM pesanan WHERE id = NEW.pesanan_id;

    -- Jika total pembayaran lebih besar atau sama dengan total pesanan, update status pembayaran menjadi lunas
    IF total_bayar + NEW.jumlah >= total_pesanan THEN
        SET NEW.status_pembayaran = 'Lunas';
    END IF;
END //
DELIMITER ;

-- Tambah Data di tabel pembayaran
INSERT INTO pembayaran (nokuitansi, tanggal, jumlah, ke, pesanan_id)
VALUES ('INV007', '2023-05-04', 20000, 1, 11);
