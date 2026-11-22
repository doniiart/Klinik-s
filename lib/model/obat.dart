class Obat {
  String? id;
  String namaObat;
  String jenisObat;
  String stok;
  String harga;

  Obat({
    this.id,
    required this.namaObat,
    required this.jenisObat,
    required this.stok,
    required this.harga,
  });

  factory Obat.fromJson(Map<String, dynamic> json) => Obat(
        id: json["id"]?.toString(),
        namaObat: json["nama_obat"] ?? '',
        jenisObat: json["jenis_obat"] ?? '',
        stok: json["stok"]?.toString() ?? '0',
        harga: json["harga"]?.toString() ?? '0',
      );

  Map<String, dynamic> toJson() => {
        "nama_obat": namaObat,
        "jenis_obat": jenisObat,
        "stok": stok,
        "harga": harga,
      };
}
