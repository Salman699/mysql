Microsoft Windows [Version 10.0.19044.2728]
(c) Microsoft Corporation. All rights reserved.

C:\Users\salma>cd..

C:\Users>cd..

C:\>cd xampp/mysql/bin

C:\xampp\mysql\bin>mysql -u root
Welcome to the MariaDB monitor.  Commands end with ; or \g.
Your MariaDB connection id is 1603
Server version: 10.4.25-MariaDB mariadb.org binary distribution

Copyright (c) 2000, 2018, Oracle, MariaDB Corporation Ab and others.

Type 'help;' or '\h' for help. Type '\c' to clear the current input statement.

MariaDB [(none)]> show databases;
+--------------------+
| Database           |
+--------------------+
| db_penduduk        |
| db_practice9       |
| dbmhs              |
| dbpdk1             |
| dbpenduduk         |
| dbtoko             |
| information_schema |
| mahasiswa          |
| metode_wp          |
| mysql              |
| performance_schema |
| phpmyadmin         |
| test               |
| wp                 |
+--------------------+
14 rows in set (0.001 sec)

MariaDB [(none)]> use dbtoko
Database changed
MariaDB [dbtoko]> SELECT * FROM produk ORDER BY harga_jual DESC;
+----+------+----------+------------+------------+------+----------+-----------------+
| id | kode | nama     | harga_beli | harga_jual | stok | min_stok | jenis_produk_id |
+----+------+----------+------------+------------+------+----------+-----------------+
|  4 | M004 | Radio    |     500000 |     800000 |   10 |        4 |               3 |
|  3 | M003 | Speaker  |     200000 |     250000 |   20 |        8 |               1 |
|  2 | K002 | Televisi |     150000 |     200000 |    4 |        2 |               2 |
|  1 | K001 | Kulkas   |     100000 |     150000 |    3 |        1 |               1 |
|  5 | P005 | Setrika  |      90000 |     150000 |   10 |       15 |               2 |
+----+------+----------+------------+------------+------+----------+-----------------+
5 rows in set (0.000 sec)

MariaDB [dbtoko]> SELECT kode, nama_pelanggan, tmp_lahir, tgl_lahir FROM pelanggan;
+------+----------------+------------+------------+
| kode | nama_pelanggan | tmp_lahir  | tgl_lahir  |
+------+----------------+------------+------------+
| 0B1  | jasmine        | Jakarta    | 1993-04-22 |
| 0B2  | Sadam          | Bandung    | 1998-02-16 |
| 0A3  | Michael Brown  | Surabaya   | 1992-09-20 |
| 0A4  | Ariana         | Jakarta    | 1995-01-01 |
| 0A1  | Yohan Doe      | Kalimantan | 1990-01-01 |
| 0A2  | Jane Smith     | Bandung    | 1985-05-15 |
+------+----------------+------------+------------+
6 rows in set (0.001 sec)

MariaDB [dbtoko]> SELECT kode, nama, stok FROM produk WHERE stok = 4;
+------+----------+------+
| kode | nama     | stok |
+------+----------+------+
| K002 | Televisi |    4 |
+------+----------+------+
1 row in set (0.000 sec)

MariaDB [dbtoko]> SELECT * from pelanggan WHERE tmp_lahir='jakarta';
+----+------+----------------+------+-----------+------------+-------+----------+--------+
| id | kode | nama_pelanggan | jk   | tmp_lahir | tgl_lahir  | email | kartu_id | alamat |
+----+------+----------------+------+-----------+------------+-------+----------+--------+
|  1 | 0B1  | jasmine        | P    | Jakarta   | 1993-04-22 | NULL  |        0 |        |
|  4 | 0A4  | Ariana         | P    | Jakarta   | 1995-01-01 | NULL  |        0 |        |
+----+------+----------------+------+-----------+------------+-------+----------+--------+
2 rows in set (0.000 sec)

MariaDB [dbtoko]> SELECT kode, nama_pelanggan, tmp_lahir, tgl_lahir from pelanggan ORDER BY tgl_lahir DESC;
+------+----------------+------------+------------+
| kode | nama_pelanggan | tmp_lahir  | tgl_lahir  |
+------+----------------+------------+------------+
| 0B2  | Sadam          | Bandung    | 1998-02-16 |
| 0A4  | Ariana         | Jakarta    | 1995-01-01 |
| 0B1  | jasmine        | Jakarta    | 1993-04-22 |
| 0A3  | Michael Brown  | Surabaya   | 1992-09-20 |
| 0A1  | Yohan Doe      | Kalimantan | 1990-01-01 |
| 0A2  | Jane Smith     | Bandung    | 1985-05-15 |
+------+----------------+------------+------------+
6 rows in set (0.001 sec)

