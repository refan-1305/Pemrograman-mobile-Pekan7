<?php
// -------  Nama Program : Integrasi Flutter dengan Laravel REST API untuk Manajemen Data Mahasiswa -------
//------- Author : Refan Rustoni Putra ------
//------- Versi : 10  ------
//------- Ownership : Pribadi------
//------- Deskripsi : Aplikasi manajemen data mahasiswa berbasis Flutter yang terintegrasi dengan Laravel REST API. Fitur meliputi tampil, tambah, edit, hapus data mahasiswa beserta upload foto menggunakan HTTP request. -------
//------- Pekan Ke 7 --------------

//------- Library --------
use Illuminate\Database\Migrations\Migration;
use Illuminate\Database\Schema\Blueprint;
use Illuminate\Support\Facades\Schema;

return new class extends Migration
{
    public function up(): void
    {
        Schema::create('mahasiswas', function (Blueprint $table) {
            $table->id();
            $table->string('nim', 20)->unique();
            $table->string('nama', 100);
            $table->enum('jenis_kelamin', ['L', 'P']);
            $table->string('kelas', 10);
            $table->string('jurusan', 100);
            $table->year('tahun_masuk');
            $table->string('agama', 20);
            $table->text('alamat');
            $table->string('foto')->nullable();
            $table->string('link_ig')->nullable();
            $table->string('link_linkedin')->nullable();
            $table->timestamps();
        });
    }

    public function down(): void
    {
        Schema::dropIfExists('mahasiswas');
    }
};
