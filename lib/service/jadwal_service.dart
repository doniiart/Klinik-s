import 'dart:convert';
import 'package:dio/dio.dart';
import '../helpers/api_client.dart';
import '../model/dokter.dart';
import '../model/jadwal.dart';

class JadwalService {
  static List<Jadwal>? _cacheJadwal;
  static final List<Jadwal> _jadwalTambahan = [];

  Future<List<Jadwal>> listData() async {
    if (_cacheJadwal == null) {
      final Response response = await ApiClient().get('jadwal');
      final List data = response.data is String
          ? jsonDecode(response.data)
          : response.data as List;
      _cacheJadwal = data.map((json) => Jadwal.fromJson(json)).toList();
    }
    return [..._cacheJadwal!, ..._jadwalTambahan];
  }

  static void tambahJadwalOtomatis(Jadwal jadwal) {
    _jadwalTambahan.add(jadwal);
  }

  static void ubahJadwalOtomatis(Dokter dokter) {
    final index = _jadwalTambahan.indexWhere((item) => item.id == dokter.id);
    if (index != -1) {
      _jadwalTambahan[index] = Jadwal(
        id: dokter.id,
        namaDokter: dokter.namaDokter,
        namaPoli: dokter.spesialis,
        hari: _jadwalTambahan[index].hari,
        jamPraktik: _jadwalTambahan[index].jamPraktik,
      );
    }
  }

  static void hapusJadwalOtomatis(String id) {
    _jadwalTambahan.removeWhere((item) => item.id == id);
  }
}
