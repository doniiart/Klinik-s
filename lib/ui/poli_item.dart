import 'package:material_ui/material_ui.dart';
import '../model/poli.dart';
import 'poli_detail.dart';

class PoliItem extends StatelessWidget {
  final Poli poli;

  const PoliItem({super.key, required this.poli});

  IconData _getPoliIcon(String namaPoli) {
    final nama = namaPoli.toLowerCase();
    if (nama.contains('anak')) return Icons.child_care_rounded;
    if (nama.contains('kandungan')) return Icons.favorite_rounded;
    if (nama.contains('gigi')) return Icons.medical_information_rounded;
    if (nama.contains('tht')) return Icons.hearing_rounded;
    return Icons.local_hospital_rounded;
  }

  Color _getPoliColor(String namaPoli) {
    final nama = namaPoli.toLowerCase();
    if (nama.contains('anak')) return Colors.orange.shade700;
    if (nama.contains('kandungan')) return Colors.pink.shade600;
    if (nama.contains('gigi')) return Colors.blue.shade700;
    if (nama.contains('tht')) return Colors.purple.shade600;
    return Colors.teal.shade700;
  }

  @override
  Widget build(BuildContext context) {
    final accentColor = _getPoliColor(poli.namaPoli);

    return Card(
      elevation: 2,
      margin: const EdgeInsets.only(bottom: 12),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(14)),
      child: ListTile(
        contentPadding:
            const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
        onTap: () {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => PoliDetail(poli: poli)),
          );
        },
        leading: CircleAvatar(
          radius: 25,
          backgroundColor: accentColor.withValues(alpha: 0.12),
          child: Icon(
            _getPoliIcon(poli.namaPoli),
            color: accentColor,
            size: 26,
          ),
        ),
        title: Text(
          poli.namaPoli,
          style: const TextStyle(
            fontWeight: FontWeight.bold,
            fontSize: 16,
          ),
        ),
        subtitle: Padding(
          padding: const EdgeInsets.only(top: 4),
          child: Text(
            "Layanan Pemeriksaan & Konsultasi Spesialis",
            style: TextStyle(
              fontSize: 12,
              color: Colors.grey.shade600,
            ),
          ),
        ),
        trailing: Container(
          padding: const EdgeInsets.all(6),
          decoration: BoxDecoration(
            color: Colors.teal.shade50,
            borderRadius: BorderRadius.circular(8),
          ),
          child: Icon(
            Icons.arrow_forward_ios_rounded,
            size: 14,
            color: Colors.teal.shade700,
          ),
        ),
      ),
    );
  }
}
