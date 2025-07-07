class Cabang {
  final String idcabang;
  final String namacabang;
  final String alamat;
  final String jambuka;
  final String jamtutup;
  final String gambar;
  final String tgldaftar;
  final String idperusahaan;
  final String zonawaktu;

  Cabang({
    required this.idcabang,
    required this.namacabang,
    required this.alamat,
    required this.jambuka,
    required this.jamtutup,
    required this.gambar,
    required this.tgldaftar,
    required this.idperusahaan,
    required this.zonawaktu,
  });

  factory Cabang.fromJson(Map<String, dynamic> json) {
    return Cabang(
      idcabang: json['idcabang'],
      namacabang: json['namacabang'],
      alamat: json['alamat'],
      jambuka: json['jambuka'],
      jamtutup: json['jamtutup'],
      gambar: json['gambar'],
      tgldaftar: json['tgldaftar'],
      idperusahaan: json['idperusahaan'],
      zonawaktu: json['zonawaktu'],
    );
  }
}
