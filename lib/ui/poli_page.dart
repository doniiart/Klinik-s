import 'package:material_ui/material_ui.dart';
import '../model/poli.dart';
import '../widget/sidebar.dart';
import 'poli_form.dart';
import 'poli_item.dart';

class PoliPage extends StatefulWidget {
  const PoliPage({super.key});

  @override
  State<PoliPage> createState() => _PoliPageState();
}

class _PoliPageState extends State<PoliPage> {
  final List<Poli> _daftarPoli = [
    Poli(namaPoli: "Poli Anak"),
    Poli(namaPoli: "Poli Kandungan"),
    Poli(namaPoli: "Poli Gigi"),
    Poli(namaPoli: "Poli THT"),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey.shade100,
      drawer: const Sidebar(),
      appBar: AppBar(
        title: const Text("Data Poli"),
        backgroundColor: Colors.teal,
        foregroundColor: Colors.white,
        elevation: 0,
        actions: [
          IconButton(
            icon: const Icon(Icons.add_circle_outline, size: 28),
            tooltip: "Tambah Poli",
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => const PoliForm()),
              );
            },
          ),
        ],
      ),
      body: ListView(
        padding: const EdgeInsets.all(16),
        children: [
          Container(
            padding: const EdgeInsets.all(16),
            margin: const EdgeInsets.only(bottom: 16),
            decoration: BoxDecoration(
              gradient: LinearGradient(
                colors: [Colors.teal.shade600, Colors.teal.shade400],
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
              ),
              borderRadius: BorderRadius.circular(16),
              boxShadow: [
                BoxShadow(
                  color: Colors.teal.withValues(alpha: 0.25),
                  blurRadius: 8,
                  offset: const Offset(0, 4),
                ),
              ],
            ),
            child: Row(
              children: [
                Container(
                  padding: const EdgeInsets.all(10),
                  decoration: BoxDecoration(
                    color: Colors.white.withValues(alpha: 0.2),
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: const Icon(
                    Icons.local_hospital_rounded,
                    color: Colors.white,
                    size: 28,
                  ),
                ),
                const SizedBox(width: 14),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text(
                        "Unit Poliklinik Aktif",
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const SizedBox(height: 4),
                      Text(
                        "${_daftarPoli.length} Layanan Poli tersedia untuk pasien",
                        style: const TextStyle(
                          color: Colors.white70,
                          fontSize: 12,
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
          ..._daftarPoli.map((poli) => PoliItem(poli: poli)),
        ],
      ),
    );
  }
}
