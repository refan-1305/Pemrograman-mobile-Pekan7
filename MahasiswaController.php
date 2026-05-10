// -------  Nama Program : Integrasi Flutter dengan Laravel REST API untuk Manajemen Data Mahasiswa -------
//------- Author : Refan Rustoni Putra ------
//------- Versi : 10  ------
//------- Ownership : Pribadi------
//------- Deskripsi : Aplikasi manajemen data mahasiswa berbasis Flutter yang terintegrasi dengan Laravel REST API.
Fitur meliputi tampil, tambah, edit, hapus data mahasiswa beserta upload foto menggunakan HTTP request. -------
//------- Pekan Ke 7 --------------

//------- Library --------

<?php

namespace App\Http\Controllers;

use App\Models\Mahasiswa;
use Illuminate\Http\Request;
use Illuminate\Http\JsonResponse;
use Illuminate\Support\Facades\Storage;
use Illuminate\Support\Facades\Validator;

/**
 * @OA\Info(
 *     title="API Mahasiswa",
 *     version="1.0.0",
 *     description="Dokumentasi API Mahasiswa Laravel"
 * )
 */
class MahasiswaController extends Controller
{
    /**
     * @OA\Get(
     *     path="/api/mahasiswa",
     *     summary="Ambil semua data mahasiswa",
     *     tags={"Mahasiswa"},
     *     @OA\Response(
     *         response=200,
     *         description="Berhasil mengambil data mahasiswa"
     *     )
     * )
     */
    // GET semua mahasiswa
    public function index(): JsonResponse
    {
        $mahasiswas = Mahasiswa::latest()->get();

        return response()->json([
            'status'  => true,
            'message' => 'Data Mahasiswa',
            'data'    => $mahasiswas,
        ], 200);
    }

    /**
     * @OA\Post(
     *     path="/api/mahasiswa",
     *     summary="Tambah mahasiswa baru",
     *     tags={"Mahasiswa"},
     *     @OA\RequestBody(
     *         required=true,
     *         @OA\JsonContent(
     *             required={"nim","nama","jenis_kelamin","kelas","jurusan","tahun_masuk","agama","alamat"},
     *             @OA\Property(property="nim", type="string", example="10224005"),
     *             @OA\Property(property="nama", type="string", example="Refan Rustoni Putra"),
     *             @OA\Property(property="jenis_kelamin", type="string", example="L"),
     *             @OA\Property(property="kelas", type="string", example="TK-1"),
     *             @OA\Property(property="jurusan", type="string", example="Teknik Komputer"),
     *             @OA\Property(property="tahun_masuk", type="string", example="2024"),
     *             @OA\Property(property="agama", type="string", example="Islam"),
     *             @OA\Property(property="alamat", type="string", example="Bandung"),
     *             @OA\Property(property="link_ig", type="string", example="https://instagram.com/refan"),
     *             @OA\Property(property="link_linkedin", type="string", example="https://linkedin.com/in/refan")
     *         )
     *     ),
     *     @OA\Response(
     *         response=201,
     *         description="Mahasiswa berhasil ditambahkan"
     *     )
     * )
     */
    // POST tambah mahasiswa baru
    public function store(Request $request): JsonResponse
    {
        $validator = Validator::make($request->all(), [
            'nim'           => 'required|string|max:20|unique:mahasiswas,nim',
            'nama'          => 'required|string|max:100',
            'jenis_kelamin' => 'required|in:L,P',
            'kelas'         => 'required|string|max:10',
            'jurusan'       => 'required|string|max:100',
            'tahun_masuk'   => 'required|digits:4',
            'agama'         => 'required|string|max:20',
            'alamat'        => 'required|string',
            'foto'          => 'nullable|image|mimes:jpg,jpeg,png|max:2048',
            'link_ig'       => 'nullable|url',
            'link_linkedin' => 'nullable|url',
        ]);

        if ($validator->fails()) {
            return response()->json([
                'status'  => false,
                'message' => 'Validasi gagal',
                'errors'  => $validator->errors(),
            ], 422);
        }

        $data = $request->except('foto');

        if ($request->hasFile('foto')) {
            $data['foto'] = $request->file('foto')->store('fotos', 'public');
        }

        $mahasiswa = Mahasiswa::create($data);

        return response()->json([
            'status'  => true,
            'message' => 'Mahasiswa berhasil ditambahkan',
            'data'    => $mahasiswa,
        ], 201);
    }

