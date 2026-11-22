class Jadwal {
  String? id;
  String namaDokter;
  String namaPoli;
  String hari;
  String jamPraktik;

  Jadwal({
    this.id,
    required this.namaDokter,
    required this.namaPoli,
    required this.hari,
    required this.jamPraktik,
  });

  factory Jadwal.fromJson(Map<String, dynamic> json) => Jadwal(
        id: json["id"]?.toString(),
        namaDokter: json["nama_dokter"] ?? '',
        namaPoli: json["nama_poli"] ?? '',
        hari: json["hari"] ?? '',
        jamPraktik: json["jam_praktik"] ?? '',
      );

  Map<String, dynamic> toJson() => {
        "nama_dokter": namaDokter,
        "nama_poli": namaPoli,
        "hari": hari,
        "jam_praktik": jamPraktik,
      };
}
