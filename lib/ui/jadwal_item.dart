import 'package:material_ui/material_ui.dart';
import '../model/jadwal.dart';

class JadwalItem extends StatelessWidget {
  final Jadwal jadwal;
  final VoidCallback onTap;

  const JadwalItem({
    super.key,
    required this.jadwal,
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
          backgroundColor: Colors.blue.shade50,
          child: Icon(
            Icons.calendar_month_rounded,
            color: Colors.blue.shade700,
            size: 26,
          ),
        ),
        title: Text(
          jadwal.namaDokter,
          style: const TextStyle(
            fontWeight: FontWeight.bold,
            fontSize: 16,
          ),
        ),
        subtitle: Padding(
          padding: const EdgeInsets.only(top: 6),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 2),
                decoration: BoxDecoration(
                  color: Colors.blue.shade100.withValues(alpha: 0.6),
                  borderRadius: BorderRadius.circular(6),
                ),
                child: Text(
                  jadwal.namaPoli,
                  style: TextStyle(
                    fontSize: 12,
                    fontWeight: FontWeight.w600,
                    color: Colors.blue.shade900,
                  ),
                ),
              ),
              const SizedBox(height: 6),
              Row(
                children: [
                  Icon(Icons.access_time_rounded,
                      size: 14, color: Colors.grey.shade600),
                  const SizedBox(width: 4),
                  Expanded(
                    child: Text(
                      "${jadwal.hari} • ${jadwal.jamPraktik}",
                      style:
                          TextStyle(fontSize: 13, color: Colors.grey.shade700),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
        trailing: Icon(
          Icons.arrow_forward_ios_rounded,
          size: 16,
          color: Colors.teal.shade600,
        ),
      ),
    );
  }
}
