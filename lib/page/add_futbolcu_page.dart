// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:flutter_application_4/db/futbolcu_database.dart';
import 'package:flutter_application_4/model/futbolcu.dart';
import 'package:flutter_application_4/model/takim.dart';

class AddFutbolcuPage extends StatefulWidget {
  final TakimModel takim;
  const AddFutbolcuPage({Key? key, required this.takim}) : super(key: key);

  @override
  State<AddFutbolcuPage> createState() => _AddFutbolcuPageState();
}

class _AddFutbolcuPageState extends State<AddFutbolcuPage> {
  final formKey = GlobalKey<FormState>();
  String? isim;
  String? pozisyon;
  String? uyruk;
  int? piyasa;
  int? maas;
  int? yas;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        actions: [
          ElevatedButton(
              onPressed: () async {
                final isValid = formKey.currentState!.validate();
                if (isValid) {
                  await addFutbolcu();
                }

                Navigator.of(context).pop();
              },
              child: Text("Kaydet")),
        ],
        title: Text("Futbolcu Ekle"),
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
                  onChanged: ((pozisyon) => this.pozisyon = pozisyon),
                  decoration: InputDecoration(
                    labelText: "Pozisyon",
                    hintText: "Pozisyon",
                  ),
                ),
                TextFormField(
                  onChanged: ((uyruk) => this.uyruk = uyruk),
                  decoration: InputDecoration(
                    labelText: "Uyruk",
                    hintText: "Uyruk",
                  ),
                ),
                TextFormField(
                  keyboardType: TextInputType.number,
                  onChanged: ((yas) => this.yas = int.parse(yas)),
                  decoration: InputDecoration(
                    labelText: "Yas",
                    hintText: "Yas",
                  ),
                ),
                TextFormField(
                  onChanged: ((piyasa) => this.piyasa = int.parse(piyasa)),
                  decoration: InputDecoration(
                    labelText: "Piyasa Degeri",
                    hintText: "Piyasa Degeri",
                  ),
                ),
                TextFormField(
                  keyboardType: TextInputType.number,
                  onChanged: ((maas) => this.maas = int.parse(maas)),
                  decoration: InputDecoration(
                    labelText: "Maas",
                    hintText: "Maas",
                  ),
                ),
              ],
            ),
          )),
    );
  }

  Future addFutbolcu() async {
    final futbolcu = Futbolcu(
        isim: isim!,
        uyruk: uyruk!,
        pozisyon: pozisyon!,
        piyasa: piyasa!,
        maas: maas!,
        yas: yas!,
        takimId: widget.takim.id!);

    await FutbolcuDataBase.instance.createFutbolcu(futbolcu);
    await FutbolcuDataBase.instance.updateKadroDegeri(widget.takim);
  }
}
