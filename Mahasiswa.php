// -------  Nama Program : Integrasi Flutter dengan Laravel REST API untuk Manajemen Data Mahasiswa -------
//------- Author : Refan Rustoni Putra ------
//------- Versi : 10  ------
//------- Ownership : Pribadi------
//------- Deskripsi : Aplikasi manajemen data mahasiswa berbasis Flutter yang terintegrasi dengan Laravel REST API.
Fitur meliputi tampil, tambah, edit, hapus data mahasiswa beserta upload foto menggunakan HTTP request. -------
//------- Pekan Ke 7 --------------

//------- Library --------

<?php

namespace App\Models;

use Illuminate\Database\Eloquent\Factories\HasFactory;
use Illuminate\Database\Eloquent\Model;

class Mahasiswa extends Model
{
    use HasFactory;

    protected $table = 'mahasiswas';

    protected $fillable = [
        'nim',
        'nama',
        'jenis_kelamin',
        'kelas',
        'jurusan',
        'tahun_masuk',
        'agama',
        'alamat',
        'foto',
        'link_ig',
        'link_linkedin',
    ];

    // Otomatis ubah path foto jadi URL lengkap
    public function getFotoAttribute($value): ?string
    {
        if ($value) {
            return asset('storage/' . $value);
        }
        return null;
    }
}
