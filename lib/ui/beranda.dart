import 'package:flutter/material.dart';
import '../service/dokter_service.dart';
import '../service/jadwal_service.dart';
import '../service/obat_service.dart';
import '../widget/sidebar.dart';
import 'dokter_page.dart';
import 'jadwal_page.dart';
import 'obat_page.dart';
import 'poli_page.dart';

class Beranda extends StatefulWidget {
  const Beranda({super.key});

  @override
  State<Beranda> createState() => _BerandaState();
}

class _BerandaState extends State<Beranda> {
  int _jumlahDokter = 0;
  int _jumlahObat = 0;
  int _jumlahJadwal = 0;
  bool _isLoading = true;

  @override
  void initState() {
    super.initState();
    _loadRingkasan();
  }

  Future<void> _loadRingkasan() async {
    setState(() => _isLoading = true);
    try {
      final results = await Future.wait([
        DokterService().listData(),
        ObatService().listData(),
        JadwalService().listData(),
      ]);
      if (!mounted) return;
      setState(() {
        _jumlahDokter = results[0].length;
        _jumlahObat = results[1].length;
        _jumlahJadwal = results[2].length;
        _isLoading = false;
      });
    } catch (_) {
      if (!mounted) return;
      setState(() => _isLoading = false);
    }
  }

