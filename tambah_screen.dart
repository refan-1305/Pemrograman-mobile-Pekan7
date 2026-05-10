import 'dart:io';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import '../services/api_service.dart';

class TambahScreen extends StatefulWidget {
  const TambahScreen({super.key});

  @override
  State<TambahScreen> createState() => _TambahScreenState();
}

class _TambahScreenState extends State<TambahScreen> {
  final _formKey = GlobalKey<FormState>();

  final _nimController = TextEditingController();
  final _namaController = TextEditingController();
  final _kelasController = TextEditingController();
  final _jurusanController = TextEditingController();
  final _tahunMasukController = TextEditingController();
  final _agamaController = TextEditingController();
  final _alamatController = TextEditingController();
  final _linkIgController = TextEditingController();
  final _linkLinkedinController = TextEditingController();

  String _jenisKelamin = 'L';
  File? _foto;
  bool _isLoading = false;

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
      setState(() {
        _foto = File(pickedFile.path);
      });
    }
  }

  Future<void> _submit() async {
    if (!_formKey.currentState!.validate()) return;

    setState(() => _isLoading = true);

    try {
      await ApiService.createMahasiswa(
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
        foto: _foto,
      );

      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text('Mahasiswa berhasil ditambahkan!'),
            backgroundColor: Colors.green,
          ),
        );
        Navigator.pop(context, true);
      }
    } catch (e) {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('Gagal: $e'),
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
        title: const Text('Tambah Mahasiswa'),
        backgroundColor: Colors.blue[700],
        foregroundColor: Colors.white,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Form(
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Foto picker
              Center(
                child: GestureDetector(
                  onTap: _pilihFoto,
                  child: Container(
                    width: 120,
                    height: 120,
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      color: Colors.grey[200],
                      border: Border.all(color: Colors.blue, width: 2),
                    ),
                    child: _foto != null
                        ? ClipOval(
                            child: Image.file(_foto!, fit: BoxFit.cover),
                          )
                        : Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Icon(Icons.add_a_photo,
                                  color: Colors.blue[400], size: 32),
                              const SizedBox(height: 4),
                              Text(
                                'Pilih Foto',
                                style: TextStyle(
                                    fontSize: 12, color: Colors.blue[400]),
                              ),
                            ],
                          ),
                  ),
                ),
              ),
              const SizedBox(height: 20),

              _buildTextField(
                controller: _nimController,
                label: 'NIM',
                hint: 'Masukkan NIM',
                icon: Icons.badge,
                validator: (v) =>
                    (v == null || v.isEmpty) ? 'NIM wajib diisi' : null,
              ),
              const SizedBox(height: 12),

              _buildTextField(
                controller: _namaController,
                label: 'Nama Lengkap',
                hint: 'Masukkan nama lengkap',
                icon: Icons.person,
                validator: (v) =>
                    (v == null || v.isEmpty) ? 'Nama wajib diisi' : null,
              ),
              const SizedBox(height: 12),

              // Jenis Kelamin
              const Text('Jenis Kelamin',
                  style: TextStyle(fontWeight: FontWeight.w500)),
              Row(
                children: [
                  Expanded(
                    child: RadioListTile<String>(
                      title: const Text('Laki-laki'),
                      value: 'L',
                      groupValue: _jenisKelamin,
                      onChanged: (v) => setState(() => _jenisKelamin = v!),
                      contentPadding: EdgeInsets.zero,
                    ),
                  ),
                  Expanded(
                    child: RadioListTile<String>(
                      title: const Text('Perempuan'),
                      value: 'P',
                      groupValue: _jenisKelamin,
                      onChanged: (v) => setState(() => _jenisKelamin = v!),
                      contentPadding: EdgeInsets.zero,
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 12),

              _buildTextField(
                controller: _kelasController,
                label: 'Kelas',
                hint: 'Contoh: TI-3A',
                icon: Icons.class_,
                validator: (v) =>
                    (v == null || v.isEmpty) ? 'Kelas wajib diisi' : null,
              ),
              const SizedBox(height: 12),

              _buildTextField(
                controller: _jurusanController,
                label: 'Jurusan',
                hint: 'Contoh: Teknik Informatika',
                icon: Icons.school,
                validator: (v) =>
                    (v == null || v.isEmpty) ? 'Jurusan wajib diisi' : null,
              ),
              const SizedBox(height: 12),

              _buildTextField(
                controller: _tahunMasukController,
                label: 'Tahun Masuk',
                hint: 'Contoh: 2022',
                icon: Icons.calendar_today,
                keyboardType: TextInputType.number,
                validator: (v) {
                  if (v == null || v.isEmpty) return 'Tahun masuk wajib diisi';
                  if (v.length != 4) return 'Masukkan 4 digit tahun';
                  return null;
                },
              ),
              const SizedBox(height: 12),

              _buildTextField(
                controller: _agamaController,
                label: 'Agama',
                hint: 'Contoh: Islam',
                icon: Icons.mosque,
                validator: (v) =>
                    (v == null || v.isEmpty) ? 'Agama wajib diisi' : null,
              ),
              const SizedBox(height: 12),

              _buildTextField(
                controller: _alamatController,
                label: 'Alamat',
                hint: 'Masukkan alamat lengkap',
                icon: Icons.location_on,
                maxLines: 3,
                validator: (v) =>
                    (v == null || v.isEmpty) ? 'Alamat wajib diisi' : null,
              ),
              const SizedBox(height: 12),

              _buildTextField(
                controller: _linkIgController,
                label: 'Link Instagram (Opsional)',
                hint: 'https://instagram.com/...',
                icon: Icons.camera_alt,
              ),
              const SizedBox(height: 12),

              _buildTextField(
                controller: _linkLinkedinController,
                label: 'Link LinkedIn (Opsional)',
                hint: 'https://linkedin.com/in/...',
                icon: Icons.work,
              ),
              const SizedBox(height: 24),

              SizedBox(
                width: double.infinity,
                height: 50,
                child: ElevatedButton(
                  onPressed: _isLoading ? null : _submit,
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.blue[700],
                    foregroundColor: Colors.white,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                  ),
                  child: _isLoading
                      ? const CircularProgressIndicator(
                          color: Colors.white, strokeWidth: 2)
                      : const Text('Simpan Mahasiswa',
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

  Widget _buildTextField({
    required TextEditingController controller,
    required String label,
    required String hint,
    required IconData icon,
    int maxLines = 1,
    TextInputType keyboardType = TextInputType.text,
    String? Function(String?)? validator,
  }) {
    return TextFormField(
      controller: controller,
      maxLines: maxLines,
      keyboardType: keyboardType,
      validator: validator,
      decoration: InputDecoration(
        labelText: label,
        hintText: hint,
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