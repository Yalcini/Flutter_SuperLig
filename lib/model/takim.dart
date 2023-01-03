String tabloTakim = "Takimlar";

class TakimFields {
  List<String> values = [
    id, isim, kurulus, kadroDegeri, resim
  ];
  static final id = "_id";
  static final isim = "isim";
  static final kurulus = "kurulus";
  static final kadroDegeri = "kadroDegeri";
  static final resim = "resim";
  
}

class TakimModel{

  int? id;
  String isim;
  int kurulus;
  int kadroDegeri;
  String resim;
  
   TakimModel({
    this.id,
    required this.isim,
    required this.kurulus,
    required this.kadroDegeri,
    required this.resim

    
   });

   

   static TakimModel fromJson(Map<String, Object?> json) => 
   TakimModel(
    id: json[TakimFields.id] as int?,
    isim: json[TakimFields.isim] as String,
    kurulus: json[TakimFields.kurulus] as int, 
    kadroDegeri: json[TakimFields.kadroDegeri] as int, 
    resim: json[TakimFields.resim] as String);

    Map<String, Object?> toJson() =>
    {
      TakimFields.id: id,
      TakimFields.isim: isim,
      TakimFields.kadroDegeri: kadroDegeri,
      TakimFields.kurulus: kurulus,
      TakimFields.resim: resim
    }; 

    TakimModel copy({
      int? id,
      int? kadroDegeri,
      String? resim,
      String? isim,
      int? kurulus
    }) => 
    TakimModel(
    id: id ?? this.id,
    isim: isim ?? this.isim, 
    kurulus: kurulus ?? this.kurulus, 
    kadroDegeri: kadroDegeri ?? this.kadroDegeri, 
    resim: resim ?? this.resim,
    );

   


}