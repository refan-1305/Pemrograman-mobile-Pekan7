import 'package:flutter/material.dart';
import '../models/mahasiswa.dart';

class DetailScreen extends StatelessWidget {
  final Mahasiswa mahasiswa;

  const DetailScreen({super.key, required this.mahasiswa});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Detail Mahasiswa'),
        backgroundColor: Colors.blue[700],
        foregroundColor: Colors.white,
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            // Header dengan foto
            Container(
              width: double.infinity,
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                  colors: [Colors.blue[700]!, Colors.blue[400]!],
                ),
              ),
              padding: const EdgeInsets.all(24),
              child: Column(
                children: [
                  CircleAvatar(
                    radius: 60,
                    backgroundColor: Colors.white,
                    child: mahasiswa.foto != null
                        ? ClipOval(
                            child: Image.network(
                              mahasiswa.foto!,
                              width: 120,
                              height: 120,
                              fit: BoxFit.cover,
                              errorBuilder: (_, __, ___) => const Icon(
                                  Icons.person,
                                  size: 60,
                                  color: Colors.blue),
                            ),
                          )
                        : const Icon(Icons.person,
                            size: 60, color: Colors.blue),
                  ),
                  const SizedBox(height: 16),
                  Text(
                    mahasiswa.nama,
                    style: const TextStyle(
                      fontSize: 22,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                    ),
                    textAlign: TextAlign.center,
                  ),
                  Text(
                    mahasiswa.nim,
                    style: const TextStyle(
                      fontSize: 16,
                      color: Colors.white70,
                    ),
                  ),
                ],
              ),
            ),

            // Info detail
            Padding(
              padding: const EdgeInsets.all(16),
              child: Column(
                children: [
                  _buildInfoCard('Informasi Akademik', [
                    _buildInfoRow(Icons.badge, 'NIM', mahasiswa.nim),
                    _buildInfoRow(Icons.class_, 'Kelas', mahasiswa.kelas),
                    _buildInfoRow(Icons.school, 'Jurusan', mahasiswa.jurusan),
                    _buildInfoRow(Icons.calendar_today, 'Tahun Masuk',
                        '${mahasiswa.tahunMasuk}'),
                  ]),
                  const SizedBox(height: 12),
                  _buildInfoCard('Informasi Pribadi', [
                    _buildInfoRow(Icons.person, 'Nama', mahasiswa.nama),
                    _buildInfoRow(
                        Icons.wc, 'Jenis Kelamin', mahasiswa.jenisKelaminText),
                    _buildInfoRow(Icons.mosque, 'Agama', mahasiswa.agama),
                    _buildInfoRow(
                        Icons.location_on, 'Alamat', mahasiswa.alamat),
                  ]),
                  if (mahasiswa.linkIg != null ||
                      mahasiswa.linkLinkedin != null) ...[
                    const SizedBox(height: 12),
                    _buildInfoCard('Media Sosial', [
                      if (mahasiswa.linkIg != null)
                        _buildInfoRow(
                            Icons.camera_alt, 'Instagram', mahasiswa.linkIg!),
                      if (mahasiswa.linkLinkedin != null)
                        _buildInfoRow(
                            Icons.work, 'LinkedIn', mahasiswa.linkLinkedin!),
                    ]),
                  ],
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildInfoCard(String title, List<Widget> items) {
    return Card(
      elevation: 2,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              title,
              style: const TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.bold,
                color: Colors.blue,
              ),
            ),
            const Divider(),
            ...items,
          ],
        ),
      ),
    );
  }

  Widget _buildInfoRow(IconData icon, String label, String value) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 6),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Icon(icon, size: 18, color: Colors.blue[400]),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  label,
                  style: TextStyle(fontSize: 12, color: Colors.grey[500]),
                ),
                Text(value, style: const TextStyle(fontSize: 14)),
              ],
            ),
          ),
        ],
      ),
    );
  }
}