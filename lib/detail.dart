import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter/painting.dart';
import 'package:kazanctakip/dashboard.dart';
import 'package:kazanctakip/main.dart';

class DetailScreen extends StatefulWidget {
  final entry_id;

  DetailScreen({required this.entry_id});

  @override
  _DetailScreenState createState() => _DetailScreenState();
}

class _DetailScreenState extends State<DetailScreen> {
  Size displaySize(BuildContext context) {
    debugPrint('Size = ' + MediaQuery.of(context).size.toString());
    return MediaQuery.of(context).size;
  }

  double displayHeight(BuildContext context) {
    debugPrint('Height = ' + displaySize(context).height.toString());
    return displaySize(context).height;
  }

  double displayWidth(BuildContext context) {
    debugPrint('Width = ' + displaySize(context).width.toString());
    return displaySize(context).width;
  }

  var refEntries = FirebaseFirestore.instance.collection('data');

  Future<void> deleteEntry() async {
    return refEntries
        .doc(widget.entry_id)
        .delete()
        .then((value) => print("Entry Deleted"))
        .catchError((error) => print("Failed to delete entry: $error"));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.blueGrey.shade800,
      appBar: AppBar(
        backgroundColor: Colors.yellow.shade700,
        title: Text(
          "Detay Ekranı",
          style: TextStyle(color: Colors.white),
        ),
        actions: [
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: TextButton(
                  onPressed: () {
                    Navigator.pop(context);

                    deleteEntry();
                  },
                  child: Text(
                    "Sil",
                    style: TextStyle(color: Colors.white),
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
      body: StreamBuilder<DocumentSnapshot<Map<String, dynamic>>>(
        stream: refEntries.doc(widget.entry_id).snapshots(),
        builder: (_, snapshot) {
          if (snapshot.hasError) return Text('Error = ${snapshot.error}');

          if (snapshot.hasData &&
              snapshot.data != null &&
              snapshot.data!.exists) {
            var data = snapshot.data!.data();
            var value = data!['entry_type']; // <-- Your value
            if (value == "Gelir") {
              DateTime myDateTime = data["entry_date"].toDate();
              return Center(
                child: SizedBox(
                  height: displayHeight(context) * 0.80,
                  width: displayWidth(context) * 0.85,
                  child: Card(
                    clipBehavior: Clip.antiAliasWithSaveLayer,
                    elevation: 3,
                    shadowColor: Colors.blueGrey,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10.0),
                    ),
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          Card(
                              color: Colors.yellow.shade300,
                              elevation: 3,
                              shadowColor: Colors.yellow.shade400,
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(10.0),
                              ),
                              child: Container(
                                  margin: EdgeInsets.all(8),
                                  alignment: Alignment.centerLeft,
                                  height: displayHeight(context) * 0.03,
                                  child: Text(
                                    "Tarih: ${myDateTime.day}.${myDateTime.month}.${myDateTime.year}",
                                    style: TextStyle(fontSize: 20),
                                  ))),
                          Card(
                              color: Colors.yellow.shade300,
                              elevation: 3,
                              shadowColor: Colors.yellow.shade400,
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(10.0),
                              ),
                              child: Container(
                                  margin: EdgeInsets.all(8),
                                  alignment: Alignment.centerLeft,
                                  height: displayHeight(context) * 0.03,
                                  child: Text(
                                    "Açıklama: ${data["entry_detail"]}",
                                    style: TextStyle(fontSize: 20),
                                  ))),
                          Card(
                              color: Colors.yellow.shade300,
                              elevation: 3,
                              shadowColor: Colors.yellow.shade400,
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(10.0),
                              ),
                              child: Container(
                                  margin: EdgeInsets.all(8),
                                  alignment: Alignment.centerLeft,
                                  height: displayHeight(context) * 0.03,
                                  child: Text(
                                    "Tutar: ${data["entry_amount"]} ${data["entry_amount_type"]}",
                                    style: TextStyle(fontSize: 20),
                                  ))),
                          Card(
                              color: Colors.yellow.shade300,
                              elevation: 3,
                              shadowColor: Colors.yellow.shade400,
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(10.0),
                              ),
                              child: Container(
                                  margin: EdgeInsets.all(8),
                                  alignment: Alignment.centerLeft,
                                  height: displayHeight(context) * 0.03,
                                  child: Text(
                                    "Bahşiş: ${data["entry_tipamount"]} ${data["entry_tipamount_type"]}",
                                    style: TextStyle(fontSize: 20),
                                  ))),
                          Card(
                              color: Colors.yellow.shade300,
                              elevation: 3,
                              shadowColor: Colors.yellow.shade400,
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(10.0),
                              ),
                              child: Container(
                                  margin: EdgeInsets.all(8),
                                  alignment: Alignment.centerLeft,
                                  height: displayHeight(context) * 0.03,
                                  child: Text(
                                    "Ek iş mi? : ${(data["extracond"]) ? "Evet" : "Hayır"}",
                                    style: TextStyle(fontSize: 20),
                                  ))),
                          Card(
                              color: Colors.yellow.shade300,
                              elevation: 3,
                              shadowColor: Colors.yellow.shade400,
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(10.0),
                              ),
                              child: Container(
                                  margin: EdgeInsets.all(8),
                                  alignment: Alignment.centerLeft,
                                  height: displayHeight(context) * 0.03,
                                  child: Text(
                                    "Ara nöbet mi? : ${(data["dutycond"]) ? "Evet" : "Hayır"}",
                                    style: TextStyle(fontSize: 20),
                                  ))),
                          Card(
                              color: Colors.yellow.shade300,
                              elevation: 3,
                              shadowColor: Colors.yellow.shade400,
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(10.0),
                              ),
                              child: Container(
                                  margin: EdgeInsets.all(8),
                                  alignment: Alignment.centerLeft,
                                  height: displayHeight(context) * 0.03,
                                  child: Text(
                                    "Yol başı mı? : ${(data["headroadcond"]) ? "Evet" : "Hayır"}",
                                    style: TextStyle(fontSize: 20),
                                  ))),
                        ],
                      ),
                    ),
                  ),
                ),
              );
            }
            if (value == "Gider") {
              return Center(
                child: SizedBox(
                  height: displayHeight(context) * 0.40,
                  width: displayWidth(context) * 0.85,
                  child: Card(
                    clipBehavior: Clip.antiAliasWithSaveLayer,
                    elevation: 3,
                    shadowColor: Colors.blueGrey,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10.0),
                    ),
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          Card(
                              color: Colors.yellow.shade300,
                              elevation: 3,
                              shadowColor: Colors.yellow.shade400,
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(10.0),
                              ),
                              child: Container(
                                  margin: EdgeInsets.all(8),
                                  alignment: Alignment.centerLeft,
                                  height: displayHeight(context) * 0.03,
                                  child: Text(
                                    "Tarih: ${data["entry_date"]}",
                                    style: TextStyle(fontSize: 20),
                                  ))),
                          Card(
                              color: Colors.yellow.shade300,
                              elevation: 3,
                              shadowColor: Colors.yellow.shade400,
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(10.0),
                              ),
                              child: Container(
                                  margin: EdgeInsets.all(8),
                                  alignment: Alignment.centerLeft,
                                  height: displayHeight(context) * 0.03,
                                  child: Text(
                                    "Açıklama: ${data["entry_detail"]}",
                                    style: TextStyle(fontSize: 20),
                                  ))),
                          Card(
                              color: Colors.yellow.shade300,
                              elevation: 3,
                              shadowColor: Colors.yellow.shade400,
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(10.0),
                              ),
                              child: Container(
                                  margin: EdgeInsets.all(8),
                                  alignment: Alignment.centerLeft,
                                  height: displayHeight(context) * 0.03,
                                  child: Text(
                                    "Tutar: ${data["entry_amount"]} ${data["entry_amount_type"]}",
                                    style: TextStyle(fontSize: 20),
                                  ))),
                          Card(
                              color: Colors.yellow.shade300,
                              elevation: 3,
                              shadowColor: Colors.yellow.shade400,
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(10.0),
                              ),
                              child: Container(
                                  margin: EdgeInsets.all(8),
                                  alignment: Alignment.centerLeft,
                                  height: displayHeight(context) * 0.03,
                                  child: Text(
                                    "Masraf Türü: ${data["entry_cost_type"]}",
                                    style: TextStyle(fontSize: 20),
                                  ))),
                        ],
                      ),
                    ),
                  ),
                ),
              );
            }
          }

          return Center(child: CircularProgressIndicator());
        },
      ),
    );
  }
}
