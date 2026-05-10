// -------  Nama Program : Integrasi Flutter dengan Laravel REST API untuk Manajemen Data Mahasiswa -------
//------- Author : Refan Rustoni Putra ------
//------- Versi : 10  ------
//------- Ownership : Pribadi------
//------- Deskripsi : Aplikasi manajemen data mahasiswa berbasis Flutter yang terintegrasi dengan Laravel REST API.
Fitur meliputi tampil, tambah, edit, hapus data mahasiswa beserta upload foto menggunakan HTTP request. -------
//------- Pekan Ke 7 --------------

//------- Library --------

<?php

use Illuminate\Support\Facades\Route;
use App\Http\Controllers\MahasiswaController;

Route::get('/mahasiswa',         [MahasiswaController::class, 'index']);
Route::post('/mahasiswa',        [MahasiswaController::class, 'store']);
Route::get('/mahasiswa/{id}',    [MahasiswaController::class, 'show']);
Route::put('/mahasiswa/{id}',    [MahasiswaController::class, 'update']);
Route::post('/mahasiswa/{id}',   [MahasiswaController::class, 'update']);
Route::delete('/mahasiswa/{id}', [MahasiswaController::class, 'destroy']);
