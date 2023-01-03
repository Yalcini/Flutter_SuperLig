import 'package:flutter/material.dart';
import 'package:flutter_application_4/db/futbolcu_database.dart';
import 'package:flutter_application_4/methods/methods.dart';
import 'package:flutter_application_4/model/yonetim.dart';

class AddYonetimPage extends StatefulWidget {
  final takim;
  const AddYonetimPage({Key? key, required this.takim}) : super(key: key);

  @override
  State<AddYonetimPage> createState() => _AddYonetimPageState();
}

class _AddYonetimPageState extends State<AddYonetimPage> {
  final formKey = GlobalKey<FormState>();
  String? isim;
  String? gorev;
  int? yas;
  int? maas;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        actions: [
          ElevatedButton(
              onPressed: (() async {
                final isValid = formKey.currentState!.validate();
                if (isValid) {
                  await addYonetim();
                }
                Navigator.of(context).pop();
              }),
              child: Text("Kaydet"))
        ],
      ),
      body: Form(
          key: formKey,
          child: Padding(
            padding: EdgeInsets.all(8),
            child: ListView(
              children: [
                TextFormField(
                  validator: (value) => value != null && value.isEmpty
                      ? "İsim alanı boş olamaz"
                      : null,
                  onChanged: (value) => this.isim = value,
                  decoration:
                      InputDecoration(hintText: "İsim", labelText: "İsim"),
                ),
                TextFormField(
                  validator: (value) => value != null && value.isEmpty
                      ? "Görev alanı boş olamaz"
                      : null,
                  onChanged: (value) => this.gorev = value,
                  decoration:
                      InputDecoration(hintText: "Görev", labelText: "Görev"),
                ),
                TextFormField(
                  validator: (value) => value != null && value.isEmpty
                      ? "Yaş alanı boş olamaz"
                      : Methods.isNumeric(value!)
                          ? null
                          : "Geçerli bir yaş giriniz",
                  onChanged: (value) => this.yas = int.parse(value),
                  decoration:
                      InputDecoration(hintText: "Yaş", labelText: "Yaş"),
                ),
                TextFormField(
                  validator: (value) => value != null && value.isEmpty
                      ? "Maaş alanı boş olamaz"
                      : Methods.isNumeric(value!)
                          ? null
                          : "Geçerli bir maaş giriniz",
                  onChanged: (value) => this.maas = int.parse(value),
                  decoration:
                      InputDecoration(hintText: "Maaş", labelText: "Maaş"),
                ),
              ],
            ),
          )),
    );
  }

  Future addYonetim() async {
    final yonetimUyesi = Yonetim(
        isim: isim!,
        gorev: gorev!,
        yas: yas!,
        maas: maas!,
        takimId: widget.takim.id);
    await FutbolcuDataBase.instance.createYonetimUyesi(yonetimUyesi);
  }
}
