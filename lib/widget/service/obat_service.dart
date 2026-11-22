import 'dart:convert';
import 'package:dio/dio.dart';
import '../helpers/api_client.dart';
import '../model/obat.dart';

class ObatService {
  Future<List<Obat>> listData() async {
    final Response response = await ApiClient().get('obat');
    final List data = response.data is String
        ? jsonDecode(response.data)
        : response.data as List;
    List<Obat> result = data.map((json) => Obat.fromJson(json)).toList();
    return result;
  }
}
