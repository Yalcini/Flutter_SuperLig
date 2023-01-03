import 'package:flutter/material.dart';
import 'package:flutter_application_4/db/futbolcu_database.dart';
import 'package:flutter_application_4/model/futbolcu.dart';
import 'package:flutter_application_4/page/add_takim_page.dart';
import 'package:flutter_application_4/page/bilgiler.dart';
import 'package:flutter_application_4/page/futbolcular_page.dart';

import '../model/takim.dart';

class TakimSelection extends StatefulWidget {
  const TakimSelection({
    Key? key,
  }) : super(key: key);

  @override
  State<TakimSelection> createState() => _TakimSelectionState();
}

class _TakimSelectionState extends State<TakimSelection> {
  late List<TakimModel> takimlar;
  bool _isLoading = false;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    refreshTakimlar();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Takımlar"),),
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.add),
        onPressed: () async {
          await Navigator.of(context)
              .push(MaterialPageRoute(builder: ((context) => AddTakimPage())));
          refreshTakimlar();
        },
      ),
      body: Center(
        child: _isLoading
            ? CircularProgressIndicator()
            : takimlar.isEmpty
                ? Text("Henüz bir takım yok")
                : buildTakimlar(),
      ),
    );
  }

  buildTakimlar() {
    return Padding(
      padding: const EdgeInsets.all(2.0),
      child: GridView.builder(
          itemCount: takimlar.length,
          gridDelegate: const SliverGridDelegateWithMaxCrossAxisExtent(
              maxCrossAxisExtent: 400,
              childAspectRatio: 1,
              crossAxisSpacing: 10,
              mainAxisSpacing: 10),
          itemBuilder: (context, index) {
            final takim = takimlar[index];
            FutbolcuDataBase.instance.updateKadroDegeri(takim);
            return GestureDetector(
              onTap: () async {
                await Navigator.of(context).push(MaterialPageRoute(
                    builder: ((context) => Bilgiler(takim: takim))));
              },
              child: Card(
                child: Container(
                  padding: EdgeInsets.all(8),
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Container(
                        constraints: BoxConstraints(maxHeight: 40, maxWidth: 40, minHeight: 40,minWidth: 40),
                        child: Image.network(takim.resim),
                      ),
                      SizedBox(height: 7,),
                      Text(takim.isim),
                      SizedBox(height: 5,),
                      Row(
                        children: [
                          Text("Kuruluş Yılı: "),
                          Text(takim.kurulus.toString())
                        ],
                      ),
                      SizedBox(height: 5),
                      Row(
                        children: [
                          Text("Kadro Değeri: "),
                          Text(takim.kadroDegeri.toString())
                        ],
                      )
                    ],
                  ),
                ),
              ),
            );
          }),
    );
  }

  @override
  void dispose() {
    FutbolcuDataBase.instance.close();
    super.dispose();
  }

  Future<void> refreshTakimlar() async {
    setState(() {
      _isLoading = true;
    });
    takimlar = await FutbolcuDataBase.instance.readAllTakim();
    setState(() {
      _isLoading = false;
    });
  }
}
