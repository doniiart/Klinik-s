class Dokter {
  String? id;
  String namaDokter;
  String spesialis;
  String noHp;

  Dokter({
    this.id,
    required this.namaDokter,
    required this.spesialis,
    required this.noHp,
  });

  factory Dokter.fromJson(Map<String, dynamic> json) => Dokter(
        id: json["id"]?.toString(),
        namaDokter: json["nama_dokter"] ?? '',
        spesialis: json["spesialis"] ?? '',
        noHp: json["no_hp"] ?? '',
      );

  Map<String, dynamic> toJson() => {
        "nama_dokter": namaDokter,
        "spesialis": spesialis,
        "no_hp": noHp,
      };
}
