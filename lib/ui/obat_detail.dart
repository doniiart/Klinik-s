import 'package:flutter/material.dart';
import '../model/obat.dart';

class ObatDetail extends StatelessWidget {
  final Obat obat;

  const ObatDetail({super.key, required this.obat});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Detail Obat"),
        backgroundColor: Colors.teal,
        foregroundColor: Colors.white,
      ),
      body: Padding(
        padding: const EdgeInsets.all(20),
        child: Card(
          elevation: 3,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(16),
          ),
          child: Padding(
            padding: const EdgeInsets.all(20),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                CircleAvatar(
                  radius: 38,
                  backgroundColor: Colors.green.shade50,
                  child: Icon(
                    Icons.medication_rounded,
                    size: 44,
                    color: Colors.green.shade700,
                  ),
                ),
                const SizedBox(height: 16),
                Text(
                  obat.namaObat,
                  textAlign: TextAlign.center,
                  style: const TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 6),
                Chip(
                  label: Text(obat.jenisObat),
                  backgroundColor: Colors.green.shade100,
                  labelStyle: TextStyle(
                    color: Colors.green.shade900,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                const Divider(height: 30),
                _buildInfoRow(Icons.inventory_2_outlined, "Sisa Stok",
                    "${obat.stok} unit"),
                const SizedBox(height: 14),
                _buildInfoRow(Icons.payments_outlined, "Harga Satuan",
                    "Rp ${obat.harga}"),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildInfoRow(IconData icon, String label, String value) {
    return Row(
      children: [
        Icon(icon, color: Colors.teal.shade700),
        const SizedBox(width: 12),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              label,
              style: TextStyle(fontSize: 12, color: Colors.grey.shade600),
            ),
            Text(
              value,
              style: const TextStyle(fontSize: 16, fontWeight: FontWeight.w600),
            ),
          ],
        ),
      ],
    );
  }
}
