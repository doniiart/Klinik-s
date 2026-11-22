import 'package:flutter/material.dart';
import '../model/dokter.dart';
import '../service/dokter_service.dart';
import '../widget/sidebar.dart';
import 'dokter_detail.dart';
import 'dokter_form.dart';
import 'dokter_item.dart';

class DokterPage extends StatefulWidget {
  const DokterPage({super.key});

  @override
  State<DokterPage> createState() => _DokterPageState();
}

class _DokterPageState extends State<DokterPage> {
  List<Dokter> _listDokter = [];
  bool _isLoading = true;

  @override
  void initState() {
    super.initState();
    _loadData();
  }

  Future<void> _loadData() async {
    setState(() => _isLoading = true);
    try {
      final data = await DokterService().listData();
      if (!mounted) return;
      setState(() {
        _listDokter = data;
        _isLoading = false;
      });
    } catch (e) {
      if (!mounted) return;
      setState(() => _isLoading = false);
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text("Gagal memuat data dokter: $e")),
      );
    }
  }

  void _showMessage(String pesan) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(pesan),
        backgroundColor: Colors.teal.shade700,
        behavior: SnackBarBehavior.floating,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: const Sidebar(),
      appBar: AppBar(
        title: const Text("Data Dokter"),
        backgroundColor: Colors.teal,
        foregroundColor: Colors.white,
        actions: [
          IconButton(
            icon: const Icon(Icons.add_circle_outline, size: 28),
            tooltip: "Tambah Dokter",
            onPressed: () async {
              final result = await Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => const DokterForm()),
              );
              if (result != null && result is Dokter) {
                setState(() {
                  _listDokter.add(result);
                });
                _showMessage("Data dokter berhasil ditambahkan");
              }
            },
          ),
        ],
      ),
      body: _isLoading
          ? const Center(child: CircularProgressIndicator(color: Colors.teal))
          : RefreshIndicator(
              onRefresh: _loadData,
              child: _listDokter.isEmpty
                  ? const Center(child: Text("Belum ada data dokter"))
                  : ListView.builder(
                      padding: const EdgeInsets.symmetric(vertical: 10),
                      itemCount: _listDokter.length,
                      itemBuilder: (context, index) {
                        final dokter = _listDokter[index];
                        return DokterItem(
                          dokter: dokter,
                          onTap: () async {
                            final result = await Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) =>
                                    DokterDetail(dokter: dokter),
                              ),
                            );
                            if (result == 'deleted') {
                              setState(() {
                                _listDokter.removeWhere(
                                    (item) => item.id == dokter.id);
                              });
                              _showMessage("Data dokter berhasil dihapus");
                            } else if (result is Dokter) {
                              setState(() {
                                final idx = _listDokter
                                    .indexWhere((item) => item.id == dokter.id);
                                if (idx != -1) _listDokter[idx] = result;
                              });
                              _showMessage("Data dokter berhasil diperbarui");
                            }
                          },
                        );
                      },
                    ),
            ),
    );
  }
}