MariaDB [dbtoko]> SELECT * from produk WHERE stok=3 OR stok=10
    -> SELECT * from produk WHERE stok=3 OR stok=10;
ERROR 1064 (42000): You have an error in your SQL syntax; check the manual that corresponds to your MariaDB server version for the right syntax to use near 'SELECT * from produk WHERE stok=3 OR stok=10' at line 2
MariaDB [dbtoko]> SELECT * from produk WHERE stok=3 OR stok=10;
+----+------+---------+------------+------------+------+----------+-----------------+
| id | kode | nama    | harga_beli | harga_jual | stok | min_stok | jenis_produk_id |
+----+------+---------+------------+------------+------+----------+-----------------+
|  1 | K001 | Kulkas  |     100000 |     150000 |    3 |        1 |               1 |
|  4 | M004 | Radio   |     500000 |     800000 |   10 |        4 |               3 |
|  5 | P005 | Setrika |      90000 |     150000 |   10 |       15 |               2 |
+----+------+---------+------------+------------+------+----------+-----------------+
3 rows in set (0.000 sec)

MariaDB [dbtoko]> SELECT * FROM produk WHERE harga_jual < 5000000 AND harga_jual > 500000;
+----+------+-------+------------+------------+------+----------+-----------------+
| id | kode | nama  | harga_beli | harga_jual | stok | min_stok | jenis_produk_id |
+----+------+-------+------------+------------+------+----------+-----------------+
|  4 | M004 | Radio |     500000 |     800000 |   10 |        4 |               3 |
+----+------+-------+------------+------------+------+----------+-----------------+
1 row in set (0.000 sec)

MariaDB [dbtoko]> SELECT * FROM produk WHERE min_stok > stok;
+----+------+---------+------------+------------+------+----------+-----------------+
| id | kode | nama    | harga_beli | harga_jual | stok | min_stok | jenis_produk_id |
+----+------+---------+------------+------------+------+----------+-----------------+
|  5 | P005 | Setrika |      90000 |     150000 |   10 |       15 |               2 |
+----+------+---------+------------+------------+------+----------+-----------------+
1 row in set (0.000 sec)

MariaDB [dbtoko]> SELECT * FROM pelanggan ORDER BY tgl_lahir DESC;
+----+------+----------------+------+------------+------------+-------+----------+--------+
| id | kode | nama_pelanggan | jk   | tmp_lahir  | tgl_lahir  | email | kartu_id | alamat |
+----+------+----------------+------+------------+------------+-------+----------+--------+
|  2 | 0B2  | Sadam          | L    | Bandung    | 1998-02-16 | NULL  |        0 |        |
|  4 | 0A4  | Ariana         | P    | Jakarta    | 1995-01-01 | NULL  |        0 |        |
|  1 | 0B1  | jasmine        | P    | Jakarta    | 1993-04-22 | NULL  |        0 |        |
|  3 | 0A3  | Michael Brown  | L    | Surabaya   | 1992-09-20 | NULL  |        0 |        |
|  5 | 0A1  | Yohan Doe      | L    | Kalimantan | 1990-01-01 | NULL  |        0 |        |
|  6 | 0A2  | Jane Smith     | P    | Bandung    | 1985-05-15 | NULL  |        0 |        |
+----+------+----------------+------+------------+------------+-------+----------+--------+
6 rows in set (0.001 sec)

MariaDB [dbtoko]> SELECT * FROM pelanggan WHERE tmp_lahir='jakarta' AND jk='P';
+----+------+----------------+------+-----------+------------+-------+----------+--------+
| id | kode | nama_pelanggan | jk   | tmp_lahir | tgl_lahir  | email | kartu_id | alamat |
+----+------+----------------+------+-----------+------------+-------+----------+--------+
|  1 | 0B1  | jasmine        | P    | Jakarta   | 1993-04-22 | NULL  |        0 |        |
|  4 | 0A4  | Ariana         | P    | Jakarta   | 1995-01-01 | NULL  |        0 |        |
+----+------+----------------+------+-----------+------------+-------+----------+--------+
2 rows in set (0.000 sec)

