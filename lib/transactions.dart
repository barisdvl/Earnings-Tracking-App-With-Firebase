import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class Transactions extends StatefulWidget {
  @override
  _TransactionsState createState() => _TransactionsState();
}

class _TransactionsState extends State<Transactions> {
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

  int selectitem = 0;

  var refEntries = FirebaseFirestore.instance.collection('data');

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Center(
        child: Column(
          children: [
            SizedBox(
              height: displayHeight(context) * 0.89,
              child: StreamBuilder<QuerySnapshot>(
                stream: refEntries
                    .orderBy("entry_date", descending: true)
                    .snapshots(),
                builder: (BuildContext context,
                    AsyncSnapshot<QuerySnapshot> snapshot) {
                  if (snapshot.hasData) {
                    return ListView(
                      children:
                          snapshot.data!.docs.map((DocumentSnapshot document) {
                        Map<String, dynamic> data =
                            document.data() as Map<String, dynamic>;
                        DateTime myDateTime = data["entry_date"].toDate();

                        return Card(
                          color: (data["entry_type"] == "Gelir")
                              ? Colors.green.shade400
                              : (data["entry_type"] == "Gider")
                                  ? Colors.red.shade200
                                  : Colors.yellow.shade200,
                          margin: EdgeInsets.all(4.0),
                          elevation: 3,
                          shadowColor: Colors.amber,
                          shape: const RoundedRectangleBorder(
                            borderRadius: BorderRadius.only(
                              bottomRight: Radius.circular(20.0),
                              topLeft: Radius.circular(20.0),
                            ),
                            side: BorderSide(
                              width: 2,
                              color: Colors.black,
                            ),
                          ),
                          child: ListTile(
                            subtitle: Text(
                              data["entry_type"],
                              style: TextStyle(color: Colors.white),
                            ),
                            title: Text(
                              data["entry_detail"],
                              style: TextStyle(
                                fontSize: 20.0,
                                color: Colors.white,
                              ),
                            ),
                            leading: Container(
                              decoration:
                                  const BoxDecoration(color: Colors.white),
                              child: const SizedBox(
                                height: 50,
                                width: 50,
                                child: Icon(
                                  Icons.car_rental,
                                  color: Colors.black,
                                  size: 35.0,
                                ),
                              ),
                            ),
                            trailing: Column(
                              children: [
                                Text(
                                  "${data["entry_amount"]} ${data["entry_amount_type"]}",
                                  style: const TextStyle(
                                      color: Colors.white,
                                      fontWeight: FontWeight.bold,
                                      fontSize: 25.0),
                                ),
                                Text(
                                  "${myDateTime.day}.${myDateTime.month}.${myDateTime.year}",
                                  style: const TextStyle(
                                      fontSize: 15.0, color: Colors.white),
                                ),
                              ],
                            ),
                          ),
                        );
                      }).toList(),
                    );
                  } else {
                    return CircularProgressIndicator();
                  }
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
