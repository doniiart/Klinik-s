import 'package:material_ui/material_ui.dart';
import '../model/dokter.dart';
import '../service/dokter_service.dart';

class DokterUpdateForm extends StatefulWidget {
  final Dokter dokter;

  const DokterUpdateForm({super.key, required this.dokter});

  @override
  State<DokterUpdateForm> createState() => _DokterUpdateFormState();
}

class _DokterUpdateFormState extends State<DokterUpdateForm> {
  final _formKey = GlobalKey<FormState>();
  late TextEditingController _namaDokterCtrl;
  late TextEditingController _spesialisCtrl;
  late TextEditingController _noHpCtrl;
  bool _isSaving = false;

  @override
  void initState() {
    super.initState();
    _namaDokterCtrl = TextEditingController(text: widget.dokter.namaDokter);
    _spesialisCtrl = TextEditingController(text: widget.dokter.spesialis);
    _noHpCtrl = TextEditingController(text: widget.dokter.noHp);
  }

  @override
  void dispose() {
    _namaDokterCtrl.dispose();
    _spesialisCtrl.dispose();
    _noHpCtrl.dispose();
    super.dispose();
  }

  Future<void> _ubahData() async {
    if (!_formKey.currentState!.validate()) return;

    setState(() => _isSaving = true);
    try {
      Dokter dokterUpdate = Dokter(
        id: widget.dokter.id,
        namaDokter: _namaDokterCtrl.text.trim(),
        spesialis: _spesialisCtrl.text.trim(),
        noHp: _noHpCtrl.text.trim(),
      );
      Dokter hasil = await DokterService().ubah(
        dokterUpdate,
        widget.dokter.id ?? "1",
      );
      if (!mounted) return;
      Navigator.pop(context, hasil);
    } catch (e) {
      if (!mounted) return;
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text("Gagal memperbarui data: $e")),
      );
    } finally {
      if (mounted) setState(() => _isSaving = false);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Ubah Data Dokter"),
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
                onPressed: _isSaving ? null : _ubahData,
                icon: _isSaving
                    ? const SizedBox(
                        width: 18,
                        height: 18,
                        child: CircularProgressIndicator(
                            strokeWidth: 2, color: Colors.white),
                      )
                    : const Icon(Icons.check_circle_outline),
                label: Text(_isSaving ? "Menyimpan..." : "Simpan Perubahan"),
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.orange.shade700,
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
