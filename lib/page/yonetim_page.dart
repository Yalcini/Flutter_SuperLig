import 'package:flutter/material.dart';
import 'package:flutter_application_4/db/futbolcu_database.dart';
import 'package:flutter_application_4/model/takim.dart';
import 'package:flutter_application_4/model/yonetim.dart';
import 'package:flutter_application_4/page/add_yonetim_page.dart';

class YonetimPage extends StatefulWidget {
  final TakimModel takim;
  const YonetimPage({Key? key, required this.takim}) : super(key: key);

  @override
  State<YonetimPage> createState() => _YonetimPageState();
}

class _YonetimPageState extends State<YonetimPage> {
  bool _isLoading = false;
  late List<Yonetim> yonetim;

  @override
  void initState() {
    super.initState();
    refreshYonetim();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: FloatingActionButton(
        backgroundColor: Colors.black,
        onPressed: () async {
          await Navigator.of(context).push(MaterialPageRoute(builder: ((context) => AddYonetimPage(takim: widget.takim))));
          refreshYonetim();
        },
        child: Icon(Icons.add,),
      ),
      body: Center(
        child: _isLoading
            ? CircularProgressIndicator()
            : yonetim.isEmpty
                ? Text("Yönetim Üyesi Bulunmuyor")
                : buildYonetim(),
      ),
    );
  }

  Future<void> refreshYonetim() async {
    setState(() {
      _isLoading = true;
    });
    yonetim =
        await FutbolcuDataBase.instance.readOneTeamsYonetim(widget.takim.id!);

    setState(() {
      _isLoading = false;
    });
  }

  buildYonetim() {
    return Padding(
      padding: const EdgeInsets.all(2.0),
      child: GridView.builder(
          gridDelegate: SliverGridDelegateWithMaxCrossAxisExtent(
              maxCrossAxisExtent: 200,
              childAspectRatio: 1,
              crossAxisSpacing: 20,
              mainAxisSpacing: 20),
          itemBuilder: (context, index) {
            final yonetimUyesi = yonetim[index];
            return GestureDetector(
              child: Card(
                child: Container(
                  child: Column(
                    children: [
                      Icon(Icons.person),
                      Text("İsim: ${yonetimUyesi.isim}"),
                      Text("Görev: ${yonetimUyesi.gorev}"),
                      Text("Yas: ${yonetimUyesi.yas}"),
                      Text("Maas: ${yonetimUyesi.maas}")
                    ],
                  ),
                ),
              ),
            );
          }),
    );
  }
}
