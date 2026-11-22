import 'dart:convert';
import 'package:dio/dio.dart';
import '../helpers/api_client.dart';
import '../model/dokter.dart';

class DokterService {
  Future<List<Dokter>> listData() async {
    final Response response = await ApiClient().get('dokter');
    final List data = response.data is String
        ? jsonDecode(response.data)
        : response.data as List;
    List<Dokter> result = data.map((json) => Dokter.fromJson(json)).toList();
    return result;
  }

  Future<Dokter> simpan(Dokter dokter) async {
    var data = dokter.toJson();
    await ApiClient().post('dokter', data);
    dokter.id ??= DateTime.now().millisecondsSinceEpoch.toString();
    return dokter;
  }

  Future<Dokter> ubah(Dokter dokter, String id) async {
    var data = dokter.toJson();
    await ApiClient().put('dokter/$id', data);
    dokter.id = id;
    return dokter;
  }

  Future<bool> hapus(Dokter dokter) async {
    await ApiClient().delete('dokter/${dokter.id ?? "1"}');
    return true;
  }
}