MariaDB [dbtoko]> SELECT * from pelanggan WHERE id IN (2,4,6);
+----+------+----------------+------+-----------+------------+-------+----------+--------+
| id | kode | nama_pelanggan | jk   | tmp_lahir | tgl_lahir  | email | kartu_id | alamat |
+----+------+----------------+------+-----------+------------+-------+----------+--------+
|  2 | 0B2  | Sadam          | L    | Bandung   | 1998-02-16 | NULL  |        0 |        |
|  4 | 0A4  | Ariana         | P    | Jakarta   | 1995-01-01 | NULL  |        0 |        |
|  6 | 0A2  | Jane Smith     | P    | Bandung   | 1985-05-15 | NULL  |        0 |        |
+----+------+----------------+------+-----------+------------+-------+----------+--------+
3 rows in set (0.000 sec)

MariaDB [dbtoko]> SELECT * FROM produk WHERE harga_jual >= 500000 AND harga_jual<= 6000000;
+----+------+-------+------------+------------+------+----------+-----------------+
| id | kode | nama  | harga_beli | harga_jual | stok | min_stok | jenis_produk_id |
+----+------+-------+------------+------------+------+----------+-----------------+
|  4 | M004 | Radio |     500000 |     800000 |   10 |        4 |               3 |
+----+------+-------+------------+------------+------+----------+-----------------+
1 row in set (0.000 sec)

MariaDB [dbtoko]> SELECT * FROM produk WHERE kode LIKE 'K%' OR kode LIKE 'M%';
+----+------+----------+------------+------------+------+----------+-----------------+
| id | kode | nama     | harga_beli | harga_jual | stok | min_stok | jenis_produk_id |
+----+------+----------+------------+------------+------+----------+-----------------+
|  1 | K001 | Kulkas   |     100000 |     150000 |    3 |        1 |               1 |
|  2 | K002 | Televisi |     150000 |     200000 |    4 |        2 |               2 |
|  3 | M003 | Speaker  |     200000 |     250000 |   20 |        8 |               1 |
|  4 | M004 | Radio    |     500000 |     800000 |   10 |        4 |               3 |
+----+------+----------+------------+------------+------+----------+-----------------+
4 rows in set (0.001 sec)

MariaDB [dbtoko]> SELECT * FROM produk WHERE kode LIKE 'M%';
+----+------+---------+------------+------------+------+----------+-----------------+
| id | kode | nama    | harga_beli | harga_jual | stok | min_stok | jenis_produk_id |
+----+------+---------+------------+------------+------+----------+-----------------+
|  3 | M003 | Speaker |     200000 |     250000 |   20 |        8 |               1 |
|  4 | M004 | Radio   |     500000 |     800000 |   10 |        4 |               3 |
+----+------+---------+------------+------------+------+----------+-----------------+
2 rows in set (0.001 sec)

MariaDB [dbtoko]> SELECT * FROM produk WHERE nama LIKE 'Televisi%';
+----+------+----------+------------+------------+------+----------+-----------------+
| id | kode | nama     | harga_beli | harga_jual | stok | min_stok | jenis_produk_id |
+----+------+----------+------------+------------+------+----------+-----------------+
|  2 | K002 | Televisi |     150000 |     200000 |    4 |        2 |               2 |
+----+------+----------+------------+------------+------+----------+-----------------+
1 row in set (0.000 sec)

MariaDB [dbtoko]> SELECT * FROM produk WHERE nama LIKE 'Televisi%';
+----+------+----------+------------+------------+------+----------+-----------------+
| id | kode | nama     | harga_beli | harga_jual | stok | min_stok | jenis_produk_id |
+----+------+----------+------------+------------+------+----------+-----------------+
|  2 | K002 | Televisi |     150000 |     200000 |    4 |        2 |               2 |
+----+------+----------+------------+------------+------+----------+-----------------+
1 row in set (0.000 sec)