    // GET detail satu mahasiswa
    public function show(string $id): JsonResponse
    {
        $mahasiswa = Mahasiswa::find($id);

        if (!$mahasiswa) {
            return response()->json([
                'status'  => false,
                'message' => 'Mahasiswa tidak ditemukan',
                'data'    => null,
            ], 404);
        }

        return response()->json([
            'status'  => true,
            'message' => 'Detail Mahasiswa',
            'data'    => $mahasiswa,
        ], 200);
    }

    // PUT update mahasiswa
    public function update(Request $request, string $id): JsonResponse
    {
        $mahasiswa = Mahasiswa::find($id);

        if (!$mahasiswa) {
            return response()->json([
                'status'  => false,
                'message' => 'Mahasiswa tidak ditemukan',
                'data'    => null,
            ], 404);
        }

        $validator = Validator::make($request->all(), [
            'nim'           => 'sometimes|required|string|max:20|unique:mahasiswas,nim,' . $id,
            'nama'          => 'sometimes|required|string|max:100',
            'jenis_kelamin' => 'sometimes|required|in:L,P',
            'kelas'         => 'sometimes|required|string|max:10',
            'jurusan'       => 'sometimes|required|string|max:100',
            'tahun_masuk'   => 'sometimes|required|digits:4',
            'agama'         => 'sometimes|required|string|max:20',
            'alamat'        => 'sometimes|required|string',
            'foto'          => 'nullable|image|mimes:jpg,jpeg,png|max:2048',
            'link_ig'       => 'nullable|url',
            'link_linkedin' => 'nullable|url',
        ]);

        if ($validator->fails()) {
            return response()->json([
                'status'  => false,
                'message' => 'Validasi gagal',
                'errors'  => $validator->errors(),
            ], 422);
        }

        $data = $request->except('foto');

        if ($request->hasFile('foto')) {
            $fotoLama = $mahasiswa->getRawOriginal('foto');

            if ($fotoLama) {
                Storage::disk('public')->delete($fotoLama);
            }

            $data['foto'] = $request->file('foto')->store('fotos', 'public');
        }

        $mahasiswa->update($data);

        return response()->json([
            'status'  => true,
            'message' => 'Mahasiswa berhasil diupdate',
            'data'    => $mahasiswa->fresh(),
        ], 200);
    }
    /**
     * @OA\Delete(
     *     path="/api/mahasiswa/{id}",
     *     summary="Hapus data mahasiswa",
     *     tags={"Mahasiswa"},
     *     @OA\Parameter(
     *         name="id",
     *         in="path",
     *         required=true,
     *         description="ID mahasiswa",
     *         @OA\Schema(type="integer")
     *     ),
     *     @OA\Response(
     *         response=200,
     *         description="Mahasiswa berhasil dihapus"
     *     ),
     *     @OA\Response(
     *         response=404,
     *         description="Mahasiswa tidak ditemukan"
     *     )
     * )
     */
    // DELETE hapus mahasiswa
    public function destroy(string $id): JsonResponse
    {
        $mahasiswa = Mahasiswa::find($id);

        if (!$mahasiswa) {
            return response()->json([
                'status'  => false,
                'message' => 'Mahasiswa tidak ditemukan',
                'data'    => null,
            ], 404);
        }

        $fotoLama = $mahasiswa->getRawOriginal('foto');

        if ($fotoLama) {
            Storage::disk('public')->delete($fotoLama);
        }

        $mahasiswa->delete();

        return response()->json([
            'status'  => true,
            'message' => 'Mahasiswa berhasil dihapus',
            'data'    => null,
        ], 200);
    }
}
