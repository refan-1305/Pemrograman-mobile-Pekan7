# 📱 Manajemen Data Mahasiswa
### Integrasi Flutter dengan Laravel REST API

> Tugas Praktikum Pekan Ke-6 — Pemrograman Mobile  
> Program Studi Teknik Komputer — Universitas Komputer Indonesia

---

## 👤 Identitas

| | |
|---|---|
| **Nama** | Refan Rustoni Putra |
| **NIM** | 10824005 |
| **Kelas** | TK-1 / D3 2024 |
| **Mata Kuliah** | Pemrograman Mobile |
| **Dosen** | Dr. Agus Mulyana, MT |

---

## 📋 Deskripsi

Aplikasi manajemen data mahasiswa berbasis Flutter yang terintegrasi dengan Laravel REST API. Fitur meliputi tampil, tambah, edit, hapus data mahasiswa beserta upload foto menggunakan HTTP request.

---

## 🛠️ Teknologi

**Backend**
- Laravel 11 (PHP)
- MySQL
- REST API + JSON
- Swagger (L5-Swagger)

**Frontend**
- Flutter (Dart)
- Package `http`
- Package `image_picker`

**Tools**
- XAMPP
- Postman
- Android Emulator
- VS Code

---

## ✨ Fitur

- ✅ Tampilkan daftar mahasiswa
- ✅ Tambah mahasiswa baru + upload foto
- ✅ Edit data mahasiswa
- ✅ Hapus mahasiswa
- ✅ Detail lengkap mahasiswa
- ✅ Pull-to-refresh
- ✅ Validasi form
- ✅ Error handling dengan Snackbar
- ✅ Dokumentasi API dengan Swagger

---

## 🗄️ Struktur Database

| Field | Tipe | Keterangan |
|-------|------|------------|
| id | INT | Primary key auto increment |
| nim | VARCHAR(20) | NIM unik mahasiswa |
| nama | VARCHAR(100) | Nama lengkap |
| jenis_kelamin | ENUM(L,P) | Jenis kelamin |
| kelas | VARCHAR(10) | Kelas mahasiswa |
| jurusan | VARCHAR(100) | Program studi |
| tahun_masuk | YEAR | Tahun masuk |
| agama | VARCHAR(20) | Agama |
| alamat | TEXT | Alamat lengkap |
| foto | VARCHAR | Path foto (nullable) |
| link_ig | VARCHAR | Link Instagram (nullable) |
| link_linkedin | VARCHAR | Link LinkedIn (nullable) |

---

## 🚀 Cara Menjalankan

### Backend (Laravel)

**1. Clone & Install**
```bash
git clone https://github.com/refan-1305/pemrograman_mobile_pekan6.git
cd mahasiswa-api
composer install
```

**2. Konfigurasi .env**
```env
DB_CONNECTION=mysql
DB_HOST=127.0.0.1
DB_PORT=3306
DB_DATABASE=db_mahasiswa
DB_USERNAME=root
DB_PASSWORD=
```

**3. Setup Database**
```bash
php artisan migrate
php artisan storage:link
```

**4. Jalankan Server**
```bash
php artisan serve
```
Server berjalan di `http://localhost:8000`

---

### Frontend (Flutter)

**1. Masuk folder Flutter**
```bash
cd mahasiswa_app
flutter pub get
```

**2. Sesuaikan Base URL** di `lib/services/api_service.dart`
```dart
// Untuk Android Emulator
static const String baseUrl = 'http://10.0.2.2:8000/api';

// Untuk HP Fisik 
static const String baseUrl = 'http://192.168.1.XXX:8000/api';
```

**3. Jalankan Aplikasi**
```bash
flutter run
```

---

## 📡 API Endpoints

| Method | Endpoint | Fungsi |
|--------|----------|--------|
| GET | `/api/mahasiswa` | Ambil semua data mahasiswa |
| POST | `/api/mahasiswa` | Tambah mahasiswa baru |
| GET | `/api/mahasiswa/{id}` | Ambil detail mahasiswa |
| PUT | `/api/mahasiswa/{id}` | Update data mahasiswa |
| DELETE | `/api/mahasiswa/{id}` | Hapus mahasiswa |

**Format Response:**
```json
{
    "status": true,
    "message": "Data Mahasiswa",
    "data": []
}
```

---

## 📚 Swagger Documentation

Setelah server Laravel berjalan, akses dokumentasi API di:
```
http://localhost:8000/api/documentation
```

---

## 📁 Struktur Folder

```
📁 mahasiswa-api/              ← Laravel Backend
├── 📁 app/Http/Controllers/
│   └── MahasiswaController.php
├── 📁 app/Models/
│   └── Mahasiswa.php
├── 📁 database/migrations/
├── 📁 routes/
│   └── api.php
└── .env

📁 mahasiswa_app/              ← Flutter Frontend
├── 📁 lib/
│   ├── 📁 models/
│   │   └── mahasiswa.dart
│   ├── 📁 services/
│   │   └── api_service.dart
│   ├── 📁 screens/
│   │   ├── mahasiswa_screen.dart
│   │   ├── detail_screen.dart
│   │   ├── tambah_screen.dart
│   │   └── edit_screen.dart
│   ├── 📁 widgets/
│   │   └── mahasiswa_card.dart
│   └── main.dart
└── pubspec.yaml
```

---

## 🔗 Links

- 🔗 LinkedIn: [Refan Rustoni Putra](https://www.linkedin.com/in/refan-rustoni-putra-a381b2401/)

---

<p align="center">
  Dibuat dengan ❤️ untuk tugas Pemrograman Mobile — UNIKOM 2026
</p>