MariaDB [dbtoko]> SELECT * FROM pelanggan WHERE nama_pelanggan LIKE 'sa%';
+----+------+----------------+------+-----------+------------+-------+----------+--------+
| id | kode | nama_pelanggan | jk   | tmp_lahir | tgl_lahir  | email | kartu_id | alamat |
+----+------+----------------+------+-----------+------------+-------+----------+--------+
|  2 | 0B2  | Sadam          | L    | Bandung   | 1998-02-16 | NULL  |        0 |        |
+----+------+----------------+------+-----------+------------+-------+----------+--------+
1 row in set (0.000 sec)

MariaDB [dbtoko]> SELECT kode, nama_pelanggan, tmp_lahir, tgl_lahir FROM pelanggan WHERE tmp_lahir NOT LIKE 'jakarta%' AND (nama_pelanggan LIKE '%yo%' OR tmp_lahir LIKE '%yo%');
+------+----------------+------------+------------+
| kode | nama_pelanggan | tmp_lahir  | tgl_lahir  |
+------+----------------+------------+------------+
| 0A1  | Yohan Doe      | Kalimantan | 1990-01-01 |
+------+----------------+------------+------------+
1 row in set (0.000 sec)

MariaDB [dbtoko]> SELECT kode, nama_pelanggan, tmp_lahir, tgl_lahir FROM pelanggan WHERE SUBSTRING(nama_pelanggan, 2, 1) = 'A';
+------+----------------+-----------+------------+
| kode | nama_pelanggan | tmp_lahir | tgl_lahir  |
+------+----------------+-----------+------------+
| 0B1  | jasmine        | Jakarta   | 1993-04-22 |
| 0B2  | Sadam          | Bandung   | 1998-02-16 |
| 0A2  | Jane Smith     | Bandung   | 1985-05-15 |
+------+----------------+-----------+------------+
3 rows in set (0.000 sec)

MariaDB [dbtoko]> SELECT *FROM produk ORDER BY harga_beli DESC LIMIT 2;
+----+------+---------+------------+------------+------+----------+-----------------+
| id | kode | nama    | harga_beli | harga_jual | stok | min_stok | jenis_produk_id |
+----+------+---------+------------+------------+------+----------+-----------------+
|  4 | M004 | Radio   |     500000 |     800000 |   10 |        4 |               3 |
|  3 | M003 | Speaker |     200000 |     250000 |   20 |        8 |               1 |
+----+------+---------+------------+------------+------+----------+-----------------+
2 rows in set (0.000 sec)

MariaDB [dbtoko]> SELECT kode, nama, harga_jual, harga_beli FROM produk ORDER BY harga_jual, harga_beli ASC LIMIT 1;
+------+---------+------------+------------+
| kode | nama    | harga_jual | harga_beli |
+------+---------+------------+------------+
| P005 | Setrika |     150000 |      90000 |
+------+---------+------------+------------+
1 row in set (0.001 sec)

MariaDB [dbtoko]> SELECT kode, nama, stok FROM produk ORDER BY stok DESC LIMIT 1;
+------+---------+------+
| kode | nama    | stok |
+------+---------+------+
| M003 | Speaker |   20 |
+------+---------+------+
1 row in set (0.000 sec)

MariaDB [dbtoko]> SELECT kode, nama, stok FROM produk ORDER BY stok DESC LIMIT 2;
+------+---------+------+
| kode | nama    | stok |
+------+---------+------+
| M003 | Speaker |   20 |
| M004 | Radio   |   10 |
+------+---------+------+
2 rows in set (0.000 sec)

MariaDB [dbtoko]> SELECT kode, nama_pelanggan, tmp_lahir, tgl_lahir FROM pelanggan ORDER BY YEAR (tgl_lahir) ASC LIMIT 1;
+------+----------------+-----------+------------+
| kode | nama_pelanggan | tmp_lahir | tgl_lahir  |
+------+----------------+-----------+------------+
| 0A2  | Jane Smith     | Bandung   | 1985-05-15 |
+------+----------------+-----------+------------+
1 row in set (0.000 sec)

MariaDB [dbtoko]> SELECT kode, nama_pelanggan, tmp_lahir, tgl_lahir FROM pelanggan ORDER BY YEAR (tgl_lahir) DESC LIMIT 1;
+------+----------------+-----------+------------+
| kode | nama_pelanggan | tmp_lahir | tgl_lahir  |
+------+----------------+-----------+------------+
| 0B2  | Sadam          | Bandung   | 1998-02-16 |
+------+----------------+-----------+------------+
1 row in set (0.001 sec)

MariaDB [dbtoko]>