import 'package:flutter/material.dart';
import '../model/jadwal.dart';

class JadwalDetail extends StatelessWidget {
  final Jadwal jadwal;

  const JadwalDetail({super.key, required this.jadwal});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Detail Jadwal Praktik"),
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
                  backgroundColor: Colors.blue.shade50,
                  child: Icon(
                    Icons.event_available_rounded,
                    size: 44,
                    color: Colors.blue.shade700,
                  ),
                ),
                const SizedBox(height: 16),
                Text(
                  jadwal.namaDokter,
                  textAlign: TextAlign.center,
                  style: const TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 6),
                Chip(
                  label: Text(jadwal.namaPoli),
                  backgroundColor: Colors.blue.shade100,
                  labelStyle: TextStyle(
                    color: Colors.blue.shade900,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                const Divider(height: 30),
                _buildInfoRow(
                    Icons.date_range_rounded, "Hari Praktik", jadwal.hari),
                const SizedBox(height: 14),
                _buildInfoRow(
                    Icons.schedule_rounded, "Jam Praktik", jadwal.jamPraktik),
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
