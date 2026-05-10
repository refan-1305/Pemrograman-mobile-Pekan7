// -------  Nama Program : Integrasi Flutter dengan Laravel REST API untuk Manajemen Data Mahasiswa -------
//------- Author : Refan Rustoni Putra ------
//------- Versi : 10  ------
//------- Ownership : Pribadi------
//------- Deskripsi : Aplikasi manajemen data mahasiswa berbasis Flutter yang terintegrasi dengan Laravel REST API. Fitur meliputi tampil, tambah, edit, hapus data mahasiswa beserta upload foto menggunakan HTTP request. -------
//------- Pekan Ke 7 --------------

//------- Library --------
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import '../models/mahasiswa.dart';
import '../services/api_service.dart';

class EditScreen extends StatefulWidget {
  final Mahasiswa mahasiswa;

  const EditScreen({super.key, required this.mahasiswa});

  @override
  State<EditScreen> createState() => _EditScreenState();
}

class _EditScreenState extends State<EditScreen> {
  final _formKey = GlobalKey<FormState>();

  late TextEditingController _nimController;
  late TextEditingController _namaController;
  late TextEditingController _kelasController;
  late TextEditingController _jurusanController;
  late TextEditingController _tahunMasukController;
  late TextEditingController _agamaController;
  late TextEditingController _alamatController;
  late TextEditingController _linkIgController;
  late TextEditingController _linkLinkedinController;

  late String _jenisKelamin;
  File? _fotoFile;
  bool _isLoading = false;

  @override
  void initState() {
    super.initState();
    // Pre-fill form dengan data yang sudah ada
    final m = widget.mahasiswa;
    _nimController = TextEditingController(text: m.nim);
    _namaController = TextEditingController(text: m.nama);
    _kelasController = TextEditingController(text: m.kelas);
    _jurusanController = TextEditingController(text: m.jurusan);
    _tahunMasukController = TextEditingController(text: '${m.tahunMasuk}');
    _agamaController = TextEditingController(text: m.agama);
    _alamatController = TextEditingController(text: m.alamat);
    _linkIgController = TextEditingController(text: m.linkIg ?? '');
    _linkLinkedinController = TextEditingController(text: m.linkLinkedin ?? '');
    _jenisKelamin = m.jenisKelamin;
  }

  @override
  void dispose() {
    _nimController.dispose();
    _namaController.dispose();
    _kelasController.dispose();
    _jurusanController.dispose();
    _tahunMasukController.dispose();
    _agamaController.dispose();
    _alamatController.dispose();
    _linkIgController.dispose();
    _linkLinkedinController.dispose();
    super.dispose();
  }

  Future<void> _pilihFoto() async {
    final picker = ImagePicker();
    final pickedFile = await picker.pickImage(
      source: ImageSource.gallery,
      maxWidth: 800,
      maxHeight: 800,
      imageQuality: 80,
    );
    if (pickedFile != null) {
      setState(() => _fotoFile = File(pickedFile.path));
    }
  }

