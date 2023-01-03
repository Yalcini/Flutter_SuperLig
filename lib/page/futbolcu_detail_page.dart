import 'package:flutter/material.dart';
import 'package:flutter_application_4/db/futbolcu_database.dart';
import 'package:flutter_application_4/model/futbolcu.dart';
import 'package:flutter_application_4/model/takim.dart';

class FutbolcuDetailPage extends StatefulWidget {
  final TakimModel takim;
  final Futbolcu futbolcu;
  const FutbolcuDetailPage({
    Key? key,
    required this.takim,
    required this.futbolcu,
  }) : super(key: key);

  @override
  State<FutbolcuDetailPage> createState() => _EditFutbolcuPageState();
}

class _EditFutbolcuPageState extends State<FutbolcuDetailPage> {
  late Futbolcu futbolcu;
  late String isim;
  late String pozisyon;
  late String uyruk;
  late int piyasa;
  late int maas;
  late int yas;
  final formKey = GlobalKey<FormState>();
  bool isEditable = true;

  @override
  initState() {
    super.initState();
    futbolcu = widget.futbolcu;

    isim = futbolcu.isim;
    pozisyon = futbolcu.pozisyon;
    uyruk = futbolcu.uyruk;
    piyasa = futbolcu.piyasa;
    maas = futbolcu.maas;
    yas = futbolcu.yas;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        actions: [
          _editButton(futbolcu),
          _deleteButton(futbolcu)
        ],
        title: Text(futbolcu.isim),
      ),
      body: Form(
        key: formKey,
        child: Center(
          child: Column(
            children: [
              Icon(
                Icons.person,
                size: 48,
              ),
              SizedBox(height: 15),
              TextFormField(
                initialValue: isim,
                readOnly: isEditable,
                onChanged: ((isim) => this.isim = isim),
                validator: (isim) =>
                    isim != null && isim.isEmpty ? "isim boş olamaz" : null,
                decoration:
                    InputDecoration(labelText: "Isim", hintText: "Isim"),
              ),
              TextFormField(
                initialValue: pozisyon,
                readOnly: isEditable,
                onChanged: ((pozisyon) => this.pozisyon = pozisyon),
                validator: (pozisyon) => pozisyon != null && pozisyon.isEmpty
                    ? "Pozisyon boş olamaz"
                    : null,
                decoration: InputDecoration(
                    labelText: "Pozisyon", hintText: "Pozisyon"),
              ),
              TextFormField(
                initialValue: uyruk,
                readOnly: isEditable,
                onChanged: ((uyruk) => this.uyruk = uyruk),
                validator: (uyruk) =>
                    uyruk != null && uyruk.isEmpty ? "uyruk boş olamaz" : null,
                decoration:
                    InputDecoration(labelText: "Uyruk", hintText: "Uyruk"),
              ),
              TextFormField(
                initialValue: yas.toString(),
                readOnly: isEditable,
                onChanged: ((yas) => this.yas = int.parse(yas)),
                decoration: InputDecoration(labelText: "Yas", hintText: "Yas"),
              ),
              TextFormField(
                initialValue: piyasa.toString(),
                readOnly: isEditable,
                onChanged: ((piyasa) => this.piyasa = int.parse(piyasa)),
                decoration:
                    InputDecoration(labelText: "Piyasa", hintText: "Piyasa"),
              ),
              TextFormField(
                initialValue: maas.toString(),
                readOnly: isEditable,
                onChanged: ((maas) => this.maas = int.parse(maas)),
                decoration:
                    InputDecoration(labelText: "Maas", hintText: "Maas"),
              ),
            ],
          ),
        ),
      ),
    );
  }

  IconButton _editButton(Futbolcu futbolcu) {
    return isEditable
        ? IconButton(
            onPressed: () {
              isEditable = false;
              setState(() {});
            },
            icon: Icon(Icons.edit))
        : IconButton(
            onPressed: () {
              final isValid = formKey.currentState!.validate();
              if (isValid) {
                isEditable = true;
                updateFutbolcu(futbolcu);
                setState(() {});
              }else {
                throw Exception("Girilen Değerler Hatalı");
              }
            },
            icon: Icon(Icons.check));
  }

  Future<void> updateFutbolcu(Futbolcu futbolcu) async {
    final editedFutbolcu = futbolcu.copy(
        isim: isim,
        maas: maas,
        pozisyon: pozisyon,
        uyruk: uyruk,
        piyasa: piyasa,
        yas: yas);
    await FutbolcuDataBase.instance.updateFutbolcu(editedFutbolcu);
  }

  _deleteButton(Futbolcu futbolcu) {
    return IconButton(onPressed: (() {
      FutbolcuDataBase.instance.deleteFutbolcu(futbolcu.id!);
      FutbolcuDataBase.instance.updateKadroDegeri(widget.takim);
      
      Navigator.of(context).pop();

    }),
   icon: Icon(Icons.delete));
  }
}
