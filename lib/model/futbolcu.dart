final String tabloFutbolcular = "Futbolcular";

class FutbolcuFields {
  static final List<String> values = [
    id,
    isim,
    uyruk,
    pozisyon,
    piyasa,
    maas,
    yas,
    takimId
  ];
  static final String id = "_id";
  static final String isim = "isim";
  static final String uyruk = "uyruk";
  static final String pozisyon = "pozisyon";
  static final String piyasa = "piyasa";
  static final String maas = "maas";
  static final String yas = "yas";
  static final String takimId = "takimId";
}

class Futbolcu {
  final int? id;
  final String isim;
  final String uyruk;
  final String pozisyon;
  final int piyasa;
  final int maas;
  final int yas;
  final int takimId;

  Futbolcu(
      {this.id,
      required this.isim,
      required this.uyruk,
      required this.pozisyon,
      required this.piyasa,
      required this.maas,
      required this.yas,
      required this.takimId});

  static Futbolcu fromJson(Map<String, Object?> json) => Futbolcu(
      id: json[FutbolcuFields.id] as int?,
      isim: json[FutbolcuFields.isim] as String,
      uyruk: json[FutbolcuFields.uyruk] as String,
      pozisyon: json[FutbolcuFields.pozisyon] as String,
      piyasa: json[FutbolcuFields.piyasa] as int,
      maas: json[FutbolcuFields.maas] as int,
      yas: json[FutbolcuFields.yas] as int,
      takimId: json[FutbolcuFields.takimId] as int);

  Map<String, Object?> toJson() => {
        FutbolcuFields.id: id,
        FutbolcuFields.isim: isim,
        FutbolcuFields.uyruk: uyruk,
        FutbolcuFields.pozisyon: pozisyon,
        FutbolcuFields.piyasa: piyasa,
        FutbolcuFields.maas: maas,
        FutbolcuFields.yas: yas,
        FutbolcuFields.takimId: takimId
      };

  Futbolcu copy(
          {int? id,
          String? isim,
          String? uyruk,
          String? pozisyon,
          int? piyasa,
          int? maas,
          int? yas,
          int? takimId}) =>
      Futbolcu(
          id: id ?? this.id,
          isim: isim ?? this.isim,
          uyruk: uyruk ?? this.uyruk,
          pozisyon: pozisyon ?? this.pozisyon,
          piyasa: piyasa ?? this.piyasa,
          maas: maas ?? this.maas,
          yas: yas ?? this.yas,
          takimId: takimId ?? this.takimId);
}
