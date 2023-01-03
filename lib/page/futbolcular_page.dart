import 'package:flutter/material.dart';
import 'package:flutter_application_4/db/futbolcu_database.dart';
import 'package:flutter_application_4/model/futbolcu.dart';
import 'package:flutter_application_4/model/takim.dart';
import 'package:flutter_application_4/page/add_futbolcu_page.dart';
import 'package:flutter_application_4/page/futbolcu_detail_page.dart';

class Futbolcular extends StatefulWidget {
  final TakimModel takim;
  const Futbolcular({Key? key, required this.takim}) : super(key: key);

  @override
  State<Futbolcular> createState() => _FutbolcularState();
}

class _FutbolcularState extends State<Futbolcular> {
  late List<Futbolcu> futbolcular;
  bool isLoading = false;

  @override
  void initState() {
    super.initState();
    refreshFutbolcular();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
     
      floatingActionButton: FloatingActionButton(
        onPressed: () async {
          await Navigator.of(context).push(
              MaterialPageRoute(builder: ((context) => AddFutbolcuPage(takim:widget.takim))));
          refreshFutbolcular();
        },
        backgroundColor: Colors.black,
        child: Icon(Icons.add),
      ),
      body: Center(
        child: isLoading
            ? CircularProgressIndicator()
            : futbolcular.isEmpty
                ? Text("Futbolcu Yok")
                : buildFutbolcular(),
      ),
    );
  }

  refreshFutbolcular() async {
    setState(() => isLoading = true);
    futbolcular = await FutbolcuDataBase.instance.readOneTeamsPlayers(widget.takim.id!);
    setState(() => isLoading = false);
  }

  @override
  void dispose() {
    FutbolcuDataBase.instance.close();
    super.dispose();
  }

  Widget buildFutbolcular() {
    return Padding(
      padding: const EdgeInsets.all(2.0),
      child: GridView.builder(
        itemCount: futbolcular.length,
        gridDelegate: const SliverGridDelegateWithMaxCrossAxisExtent(
            maxCrossAxisExtent: 200,
            childAspectRatio: 1,
            crossAxisSpacing: 20,
            mainAxisSpacing: 20),
        itemBuilder: (context, index) {
          final futbolcu = futbolcular[index];

          return GestureDetector(
            onTap: () async {
             await Navigator.of(context).push(MaterialPageRoute(builder: ((context) => FutbolcuDetailPage( futbolcu: futbolcu, takim: widget.takim,))));
             refreshFutbolcular();
            },
            child: Card(
              child: Container(
                padding: EdgeInsets.all(8),
                child: Column(
                  mainAxisSize: MainAxisSize.max,
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    Icon(Icons.person),
                    Row(
                      children: [Text("İsim : "), Text(futbolcu.isim)],
                    ),
                    Row(
                      children: [Text("Uyruk : "), Text(futbolcu.uyruk)],
                    ),
                    Row(
                      children: [Text("Pozisyon : "), Text(futbolcu.pozisyon)],
                    ),
                    Row(
                      children: [
                        Text("Piyasa Değeri : "),
                        Text(futbolcu.piyasa.toString())
                      ],
                    )
                  ],
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
