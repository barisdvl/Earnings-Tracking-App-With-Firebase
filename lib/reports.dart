import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/painting.dart';

class Reports extends StatefulWidget {
  const Reports({Key? key}) : super(key: key);

  @override
  _ReportsState createState() => _ReportsState();
}

class _ReportsState extends State<Reports> {
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

  double incomeTlTotal = 0;
  double incomeEurTotal = 0;
  double incomeUsdTotal = 0;
  double incomeGbpTotal = 0;
  double incomeOtherTotal = 0;

  var refEntries = FirebaseFirestore.instance.collection('data');

  void _onPressed() {
    refEntries
        .where("entry_type", isEqualTo: "Gelir")
        .get()
        .then((querySnapshot) {
      querySnapshot.docs.forEach((result) {
        var data = result.data();
        if (data["entry_amount_type"] == "TL") {
          incomeTlTotal = incomeTlTotal + data["entry_amount"];
        }
        if (data["entry_amount_type"] == "EUR") {
          incomeEurTotal = incomeEurTotal + data["entry_amount"];
        }
        if (data["entry_amount_type"] == "USD") {
          incomeUsdTotal = incomeUsdTotal + data["entry_amount"];
        }
        if (data["entry_amount_type"] == "GBP") {
          incomeGbpTotal = incomeGbpTotal + data["entry_amount"];
        }
        if (data["entry_amount_type"] == "DİĞER") {
          incomeOtherTotal = incomeOtherTotal + data["entry_amount"];
        }
      });
      print(
          "TL: $incomeTlTotal EUR: $incomeEurTotal USD: $incomeUsdTotal GBP: $incomeGbpTotal OTHER: $incomeOtherTotal");
    });
  }

