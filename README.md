# Katalog Jenis Pembangkit Listrik

Aplikasi Flutter sederhana untuk mengenal berbagai jenis pembangkit listrik di Indonesia (PLTA, PLTU, PLTS, PLTB, PLTP). Dibuat dalam satu file `main.dart` sebagai tugas mata kuliah Pemrograman Aplikasi Bergerak.

## Fitur

- Daftar pembangkit listrik dalam bentuk kartu informasi
- Kartu ringkasan: total jenis, jumlah pembangkit terbarukan, dan jumlah favorit
- Tombol "Tandai Favorit" dengan callback `onPressed` yang memperbarui tampilan
- Tampilan responsif, tidak overflow pada layar sempit

## Struktur Kode (`lib/main.dart`)

| Bagian | Keterangan |
|---|---|
| `Pembangkit` | Model data (nama, sumber energi, lokasi, kapasitas MW, efisiensi, status terbarukan) |
| `MyApp` | Satu-satunya `MaterialApp` beserta `ThemeData` |
| `HalamanUtama` | Halaman utama dengan `Scaffold` |
| `KartuRingkasan` | Custom widget ringkasan statistik |
| `KartuPembangkit` | Custom widget kartu tiap pembangkit |

## Cara Menjalankan

```bash
flutter pub get
flutter run
```

## Catatan

Nilai kapasitas dan efisiensi pada data adalah angka perkiraan untuk keperluan latihan.

## Pembuat

Amanda Damayanti - 202432027
Institut Teknologi PLN
