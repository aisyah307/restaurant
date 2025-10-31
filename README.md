# Food Finder

Food Finder adalah aplikasi mobile berbasis Flutter yang membantu pengguna menemukan restoran favorit berdasarkan kategori masakan, melihat detail restoran, dan memberikan ulasan secara sederhana. Aplikasi ini dirancang untuk memberikan pengalaman pengguna yang intuitif, rapi, dan informatif.

## Tema dan Tujuan
Aplikasi ini berfokus pada **eksplorasi restoran dan review pengguna**. Tujuan utamanya adalah:
- Memudahkan pengguna menemukan restoran berdasarkan kategori.
- Menyediakan informasi detail restoran secara lengkap.
- Memberikan interaksi sederhana untuk feedback atau ulasan restoran.

## Daftar Halaman dan Fungsinya

1. **SplashPage**
   - Halaman pembuka aplikasi.
   - Menampilkan logo, judul, subjudul, dan tombol untuk masuk ke halaman utama.
   - Memberikan kesan pertama yang menarik dan navigasi ke halaman berikutnya.

2. **CategoryPage**
   - Menampilkan daftar restoran berdasarkan kategori masakan.
   - Setiap restoran ditampilkan dalam card dengan gambar, nama, kota, kategori, dan rating.
   - Pengguna dapat menekan restoran untuk melihat detail.

3. **DetailPage**
   - Menampilkan informasi lengkap restoran termasuk gambar, alamat, rating, jenis masakan, harga rata-rata, layanan online delivery, table booking, dan jumlah ulasan.
   - Tersedia tombol aksi "Berikan Ulasan" untuk interaksi pengguna.
   - Layout scrollable agar informasi panjang dapat diakses dengan mudah.

## Cara Menjalankan Aplikasi

1. Pastikan Flutter sudah terpasang di komputer. Jika belum, ikuti panduan instalasi resmi Flutter: [Flutter Install](https://flutter.dev/docs/get-started/install)

2. Clone repositori ini ke komputer Anda:
   ```bash
   git clone <URL_REPOSITORY_ANDA>
3. Masuk ke direktori proyek:
   cd food_finder

4. Install dependensi Flutter:
   flutter pub get

5. Jalankan aplikasi pada emulator atau perangkat fisik:
   flutter run

6. Pastikan koneksi internet aktif untuk memuat gambar restoran dari URL.

