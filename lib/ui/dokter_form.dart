import 'package:flutter/material.dart';
import '../model/dokter.dart';
import '../service/dokter_service.dart';

class DokterForm extends StatefulWidget {
  const DokterForm({super.key});

  @override
  State<DokterForm> createState() => _DokterFormState();
}

class _DokterFormState extends State<DokterForm> {
  final _formKey = GlobalKey<FormState>();
  final _namaDokterCtrl = TextEditingController();
  final _spesialisCtrl = TextEditingController();
  final _noHpCtrl = TextEditingController();
  bool _isSaving = false;

  @override
  void dispose() {
    _namaDokterCtrl.dispose();
    _spesialisCtrl.dispose();
    _noHpCtrl.dispose();
    super.dispose();
  }

  Future<void> _simpanData() async {
    if (!_formKey.currentState!.validate()) return;

    setState(() => _isSaving = true);
    try {
      Dokter dokterBaru = Dokter(
        namaDokter: _namaDokterCtrl.text.trim(),
        spesialis: _spesialisCtrl.text.trim(),
        noHp: _noHpCtrl.text.trim(),
      );
      Dokter hasil = await DokterService().simpan(dokterBaru);
      if (!mounted) return;
      Navigator.pop(context, hasil);
    } catch (e) {
      if (!mounted) return;
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text("Gagal menyimpan data: $e")),
      );
    } finally {
      if (mounted) setState(() => _isSaving = false);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Tambah Data Dokter"),
        backgroundColor: Colors.teal,
        foregroundColor: Colors.white,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(20),
        child: Form(
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              TextFormField(
                controller: _namaDokterCtrl,
                decoration: InputDecoration(
                  labelText: "Nama Lengkap & Gelar Dokter",
                  hintText: "Contoh: dr. Budi Santoso, Sp.PD",
                  prefixIcon: const Icon(Icons.person_outline),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                ),
                validator: (value) => value == null || value.isEmpty
                    ? "Nama dokter wajib diisi"
                    : null,
              ),
              const SizedBox(height: 16),
              TextFormField(
                controller: _spesialisCtrl,
                decoration: InputDecoration(
                  labelText: "Spesialis / Poli",
                  hintText: "Contoh: Poli Penyakit Dalam",
                  prefixIcon: const Icon(Icons.local_hospital_outlined),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                ),
                validator: (value) => value == null || value.isEmpty
                    ? "Spesialis wajib diisi"
                    : null,
              ),
              const SizedBox(height: 16),
              TextFormField(
                controller: _noHpCtrl,
                keyboardType: TextInputType.phone,
                decoration: InputDecoration(
                  labelText: "Nomor Telepon / HP",
                  hintText: "Contoh: 081234567890",
                  prefixIcon: const Icon(Icons.phone_outlined),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                ),
                validator: (value) => value == null || value.isEmpty
                    ? "Nomor HP wajib diisi"
                    : null,
              ),
              const SizedBox(height: 24),
              ElevatedButton.icon(
                onPressed: _isSaving ? null : _simpanData,
                icon: _isSaving
                    ? const SizedBox(
                        width: 18,
                        height: 18,
                        child: CircularProgressIndicator(
                            strokeWidth: 2, color: Colors.white),
                      )
                    : const Icon(Icons.save_rounded),
                label: Text(_isSaving ? "Menyimpan..." : "Simpan Data Dokter"),
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.teal,
                  foregroundColor: Colors.white,
                  padding: const EdgeInsets.symmetric(vertical: 14),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
