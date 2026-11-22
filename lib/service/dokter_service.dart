import 'dart:convert';
import 'package:dio/dio.dart';
import '../helpers/api_client.dart';
import '../model/dokter.dart';
import '../model/jadwal.dart';
import 'jadwal_service.dart';

class DokterService {
  static List<Dokter>? _cacheDokter;

  Future<List<Dokter>> listData() async {
    if (_cacheDokter != null) {
      return List<Dokter>.from(_cacheDokter!);
    }
    final Response response = await ApiClient().get('dokter');
    final List data = response.data is String
        ? jsonDecode(response.data)
        : response.data as List;
    _cacheDokter = data.map((json) => Dokter.fromJson(json)).toList();
    return List<Dokter>.from(_cacheDokter!);
  }

  Future<Dokter> simpan(Dokter dokter) async {
    var data = dokter.toJson();
    await ApiClient().post('dokter', data);
    dokter.id ??= DateTime.now().millisecondsSinceEpoch.toString();

    _cacheDokter?.add(dokter);
    JadwalService.tambahJadwalOtomatis(
      Jadwal(
        id: dokter.id,
        namaDokter: dokter.namaDokter,
        namaPoli: dokter.spesialis,
        hari: "Senin - Jumat",
        jamPraktik: "08:00 - 14:00",
      ),
    );
    return dokter;
  }

  Future<Dokter> ubah(Dokter dokter, String id) async {
    var data = dokter.toJson();
    await ApiClient().put('dokter/$id', data);
    dokter.id = id;

    if (_cacheDokter != null) {
      final index = _cacheDokter!.indexWhere((item) => item.id == id);
      if (index != -1) {
        _cacheDokter![index] = dokter;
      }
    }
    JadwalService.ubahJadwalOtomatis(dokter);
    return dokter;
  }

  Future<bool> hapus(Dokter dokter) async {
    await ApiClient().delete('dokter/${dokter.id ?? "1"}');
    _cacheDokter?.removeWhere((item) => item.id == dokter.id);
    if (dokter.id != null) {
      JadwalService.hapusJadwalOtomatis(dokter.id!);
    }
    return true;
  }
}
