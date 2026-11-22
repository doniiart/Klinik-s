import 'dart:convert';
import 'package:dio/dio.dart';
import '../helpers/api_client.dart';
import '../model/jadwal.dart';

class JadwalService {
  Future<List<Jadwal>> listData() async {
    final Response response = await ApiClient().get('jadwal');
    final List data = response.data is String
        ? jsonDecode(response.data)
        : response.data as List;
    List<Jadwal> result = data.map((json) => Jadwal.fromJson(json)).toList();
    return result;
  }
}
