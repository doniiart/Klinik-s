import 'package:material_ui/material_ui.dart';
import '../model/jadwal.dart';
import '../service/jadwal_service.dart';
import '../widget/sidebar.dart';
import 'jadwal_detail.dart';
import 'jadwal_item.dart';

class JadwalPage extends StatefulWidget {
  const JadwalPage({super.key});

  @override
  State<JadwalPage> createState() => _JadwalPageState();
}

class _JadwalPageState extends State<JadwalPage> {
  List<Jadwal> _listJadwal = [];
  bool _isLoading = true;

  @override
  void initState() {
    super.initState();
    _loadData();
  }

  Future<void> _loadData() async {
    setState(() => _isLoading = true);
    try {
      final data = await JadwalService().listData();
      if (!mounted) return;
      setState(() {
        _listJadwal = data;
        _isLoading = false;
      });
    } catch (e) {
      if (!mounted) return;
      setState(() => _isLoading = false);
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text("Gagal memuat jadwal praktik: $e")),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: const Sidebar(),
      appBar: AppBar(
        title: const Text("Jadwal Praktik"),
        backgroundColor: Colors.teal,
        foregroundColor: Colors.white,
      ),
      body: _isLoading
          ? const Center(child: CircularProgressIndicator(color: Colors.teal))
          : RefreshIndicator(
              onRefresh: _loadData,
              child: _listJadwal.isEmpty
                  ? const Center(child: Text("Belum ada jadwal praktik"))
                  : ListView.builder(
                      padding: const EdgeInsets.symmetric(vertical: 10),
                      itemCount: _listJadwal.length,
                      itemBuilder: (context, index) {
                        final jadwal = _listJadwal[index];
                        return JadwalItem(
                          jadwal: jadwal,
                          onTap: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) =>
                                    JadwalDetail(jadwal: jadwal),
                              ),
                            );
                          },
                        );
                      },
                    ),
            ),
    );
  }
}
