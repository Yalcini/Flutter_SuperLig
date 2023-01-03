String tabloTeknikEkip = "TeknikEkip";
class TeknikEkipFields {
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

class TeknikEkip {
  int? id;
  String isim;
  int yas;
  String gorev;
  int maas;
  int takimId;

  TeknikEkip({
    this.id,
    required this.isim,
    required this.gorev,
    required this.yas,
    required this.maas,
    required this.takimId
    });

    static TeknikEkip fromJson(Map<String, Object?>json) =>
    TeknikEkip(
    id: json[TeknikEkipFields.id] as int?,
    isim: json[TeknikEkipFields.isim] as String, 
    gorev: json[TeknikEkipFields.gorev] as String, 
    yas: json[TeknikEkipFields.yas] as int, 
    maas: json[TeknikEkipFields.maas] as int, 
    takimId: json[TeknikEkipFields.takimId] as int
    );

    Map<String, Object?> toJson() => {
        TeknikEkipFields.id: id,
        TeknikEkipFields.isim: isim,
        TeknikEkipFields.maas: maas,
        TeknikEkipFields.yas: yas,
        TeknikEkipFields.takimId: takimId,
        TeknikEkipFields.gorev: gorev
      };

  copy({int? id, String? isim, String? gorev, int? yas, int? maas, int? takimId}) => 
  TeknikEkip(
  id: id ?? this.id,
  isim: isim ?? this.isim, 
  gorev: gorev ?? this.gorev, 
  yas: yas ?? this.yas, 
  maas: maas ?? this.maas, 
  takimId: takimId ?? this.takimId);

}