  @override
  void initState() {
    super.initState();
    setState(() {
      _onPressed();
    });
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Center(
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.only(top: 15.0),
              child: SizedBox(
                height: displayHeight(context) * 0.80,
                width: displayWidth(context) * 0.85,
                child: Card(
                  clipBehavior: Clip.antiAliasWithSaveLayer,
                  elevation: 5,
                  semanticContainer: true,
                  shadowColor: Colors.white38,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10.0),
                  ),
                  child: Padding(
                    padding:
                        const EdgeInsets.only(top: 3.0, right: 6.0, left: 6.0),
                    child: Column(
                      children: [
                        Card(
                            color: Colors.green.shade600,
                            elevation: 3,
                            shadowColor: Colors.yellow.shade400,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(10.0),
                            ),
                            child: Container(
                                margin: EdgeInsets.all(8),
                                alignment: Alignment.centerLeft,
                                child: Column(
                                  children: [
                                    Container(
                                      color: Colors.red,
                                      child: Text(
                                        "This page is failed, will be fixed.",
                                        style: TextStyle(
                                          fontSize: 20,
                                          color: Colors.white,
                                          fontWeight: FontWeight.bold,
                                        ),
                                      ),
                                    ),
                                    Container(
                                      color: Colors.red,
                                      child: Text(
                                        "Bu sayfa hatalı. Düzeltilecektir.",
                                        style: TextStyle(
                                          fontSize: 20,
                                          color: Colors.white,
                                          fontWeight: FontWeight.bold,
                                        ),
                                      ),
                                    ),
                                    Row(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        Text(
                                          "Gelir İstatistik",
                                          style: TextStyle(
                                              fontSize: 21,
                                              color: Colors.white,
                                              fontWeight: FontWeight.bold),
                                        ),
                                        TextButton(
                                          child: Icon(
                                            Icons.refresh_rounded,
                                            color: Colors.white,
                                          ),
                                          onPressed: () {
                                            setState(() {
                                              double incomeTlTotal = 0;
                                              double incomeEurTotal = 0;
                                              double incomeUsdTotal = 0;
                                              double incomeGbpTotal = 0;
                                              double incomeOtherTotal = 0;
                                              _onPressed();
                                            });
                                          },
                                        ),
                                      ],
                                    ),
                                    Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        Text(
                                          "TÜRK LİRASI Bakiye: ",
                                          style: TextStyle(fontSize: 20),
                                        ),
                                        Text(
                                          "$incomeTlTotal",
                                          style: TextStyle(fontSize: 20),
                                        ),
                                      ],
                                    ),
                                    Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        Text(
                                          "EURO Bakiye: ",
                                          style: TextStyle(fontSize: 20),
                                        ),
                                        Text(
                                          "$incomeEurTotal",
                                          style: TextStyle(fontSize: 20),
                                        ),
                                      ],
                                    ),
                                    Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        Text(
                                          "DOLAR Bakiye: ",
                                          style: TextStyle(fontSize: 20),
                                        ),
                                        Text(
                                          "$incomeUsdTotal",
                                          style: TextStyle(fontSize: 20),
                                        ),
                                      ],
                                    ),
                                    Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        Text(
                                          "POUND Bakiye: ",
                                          style: TextStyle(fontSize: 20),
                                        ),
                                        Text(
                                          "$incomeGbpTotal",
                                          style: TextStyle(fontSize: 20),
                                        ),
                                      ],
                                    ),
                                    Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        Text(
                                          "DİĞER Bakiye: ",
                                          style: TextStyle(fontSize: 20),
                                        ),
                                        Text(
                                          "$incomeOtherTotal",
                                          style: TextStyle(fontSize: 20),
                                        ),
                                      ],
                                    ),
                                  ],
                                ))),
                        Card(
                            color: Colors.green.shade600,
                            elevation: 3,
                            shadowColor: Colors.yellow.shade400,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(10.0),
                            ),
                            child: Container(
                                margin: EdgeInsets.all(8),
                                alignment: Alignment.centerLeft,
                                child: Column(
                                  children: [
                                    Row(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        Text(
                                          "Gider İstatistik",
                                          style: TextStyle(
                                              fontSize: 21,
                                              color: Colors.white,
                                              fontWeight: FontWeight.bold),
                                        ),
                                        TextButton(
                                          child: Icon(
                                            Icons.refresh_rounded,
                                            color: Colors.white,
                                          ),
                                          onPressed: () {
                                            setState(() {
                                              double incomeTlTotal = 0;
                                              double incomeEurTotal = 0;
                                              double incomeUsdTotal = 0;
                                              double incomeGbpTotal = 0;
                                              double incomeOtherTotal = 0;
                                              _onPressed();
                                            });
                                          },
                                        ),
                                      ],
                                    ),
                                    Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        Text(
                                          "Yakıt Masrafı: ",
                                          style: TextStyle(fontSize: 20),
                                        ),
                                        Text(
                                          "$incomeTlTotal",
                                          style: TextStyle(fontSize: 20),
                                        ),
                                      ],
                                    ),
                                    Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        Text(
                                          "Araba Masrafı: ",
                                          style: TextStyle(fontSize: 20),
                                        ),
                                        Text(
                                          "$incomeEurTotal",
                                          style: TextStyle(fontSize: 20),
                                        ),
                                      ],
                                    ),
                                    Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        Text(
                                          "Durak Masrafı: ",
                                          style: TextStyle(fontSize: 20),
                                        ),
                                        Text(
                                          "$incomeUsdTotal",
                                          style: TextStyle(fontSize: 20),
                                        ),
                                      ],
                                    ),
                                    Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        Text(
                                          "Vergi Masrafı: ",
                                          style: TextStyle(fontSize: 20),
                                        ),
                                        Text(
                                          "$incomeGbpTotal",
                                          style: TextStyle(fontSize: 20),
                                        ),
                                      ],
                                    ),
                                    Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        Text(
                                          "Bağkur Masrafı: ",
                                          style: TextStyle(fontSize: 20),
                                        ),
                                        Text(
                                          "$incomeOtherTotal",
                                          style: TextStyle(fontSize: 20),
                                        ),
                                      ],
                                    ),
                                    Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        Text(
                                          "Diğer Masrafı: ",
                                          style: TextStyle(fontSize: 20),
                                        ),
                                        Text(
                                          "$incomeOtherTotal",
                                          style: TextStyle(fontSize: 20),
                                        ),
                                      ],
                                    ),
                                  ],
                                ))),
                      ],
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
