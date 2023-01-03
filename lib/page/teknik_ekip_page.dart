import 'package:flutter/material.dart';
import 'package:flutter_application_4/model/teknik.dart';
import 'package:flutter_application_4/page/add_teknik_ekip_page.dart';

import '../db/futbolcu_database.dart';

class TeknikEkipPage extends StatefulWidget {
  final takim;
  const TeknikEkipPage({ Key? key, required this.takim }) : super(key: key);

  @override
  State<TeknikEkipPage> createState() => _TeknikEkipPageState();
}

class _TeknikEkipPageState extends State<TeknikEkipPage> {

  late List<TeknikEkip> teknikEkip;
  bool isLoading = false;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    refreshTeknikEkip();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: FloatingActionButton(onPressed: () async {
        await Navigator.of(context).push(MaterialPageRoute(builder: ((context) => AddTeknikEkip(takim: widget.takim))));
        refreshTeknikEkip();
      }, child: Icon(Icons.add),
      backgroundColor: Colors.black,),
      body: Center(
        child: isLoading
            ? CircularProgressIndicator()
            : teknikEkip.isEmpty
                ? Text("Teknik Ekipte Kimse Yok")
                : buildTeknikEkip(),
      ),
    );

  }

  void refreshTeknikEkip() async {
    setState(() => isLoading = true);
    teknikEkip = await FutbolcuDataBase.instance.readOneTeamsTeknikEkip(widget.takim.id!);
    setState(() => isLoading = false);
  }

  buildTeknikEkip() {
    return Padding(
      padding: const EdgeInsets.all(2.0),
      child: GridView.builder(
        itemCount: teknikEkip.length,
        gridDelegate: const SliverGridDelegateWithMaxCrossAxisExtent(
            maxCrossAxisExtent: 200,
            childAspectRatio: 1,
            crossAxisSpacing: 20,
            mainAxisSpacing: 20),
        itemBuilder: (context, index) {
          final teknikEkip1 = teknikEkip[index];
          return GestureDetector(
            onTap: ()  {
             
             refreshTeknikEkip();
            },
            child: Card(
              child: Container(
                padding: EdgeInsets.all(8),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Icon(Icons.person),
                    Row(
                      children: [Text("İsim : "), Text(teknikEkip1.isim)],
                    ),
                    Row(
                      children: [Text("Görev : "), Text(teknikEkip1.gorev)],
                    ),
                    Row(
                      children: [Text("Maas : "), Text(teknikEkip1.maas.toString())],
                    ),
                    
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