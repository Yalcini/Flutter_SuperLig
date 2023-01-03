String tabloYonetim = "Yonetim";
class YonetimFields {
  static final List<String> values = [
    id, isim, gorev, maas, yas
  ];
  static final id = "_id";
  static final isim = "isim";
  static final gorev = "gorev";
  static final maas = "maas";
  static final yas = "yas";
  static final takimId = "takim";
}
class Yonetim {
  int? id;
  String isim;
  String gorev;
  int yas;
  int maas;
  int takimId;

  Yonetim(
      {this.id,
      required this.isim,
      required this.gorev,
      required this.yas,
      required this.maas,
      required this.takimId});

  static Yonetim fromJson(Map<String, Object?> json) {
    return Yonetim(
    id: json[YonetimFields.id] as int?,
    isim: json[YonetimFields.isim] as String, 
    gorev: json[YonetimFields.gorev] as String, 
    yas: json[YonetimFields.yas] as int, 
    maas: json[YonetimFields.maas] as int, 
    takimId: json[YonetimFields.takimId] as int
    );
  }

  Map<String, Object?> toJson() =>
  {
    YonetimFields.id : id,
    YonetimFields.isim : isim,
    YonetimFields.gorev : gorev,
    YonetimFields.maas : maas,
    YonetimFields.yas : yas,
    YonetimFields.takimId : takimId

  };

  copy({
    int? id,
    String? isim,
    String? gorev,
    int? yas,
    int? maas,
    int? takimId,

}) =>
     Yonetim(
     id: id ?? this.id,
     isim: isim ?? this.isim, 
     gorev: gorev ?? this.gorev, 
     yas: yas ?? this.yas, 
     maas: maas ?? this.maas, 
     takimId: takimId ?? this.takimId);

}
