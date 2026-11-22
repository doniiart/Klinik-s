import 'package:flutter/material.dart';
import '../model/obat.dart';
import '../service/obat_service.dart';
import '../widget/sidebar.dart';
import 'obat_detail.dart';
import 'obat_item.dart';

class ObatPage extends StatefulWidget {
  const ObatPage({super.key});

  @override
  State<ObatPage> createState() => _ObatPageState();
}

class _ObatPageState extends State<ObatPage> {
  List<Obat> _listObat = [];
  bool _isLoading = true;

  @override
  void initState() {
    super.initState();
    _loadData();
  }

  Future<void> _loadData() async {
    setState(() => _isLoading = true);
    try {
      final data = await ObatService().listData();
      if (!mounted) return;
      setState(() {
        _listObat = data;
        _isLoading = false;
      });
    } catch (e) {
      if (!mounted) return;
      setState(() => _isLoading = false);
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text("Gagal memuat data obat: $e")),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: const Sidebar(),
      appBar: AppBar(
        title: const Text("Data Obat"),
        backgroundColor: Colors.teal,
        foregroundColor: Colors.white,
      ),
      body: _isLoading
          ? const Center(child: CircularProgressIndicator(color: Colors.teal))
          : RefreshIndicator(
              onRefresh: _loadData,
              child: _listObat.isEmpty
                  ? const Center(child: Text("Belum ada data obat"))
                  : ListView.builder(
                      padding: const EdgeInsets.symmetric(vertical: 10),
                      itemCount: _listObat.length,
                      itemBuilder: (context, index) {
                        final obat = _listObat[index];
                        return ObatItem(
                          obat: obat,
                          onTap: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => ObatDetail(obat: obat),
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
