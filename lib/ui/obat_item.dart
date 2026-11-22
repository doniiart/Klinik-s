import 'package:flutter/material.dart';
import '../model/obat.dart';

class ObatItem extends StatelessWidget {
  final Obat obat;
  final VoidCallback onTap;

  const ObatItem({
    super.key,
    required this.obat,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 2,
      margin: const EdgeInsets.symmetric(horizontal: 14, vertical: 6),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(14)),
      child: ListTile(
        contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
        onTap: onTap,
        leading: CircleAvatar(
          radius: 25,
          backgroundColor: Colors.green.shade50,
          child: Icon(
            Icons.medication_rounded,
            color: Colors.green.shade700,
            size: 26,
          ),
        ),
        title: Text(
          obat.namaObat,
          style: const TextStyle(
            fontWeight: FontWeight.bold,
            fontSize: 16,
          ),
        ),
        subtitle: Padding(
          padding: const EdgeInsets.only(top: 6),
          child: Row(
            children: [
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 2),
                decoration: BoxDecoration(
                  color: Colors.green.shade100.withValues(alpha: 0.6),
                  borderRadius: BorderRadius.circular(6),
                ),
                child: Text(
                  obat.jenisObat,
                  style: TextStyle(
                    fontSize: 12,
                    fontWeight: FontWeight.w600,
                    color: Colors.green.shade900,
                  ),
                ),
              ),
              const SizedBox(width: 10),
              Text(
                "Stok: ${obat.stok}",
                style: TextStyle(fontSize: 13, color: Colors.grey.shade700),
              ),
            ],
          ),
        ),
        trailing: Text(
          "Rp ${obat.harga}",
          style: TextStyle(
            fontWeight: FontWeight.bold,
            fontSize: 14,
            color: Colors.teal.shade800,
          ),
        ),
      ),
    );
  }
}
