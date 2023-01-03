import 'package:flutter/material.dart';
import 'package:flutter_application_4/db/futbolcu_database.dart';
import 'package:flutter_application_4/methods/methods.dart';
import 'package:flutter_application_4/model/takim.dart';
import 'package:flutter_application_4/model/teknik.dart';

class AddTeknikEkip extends StatefulWidget {
  final TakimModel takim;
  const AddTeknikEkip({Key? key, required this.takim}) : super(key: key);

  @override
  State<AddTeknikEkip> createState() => _AddTeknikEkipState();
}

class _AddTeknikEkipState extends State<AddTeknikEkip> {
  final formKey = GlobalKey<FormState>();
  String? isim;
  String? gorev;
  int? yas;
  int? maas;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Form(
          key: formKey,
          child: Padding(
            padding: EdgeInsets.all(8),
            child: ListView(
              children: [
                TextFormField(
                  onChanged: (isim) => this.isim = isim,
                  validator: ((isim) => isim != null && isim.isEmpty
                      ? "İsim alanı boş olamaz"
                      : null),
                  decoration:
                      const InputDecoration(hintText: "İsim", labelText: "İsim"),
                ),
                TextFormField(
                  onChanged: (gorev) => this.gorev = gorev,
                  validator: ((gorev) => gorev != null && gorev.isEmpty
                      ? "Görev alanı boş olamaz"
                      : null),
                  decoration:
                      const InputDecoration(hintText: "Görev", labelText: "Görev"),
                ),
                TextFormField(
                  onChanged: ((value) => this.yas = int.parse(value)),
                  validator: ((yas) => yas != null && yas.isEmpty 
                     ? "Yas alanı boş olamaz"
                     : Methods.isNumeric(yas!) 
                     ? null
                     : "Geçerli bir sayı giriniz"),
                  decoration: InputDecoration(hintText: "Yaş", labelText: "Yaş"),
                ),
                TextFormField(
                  onChanged: ((value) => this.maas = int.parse(value)),
                  validator: ((maas) => maas != null && maas.isEmpty 
                     ? "Maas alanı boş olamaz"
                     : Methods.isNumeric(maas!) 
                     ? null
                     : "Geçerli bir sayı giriniz"),
                  decoration: InputDecoration(hintText: "Maas", labelText: "Maas"),
                ),
                Row(children: [
                  ElevatedButton(onPressed: (() async {
                    final isValid = formKey.currentState!.validate();
                    if(isValid) {
                      await addTeknikEkip();
                    }
                     Navigator.of(context).pop();
                  }), child: Text("Kaydet"))
                ],)
          
              ],
            ),
          )),
    );
  }

  Future addTeknikEkip() async{
    final teknikEkipUyesi = TeknikEkip(isim: isim!, 
    gorev: gorev!, 
    yas: yas!,
    maas: maas!, 
    takimId: widget.takim.id!);
    await FutbolcuDataBase.instance.createTeknikEkipUyesi(teknikEkipUyesi);
  }

  

  
}
