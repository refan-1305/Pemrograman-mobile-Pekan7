// -------  Nama Program : Integrasi Flutter dengan Laravel REST API untuk Manajemen Data Mahasiswa -------
//------- Author : Refan Rustoni Putra ------
//------- Versi : 10  ------
//------- Ownership : Pribadi------
//------- Deskripsi : Aplikasi manajemen data mahasiswa berbasis Flutter yang terintegrasi dengan Laravel REST API. Fitur meliputi tampil, tambah, edit, hapus data mahasiswa beserta upload foto menggunakan HTTP request. -------
//------- Pekan Ke 7 --------------

//------- Library --------
import 'package:flutter/material.dart';
import '../models/mahasiswa.dart';

class MahasiswaCard extends StatelessWidget {
  final Mahasiswa mahasiswa;
  final VoidCallback onTap;
  final VoidCallback onDelete;
  final VoidCallback onEdit;

  const MahasiswaCard({
    super.key,
    required this.mahasiswa,
    required this.onTap,
    required this.onDelete,
    required this.onEdit,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 6),
      elevation: 3,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12),
      ),
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(12),
        child: Padding(
          padding: const EdgeInsets.all(12),
          child: Row(
            children: [
              // Foto / Avatar
              CircleAvatar(
                radius: 32,
                backgroundColor: Colors.blue[100],
                child: mahasiswa.foto != null
                    ? ClipOval(
                        child: Image.network(
                          mahasiswa.foto!,
                          width: 64,
                          height: 64,
                          fit: BoxFit.cover,
                          errorBuilder: (context, error, stackTrace) {
                            return const Icon(Icons.person,
                                size: 32, color: Colors.blue);
                          },
                        ),
                      )
                    : Text(
                        mahasiswa.nama[0].toUpperCase(),
                        style: const TextStyle(
                          fontSize: 24,
                          fontWeight: FontWeight.bold,
                          color: Colors.blue,
                        ),
                      ),
              ),
              const SizedBox(width: 12),

              // Info Mahasiswa
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      mahasiswa.nama,
                      style: const TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                      ),
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                    ),
                    const SizedBox(height: 4),
                    Text(
                      'NIM: ${mahasiswa.nim}',
                      style: TextStyle(
                        color: Colors.grey[600],
                        fontSize: 13,
                      ),
                    ),
                    const SizedBox(height: 2),
                    Text(
                      mahasiswa.jurusan,
                      style: const TextStyle(fontSize: 12),
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                    ),
                    Text(
                      'Kelas ${mahasiswa.kelas}',
                      style: const TextStyle(fontSize: 12),
                    ),
                  ],
                ),
              ),

              // Tombol Edit & Delete
              Column(
                children: [
                  IconButton(
                    icon: const Icon(Icons.edit,
                        color: Colors.blue, size: 20),
                    onPressed: onEdit,
                    tooltip: 'Edit',
                  ),
                  IconButton(
                    icon: const Icon(Icons.delete,
                        color: Colors.red, size: 20),
                    onPressed: onDelete,
                    tooltip: 'Hapus',
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