  Future<void> _submit() async {
    if (!_formKey.currentState!.validate()) return;

    setState(() => _isLoading = true);

    try {
      await ApiService.updateMahasiswa(
        id: widget.mahasiswa.id,
        nim: _nimController.text.trim(),
        nama: _namaController.text.trim(),
        jenisKelamin: _jenisKelamin,
        kelas: _kelasController.text.trim(),
        jurusan: _jurusanController.text.trim(),
        tahunMasuk: _tahunMasukController.text.trim(),
        agama: _agamaController.text.trim(),
        alamat: _alamatController.text.trim(),
        linkIg: _linkIgController.text.trim(),
        linkLinkedin: _linkLinkedinController.text.trim(),
        foto: _fotoFile,
      );

      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text('Data berhasil diupdate!'),
            backgroundColor: Colors.green,
          ),
        );
        Navigator.pop(context, true);
      }
    } catch (e) {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('Gagal update: $e'),
            backgroundColor: Colors.red,
          ),
        );
      }
    } finally {
      if (mounted) setState(() => _isLoading = false);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Edit Mahasiswa'),
        backgroundColor: Colors.orange[700],
        foregroundColor: Colors.white,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Form(
          key: _formKey,
          child: Column(
            children: [
              // Foto picker
              Center(
                child: GestureDetector(
                  onTap: _pilihFoto,
                  child: CircleAvatar(
                    radius: 60,
                    backgroundColor: Colors.grey[300],
                    backgroundImage: _fotoFile != null
                        ? FileImage(_fotoFile!) as ImageProvider
                        : (widget.mahasiswa.foto != null
                            ? NetworkImage(widget.mahasiswa.foto!)
                            : null),
                    child: _fotoFile == null && widget.mahasiswa.foto == null
                        ? const Icon(Icons.add_a_photo, size: 32)
                        : null,
                  ),
                ),
              ),
              const SizedBox(height: 8),
              TextButton(
                onPressed: _pilihFoto,
                child: const Text('Ganti Foto'),
              ),
              const SizedBox(height: 12),

              _buildTextField(_nimController, 'NIM', Icons.badge),
              const SizedBox(height: 12),
              _buildTextField(_namaController, 'Nama Lengkap', Icons.person),
              const SizedBox(height: 12),

              // Jenis Kelamin
              Row(
                children: [
                  const Text('Jenis Kelamin: '),
                  Expanded(
                    child: RadioListTile<String>(
                      title: const Text('L'),
                      value: 'L',
                      groupValue: _jenisKelamin,
                      onChanged: (v) => setState(() => _jenisKelamin = v!),
                      contentPadding: EdgeInsets.zero,
                    ),
                  ),
                  Expanded(
                    child: RadioListTile<String>(
                      title: const Text('P'),
                      value: 'P',
                      groupValue: _jenisKelamin,
                      onChanged: (v) => setState(() => _jenisKelamin = v!),
                      contentPadding: EdgeInsets.zero,
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 12),

              _buildTextField(_kelasController, 'Kelas', Icons.class_),
              const SizedBox(height: 12),
              _buildTextField(_jurusanController, 'Jurusan', Icons.school),
              const SizedBox(height: 12),
              _buildTextField(
                _tahunMasukController, 'Tahun Masuk', Icons.calendar_today,
                keyboardType: TextInputType.number,
              ),
              const SizedBox(height: 12),
              _buildTextField(_agamaController, 'Agama', Icons.mosque),
              const SizedBox(height: 12),
              _buildTextField(
                _alamatController, 'Alamat', Icons.location_on,
                maxLines: 3,
              ),
              const SizedBox(height: 12),
              _buildTextField(
                _linkIgController, 'Link Instagram (Opsional)', Icons.camera_alt,
              ),
              const SizedBox(height: 12),
              _buildTextField(
                _linkLinkedinController, 'Link LinkedIn (Opsional)', Icons.work,
              ),
              const SizedBox(height: 24),

              SizedBox(
                width: double.infinity,
                height: 50,
                child: ElevatedButton(
                  onPressed: _isLoading ? null : _submit,
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.orange[700],
                    foregroundColor: Colors.white,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                  ),
                  child: _isLoading
                      ? const CircularProgressIndicator(
                          color: Colors.white, strokeWidth: 2)
                      : const Text('Update Mahasiswa',
                          style: TextStyle(fontSize: 16)),
                ),
              ),
              const SizedBox(height: 24),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildTextField(
    TextEditingController controller,
    String label,
    IconData icon, {
    int maxLines = 1,
    TextInputType keyboardType = TextInputType.text,
  }) {
    return TextFormField(
      controller: controller,
      maxLines: maxLines,
      keyboardType: keyboardType,
      validator: (v) =>
          (v == null || v.isEmpty) ? '$label wajib diisi' : null,
      decoration: InputDecoration(
        labelText: label,
        prefixIcon: Icon(icon),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10),
        ),
        filled: true,
        fillColor: Colors.grey[50],
      ),
    );
  }
}
