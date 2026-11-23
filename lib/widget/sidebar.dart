import 'package:material_ui/material_ui.dart';
import '../ui/beranda.dart';
import '../ui/dokter_page.dart';
import '../ui/jadwal_page.dart';
import '../ui/login.dart';
import '../ui/obat_page.dart';
import '../ui/poli_page.dart';

class Sidebar extends StatelessWidget {
  const Sidebar({super.key});

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: ListView(
        padding: EdgeInsets.zero,
        children: [
          UserAccountsDrawerHeader(
            decoration: BoxDecoration(
              gradient: LinearGradient(
                colors: [Colors.teal.shade700, Colors.teal.shade400],
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
              ),
            ),
            currentAccountPicture: const CircleAvatar(
              backgroundColor: Colors.white,
              child: Icon(
                Icons.local_hospital_rounded,
                size: 36,
                color: Colors.teal,
              ),
            ),
            accountName: const Text(
              "Admin Klinik",
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
            ),
            accountEmail: const Text("admin@admin.com"),
          ),
          ListTile(
            leading: const Icon(Icons.home_rounded, color: Colors.teal),
            title: const Text("Beranda"),
            onTap: () {
              Navigator.pushReplacement(
                context,
                MaterialPageRoute(builder: (context) => const Beranda()),
              );
            },
          ),
          ListTile(
            leading:
                const Icon(Icons.local_hospital_rounded, color: Colors.teal),
            title: const Text("Data Poli"),
            onTap: () {
              Navigator.pushReplacement(
                context,
                MaterialPageRoute(builder: (context) => const PoliPage()),
              );
            },
          ),
          const Divider(),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 6),
            child: Text(
              "LAYANAN & DATA KLINIK",
              style: TextStyle(
                fontSize: 11,
                fontWeight: FontWeight.bold,
                color: Colors.grey.shade600,
              ),
            ),
          ),
          ListTile(
            leading:
                const Icon(Icons.medical_services_rounded, color: Colors.teal),
            title: const Text("Data Dokter"),
            onTap: () {
              Navigator.pushReplacement(
                context,
                MaterialPageRoute(builder: (context) => const DokterPage()),
              );
            },
          ),
          ListTile(
            leading: const Icon(Icons.medication_rounded, color: Colors.teal),
            title: const Text("Data Obat"),
            onTap: () {
              Navigator.pushReplacement(
                context,
                MaterialPageRoute(builder: (context) => const ObatPage()),
              );
            },
          ),
          ListTile(
            leading:
                const Icon(Icons.calendar_month_rounded, color: Colors.teal),
            title: const Text("Jadwal Praktik"),
            onTap: () {
              Navigator.pushReplacement(
                context,
                MaterialPageRoute(builder: (context) => const JadwalPage()),
              );
            },
          ),
          const Divider(),
          ListTile(
            leading: const Icon(Icons.people_rounded, color: Colors.grey),
            title: const Text("Pegawai"),
            onTap: () {},
          ),
          ListTile(
            leading: const Icon(Icons.account_box_rounded, color: Colors.grey),
            title: const Text("Pasien"),
            onTap: () {},
          ),
          const Divider(),
          ListTile(
            leading: const Icon(Icons.logout_rounded, color: Colors.red),
            title: const Text("Keluar", style: TextStyle(color: Colors.red)),
            onTap: () {
              Navigator.pushAndRemoveUntil(
                context,
                MaterialPageRoute(builder: (context) => const Login()),
                (Route<dynamic> route) => false,
              );
            },
          ),
        ],
      ),
    );
  }
}
