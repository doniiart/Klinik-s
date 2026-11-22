import 'package:flutter/material.dart';
import '../model/dokter.dart';
import '../service/dokter_service.dart';
import 'dokter_update_form.dart';

class DokterDetail extends StatelessWidget {
  final Dokter dokter;

  const DokterDetail({super.key, required this.dokter});

  void _konfirmasiHapus(BuildContext context) {
    showDialog(
      context: context,
      builder: (dialogContext) => AlertDialog(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
        title: const Text("Konfirmasi Hapus"),
        content: Text("Yakin ingin menghapus data ${dokter.namaDokter}?"),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(dialogContext),
            child: const Text("Batal"),
          ),
          ElevatedButton(
            style: ElevatedButton.styleFrom(
              backgroundColor: Colors.red,
              foregroundColor: Colors.white,
            ),
            onPressed: () async {
              Navigator.pop(dialogContext);
              await DokterService().hapus(dokter);
              if (context.mounted) {
                Navigator.pop(context, 'deleted');
              }
            },
            child: const Text("Ya, Hapus"),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Detail Dokter"),
        backgroundColor: Colors.teal,
        foregroundColor: Colors.white,
      ),
      body: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          children: [
            Card(
              elevation: 3,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(16),
              ),
              child: Padding(
                padding: const EdgeInsets.all(20),
                child: Column(
                  children: [
                    CircleAvatar(
                      radius: 40,
                      backgroundColor: Colors.teal.shade50,
                      child: Icon(
                        Icons.person_rounded,
                        size: 48,
                        color: Colors.teal.shade700,
                      ),
                    ),
                    const SizedBox(height: 16),
                    Text(
                      dokter.namaDokter,
                      textAlign: TextAlign.center,
                      style: const TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: 6),
                    Chip(
                      label: Text(dokter.spesialis),
                      backgroundColor: Colors.teal.shade100,
                      labelStyle: TextStyle(
                        color: Colors.teal.shade900,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    const Divider(height: 30),
                    Row(
                      children: [
                        Icon(Icons.phone_android, color: Colors.teal.shade700),
                        const SizedBox(width: 12),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              "Nomor Telepon / HP",
                              style: TextStyle(
                                fontSize: 12,
                                color: Colors.grey.shade600,
                              ),
                            ),
                            Text(
                              dokter.noHp,
                              style: const TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
            const SizedBox(height: 24),
            Row(
              children: [
                Expanded(
                  child: ElevatedButton.icon(
                    onPressed: () async {
                      final result = await Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) =>
                              DokterUpdateForm(dokter: dokter),
                        ),
                      );
                      if (result != null &&
                          result is Dokter &&
                          context.mounted) {
                        Navigator.pop(context, result);
                      }
                    },
                    icon: const Icon(Icons.edit_rounded),
                    label: const Text("Ubah"),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.orange.shade700,
                      foregroundColor: Colors.white,
                      padding: const EdgeInsets.symmetric(vertical: 13),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                    ),
                  ),
                ),
                const SizedBox(width: 14),
                Expanded(
                  child: ElevatedButton.icon(
                    onPressed: () => _konfirmasiHapus(context),
                    icon: const Icon(Icons.delete_rounded),
                    label: const Text("Hapus"),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.red.shade600,
                      foregroundColor: Colors.white,
                      padding: const EdgeInsets.symmetric(vertical: 13),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