  void _bukaHalaman(Widget halaman) {
    Navigator.pushReplacement(
      context,
      MaterialPageRoute(builder: (context) => halaman),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey.shade100,
      drawer: const Sidebar(),
      appBar: AppBar(
        title: const Text("Beranda Klinik"),
        backgroundColor: Colors.teal,
        foregroundColor: Colors.white,
        elevation: 0,
      ),
      body: RefreshIndicator(
        onRefresh: _loadRingkasan,
        color: Colors.teal,
        child: SingleChildScrollView(
          physics: const AlwaysScrollableScrollPhysics(),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Header Banner Gradient
              Container(
                width: double.infinity,
                padding: const EdgeInsets.fromLTRB(20, 12, 20, 28),
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    colors: [Colors.teal, Colors.teal.shade700],
                    begin: Alignment.topCenter,
                    end: Alignment.bottomCenter,
                  ),
                  borderRadius: const BorderRadius.only(
                    bottomLeft: Radius.circular(28),
                    bottomRight: Radius.circular(28),
                  ),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        Container(
                          padding: const EdgeInsets.all(12),
                          decoration: BoxDecoration(
                            color: Colors.white.withValues(alpha: 0.18),
                            borderRadius: BorderRadius.circular(16),
                          ),
                          child: const Icon(
                            Icons.local_hospital_rounded,
                            color: Colors.white,
                            size: 32,
                          ),
                        ),
                        const SizedBox(width: 14),
                        const Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                "Selamat Datang, Admin!",
                                style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 20,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              SizedBox(height: 4),
                              Text(
                                "Sistem Informasi Layanan Poli & Klinik",
                                style: TextStyle(
                                  color: Colors.white70,
                                  fontSize: 13,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 18),
                    Container(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 14,
                        vertical: 10,
                      ),
                      decoration: BoxDecoration(
                        color: Colors.white.withValues(alpha: 0.15),
                        borderRadius: BorderRadius.circular(12),
                      ),
                      child: const Row(
                        children: [
                          Icon(
                            Icons.verified_user_rounded,
                            color: Colors.white,
                            size: 18,
                          ),
                          SizedBox(width: 8),
                          Expanded(
                            child: Text(
                              "Layanan Klinik Aktif • Jam Operasional 08:00 - 20:00",
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: 12,
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),

              Padding(
                padding: const EdgeInsets.all(16),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text(
                      "Ringkasan Data Klinik",
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: 12),

                    // Grid 4 Kartu Statistik
                    GridView.count(
                      crossAxisCount: 2,
                      shrinkWrap: true,
                      physics: const NeverScrollableScrollPhysics(),
                      crossAxisSpacing: 12,
                      mainAxisSpacing: 12,
                      childAspectRatio: 1.45,
                      children: [
                        _buildStatCard(
                          title: "Layanan Poli",
                          count: "4",
                          icon: Icons.local_hospital_rounded,
                          color: Colors.teal,
                          onTap: () => _bukaHalaman(const PoliPage()),
                        ),
                        _buildStatCard(
                          title: "Data Dokter",
                          count: _isLoading ? "..." : "$_jumlahDokter",
                          icon: Icons.medical_services_rounded,
                          color: Colors.indigo,
                          onTap: () => _bukaHalaman(const DokterPage()),
                        ),
                        _buildStatCard(
                          title: "Data Obat",
                          count: _isLoading ? "..." : "$_jumlahObat",
                          icon: Icons.medication_rounded,
                          color: Colors.green.shade700,
                          onTap: () => _bukaHalaman(const ObatPage()),
                        ),
                        _buildStatCard(
                          title: "Jadwal Praktik",
                          count: _isLoading ? "..." : "$_jumlahJadwal",
                          icon: Icons.calendar_month_rounded,
                          color: Colors.blue.shade700,
                          onTap: () => _bukaHalaman(const JadwalPage()),
                        ),
                      ],
                    ),

                    const SizedBox(height: 22),
                    const Text(
                      "Akses Cepat Menu",
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: 10),

                    _buildMenuTile(
                      title: "Kelola Data Dokter",
                      subtitle: "Tambah, ubah, dan hapus data dokter spesialis",
                      icon: Icons.medical_services_rounded,
                      color: Colors.teal,
                      onTap: () => _bukaHalaman(const DokterPage()),
                    ),
                    _buildMenuTile(
                      title: "Daftar Stok & Harga Obat",
                      subtitle: "Cek ketersediaan obat dan informasi satuan",
                      icon: Icons.medication_rounded,
                      color: Colors.green.shade700,
                      onTap: () => _bukaHalaman(const ObatPage()),
                    ),
                    _buildMenuTile(
                      title: "Jadwal Praktik Dokter",
                      subtitle: "Lihat hari dan jam layanan tiap poli klinik",
                      icon: Icons.calendar_month_rounded,
                      color: Colors.blue.shade700,
                      onTap: () => _bukaHalaman(const JadwalPage()),
                    ),
                    _buildMenuTile(
                      title: "Informasi Layanan Poli",
                      subtitle: "Poli Anak, Kandungan, Gigi, dan THT",
                      icon: Icons.local_hospital_rounded,
                      color: Colors.orange.shade700,
                      onTap: () => _bukaHalaman(const PoliPage()),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildStatCard({
    required String title,
    required String count,
    required IconData icon,
    required Color color,
    required VoidCallback onTap,
  }) {
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(16),
      child: Container(
        padding: const EdgeInsets.all(14),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(16),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withValues(alpha: 0.04),
              blurRadius: 8,
              offset: const Offset(0, 3),
            ),
          ],
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Container(
                  padding: const EdgeInsets.all(8),
                  decoration: BoxDecoration(
                    color: color.withValues(alpha: 0.12),
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: Icon(icon, color: color, size: 22),
                ),
                Text(
                  count,
                  style: TextStyle(
                    fontSize: 22,
                    fontWeight: FontWeight.bold,
                    color: color,
                  ),
                ),
              ],
            ),
            Text(
              title,
              style: const TextStyle(
                fontSize: 13,
                fontWeight: FontWeight.w600,
                color: Colors.black87,
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildMenuTile({
    required String title,
    required String subtitle,
    required IconData icon,
    required Color color,
    required VoidCallback onTap,
  }) {
    return Card(
      elevation: 1.5,
      margin: const EdgeInsets.only(bottom: 10),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(14)),
      child: ListTile(
        contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 6),
        onTap: onTap,
        leading: CircleAvatar(
          backgroundColor: color.withValues(alpha: 0.12),
          child: Icon(icon, color: color),
        ),
        title: Text(
          title,
          style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 15),
        ),
        subtitle: Text(
          subtitle,
          style: TextStyle(fontSize: 12, color: Colors.grey.shade600),
        ),
        trailing: Icon(
          Icons.arrow_forward_ios_rounded,
          size: 16,
          color: Colors.grey.shade500,
        ),
      ),
    );
  }
}
