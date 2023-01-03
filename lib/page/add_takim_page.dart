import 'package:flutter/material.dart';
import 'package:flutter_application_4/db/futbolcu_database.dart';
import 'package:flutter_application_4/model/takim.dart';

class AddTakimPage extends StatefulWidget {
  const AddTakimPage({ Key? key }) : super(key: key);

  @override
  State<AddTakimPage> createState() => _AddTakimPageState();
}

class _AddTakimPageState extends State<AddTakimPage> {
  final formKey = GlobalKey<FormState>();
  String? isim;
  int? kurulus;
  int? kadroDegeri;
  String? resim;
  
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        actions: [ElevatedButton(
          onPressed: () async {
                final isValid = formKey.currentState!.validate();
                if (isValid) {
                  await addTakim();
                  
                }
                Navigator.of(context).pop();
              },
          child: Text("Ekle"))],
        title: Text("Takım Ekleme Sayfası"),
      ),
      body: Form(
        key: formKey,
        child: Padding(
          padding: EdgeInsets.all(8),
          child: ListView(
            children: [
              TextFormField(
                onChanged: ((isim) => this.isim = isim),
                  validator: (isim) =>
                      isim != null && isim.isEmpty ? "isim boş olamaz" : null,
                  decoration:
                      InputDecoration(labelText: "Isim", hintText: "Isim"),
              ),
              TextFormField(
                onChanged: ((kurulus) => this.kurulus = int.parse(kurulus)),
                  validator: (kurulus) =>
                      kurulus != null && kurulus.isEmpty ? "kurulus yılı boş olamaz" : null,
                  decoration:
                      InputDecoration(labelText: "Kurulus Yılı", hintText: "Kurulus Yılı"),
              ),
              TextFormField(
                validator: (resim) =>
                    resim != null && resim.isEmpty ? "resim alanı boş olamaz" : null ,
                onChanged: ((resim) => this.resim = resim),
                decoration:
                      InputDecoration(labelText: "Resim", hintText: "Resim"),
                
                
              )
            ],
          ),
        )
        ),
    );
  }

  Future addTakim() async {
    final takim = TakimModel(
      isim: isim!, 
      kurulus: kurulus!, 
      resim: resim!,
      kadroDegeri: await kadroDegeriHesapla());

      await FutbolcuDataBase.instance.createTakim(takim);
  }

  static Future<int> kadroDegeriHesapla() async {
    int toplamKadroDegeri = 0;
    final futbolcular = await FutbolcuDataBase.instance.readAllFutbolcu();
    if(futbolcular.isNotEmpty){
    futbolcular.forEach((futbolcu) { 
       toplamKadroDegeri += futbolcu.piyasa;
    }); }
    return toplamKadroDegeri;
  }
}