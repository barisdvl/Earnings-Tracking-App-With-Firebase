import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class AddScreen extends StatefulWidget {
  const AddScreen({Key? key}) : super(key: key);

  @override
  _AddScreenState createState() => _AddScreenState();
}

class _AddScreenState extends State<AddScreen> {
  var tfLoc = TextEditingController();
  var tfExpensesDetail = TextEditingController();
  var tfIncomeAmount = TextEditingController();
  var tfExpensesAmount = TextEditingController();
  var tfTip = TextEditingController();
  var tfDate = TextEditingController();
  var tfExpensesDate = TextEditingController();

  bool extraCond = false;
  bool dutyCond = false;
  bool headroadCond = false;

  String dropdownValue = "TL";
  String tipsAmountValue = "TL";
  String expensesAmountValue = "TL";
  String costTypeValue = "ARABA";

  DateTime selectedDate = DateTime.now();

  CollectionReference data = FirebaseFirestore.instance.collection('data');

  Future<void> addIncomeEntry(
    String entry_type,
    Timestamp entry_date,
    String entry_detail,
    int entry_amount,
    String entry_amount_type,
    int entry_tipamount,
    String entry_tipamount_type,
    bool? extracond,
    bool? dutycond,
    bool? headroadcond,
  ) {
    return data
        .add({
          "entry_type": entry_type,
          "entry_date": entry_date,
          "entry_detail": entry_detail,
          "entry_amount": entry_amount,
          "entry_amount_type": entry_amount_type,
          "entry_tipamount": entry_tipamount,
          "entry_tipamount_type": entry_tipamount_type,
          "extracond": extracond,
          "dutycond": dutycond,
          "headroadcond": headroadcond,
        })
        .then((value) => print("Entry added"))
        .catchError((error) => print("Failed add to entry: $error"));
  }

  Future<void> addExpensisEntry(
    String entry_type,
    String entry_date,
    String entry_detail,
    int entry_amount,
    String entry_amount_type,
    String entry_cost_type,
  ) {
    return data
        .add({
          "entry_type": entry_type,
          "entry_date": entry_date,
          "entry_detail": entry_detail,
          "entry_amount": entry_amount,
          "entry_amount_type": entry_amount_type,
          "entry_cost_type": entry_cost_type,
        })
        .then((value) => print("Entry added"))
        .catchError((error) => print("Failed add to entry: $error"));
  }

  @override
  void initState() {
    super.initState();
    tfDate.text =
        "${DateTime.now().day}.${DateTime.now().month}.${DateTime.now().year}";
    tfExpensesDate.text =
        "${DateTime.now().day}.${DateTime.now().month}.${DateTime.now().year}";

    tfTip.text = "0";
  }

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
        length: 2,
        child: Scaffold(
          backgroundColor: Colors.blueGrey,
          appBar: AppBar(
            title: Text(
              "Kayıt Ekleme",
              style: TextStyle(color: Colors.white),
            ),
            backgroundColor: Colors.yellow.shade700,
            elevation: 0,
            bottom: const TabBar(
                labelColor: Colors.white,
                unselectedLabelColor: Colors.white,
                indicatorSize: TabBarIndicatorSize.label,
                indicator: BoxDecoration(
                    borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(10),
                        topRight: Radius.circular(10)),
                    color: Colors.blueGrey),
                tabs: [
                  Tab(
                    child: Align(
                      alignment: Alignment.center,
                      child: Text("GELİR"),
                    ),
                  ),
                  Tab(
                    child: Align(
                      alignment: Alignment.center,
                      child: Text("GİDER"),
                    ),
                  ),
                ]),
          ),
          body: TabBarView(children: [
            //Income TAB
            Center(
              child: SingleChildScrollView(
                child: Card(
                  margin: EdgeInsets.only(left: 10.0, right: 10.0),
                  clipBehavior: Clip.antiAliasWithSaveLayer,
                  elevation: 3,
                  shadowColor: Colors.blueGrey,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10.0),
                  ),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: TextField(
                          keyboardType: TextInputType.none,
                          controller: tfDate,
                          decoration: InputDecoration(
                            hintText: "Tarih Giriniz",
                            labelText: "Tarih",
                          ),
                          onTap: () {
                            showDatePicker(
                                    context: context,
                                    initialDate: DateTime.now(),
                                    firstDate: DateTime(2010),
                                    lastDate: DateTime(2101))
                                .then((receivedDate) {
                              if (receivedDate != null) {
                                setState(() {
                                  selectedDate = receivedDate;
                                  tfDate.text =
                                      "${receivedDate.day}.${receivedDate.month}.${receivedDate.year}";
                                });
                              }
                            });
                          },
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: TextField(
                          controller: tfLoc,
                          decoration: InputDecoration(
                            hintText: "Detay",
                            labelText: "Detay",
                          ),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Expanded(
                              flex: 3,
                              child: TextField(
                                keyboardType: TextInputType.number,
                                controller: tfIncomeAmount,
                                decoration: InputDecoration(
                                  hintText: "Tutar",
                                  labelText: "Tutar",
                                ),
                              ),
                            ),
                            Expanded(
                              flex: 1,
                              child: DropdownButton(
                                elevation: 5,
                                value: dropdownValue,
                                onChanged: (String? newValue) {
                                  setState(() {
                                    dropdownValue = newValue!;
                                  });
                                },
                                items: [
                                  "TL",
                                  "EUR",
                                  "USD",
                                  "GBP",
                                  "DİĞER"
                                ].map<DropdownMenuItem<String>>((String value) {
                                  return DropdownMenuItem<String>(
                                    value: value,
                                    child: Text(
                                      value,
                                    ),
                                  );
                                }).toList(),
                              ),
                            )
                          ],
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Expanded(
                              flex: 3,
                              child: TextField(
                                keyboardType: TextInputType.number,
                                controller: tfTip,
                                decoration: InputDecoration(
                                  hintText: "Bahşiş",
                                  labelText: "Bahşiş",
                                ),
                              ),
                            ),
                            Expanded(
                              flex: 1,
                              child: DropdownButton(
                                elevation: 5,
                                value: tipsAmountValue,
                                onChanged: (String? newValue) {
                                  setState(() {
                                    tipsAmountValue = newValue!;
                                  });
                                },
                                items: [
                                  "TL",
                                  "EUR",
                                  "USD",
                                  "GBP",
                                  "DİĞER"
                                ].map<DropdownMenuItem<String>>((String value) {
                                  return DropdownMenuItem<String>(
                                    value: value,
                                    child: Text(
                                      value,
                                    ),
                                  );
                                }).toList(),
                              ),
                            )
                          ],
                        ),
                      ),
                      Column(
                        children: [
                          CheckboxListTile(
                            title: Text("Ek iş"),
                            value: extraCond,
                            controlAffinity: ListTileControlAffinity.leading,
                            onChanged: (bool? veri) {
                              print("Ek iş Seçildi $veri");
                              setState(() {
                                extraCond = veri!;
                              });
                            },
                          ),
                          CheckboxListTile(
                            title: Text("Ara Nöbet"),
                            value: dutyCond,
                            controlAffinity: ListTileControlAffinity.leading,
                            onChanged: (bool? veri) {
                              print("Ara Nöbet Seçildi $veri");
                              setState(() {
                                dutyCond = veri!;
                              });
                            },
                          ),
                          CheckboxListTile(
                            title: Text("Yol Başı"),
                            value: headroadCond,
                            controlAffinity: ListTileControlAffinity.leading,
                            onChanged: (bool? veri) {
                              print("Yol Başı Seçildi $veri");
                              setState(() {
                                headroadCond = veri!;
                              });
                            },
                          ),
                          Padding(
                            padding: const EdgeInsets.all(15.0),
                            child: SizedBox(
                              height: 50,
                              width: 150,
                              child: ElevatedButton(
                                onPressed: () {
                                  setState(() {
                                    (tfTip.text.isEmpty)
                                        ? tfTip.text = "0"
                                        : tfTip.text = tfTip.text;
                                    Timestamp myTimeStamp =
                                        Timestamp.fromDate(selectedDate);

                                    addIncomeEntry(
                                      "Gelir",
                                      myTimeStamp,
                                      tfLoc.text,
                                      int.parse(tfIncomeAmount.text),
                                      dropdownValue,
                                      int.parse(tfTip.text),
                                      tipsAmountValue,
                                      extraCond,
                                      dutyCond,
                                      headroadCond,
                                    );
                                    print(
                                        "Tarih : ${tfDate.text} - Açıklama: ${tfLoc.text} Tutar: ${tfIncomeAmount.text} ${dropdownValue} Bahşiş: ${tfTip.text} ${tipsAmountValue} Ek iş mi?:${extraCond} Nöbet mi?: ${dutyCond} Yol Başı mı?:${headroadCond}");
                                    tfDate.text =
                                        "${DateTime.now().day}.${DateTime.now().month}.${DateTime.now().year}";
                                    tfLoc.clear();
                                    tfIncomeAmount.clear();
                                    tfTip.text = "0";
                                    extraCond = false;
                                    headroadCond = false;
                                    dutyCond = false;
                                  });
                                },
                                child: Text("Ekle"),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
            ),
            //Expenses TAB
            Center(
              child: SingleChildScrollView(
                child: Card(
                  margin: EdgeInsets.only(left: 10.0, right: 10.0),
                  clipBehavior: Clip.antiAliasWithSaveLayer,
                  elevation: 3,
                  shadowColor: Colors.blueGrey,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10.0),
                  ),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: TextField(
                          keyboardType: TextInputType.none,
                          controller: tfExpensesDate,
                          decoration: InputDecoration(
                              hintText: "Tarih Giriniz", labelText: "Tarih"),
                          onTap: () {
                            showDatePicker(
                                    context: context,
                                    initialDate: DateTime.now(),
                                    firstDate: DateTime(2010),
                                    lastDate: DateTime(2101))
                                .then((receivedDate) {
                              if (receivedDate != null) {
                                setState(() {
                                  tfExpensesDate.text =
                                      "${receivedDate.day}.${receivedDate.month}.${receivedDate.year}";
                                });
                              }
                            });
                          },
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: TextField(
                          controller: tfExpensesDetail,
                          decoration: InputDecoration(
                            hintText: "Detay",
                            labelText: "Detay",
                          ),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Expanded(
                              flex: 3,
                              child: TextField(
                                keyboardType: TextInputType.number,
                                controller: tfExpensesAmount,
                                decoration: InputDecoration(
                                  hintText: "Tutar",
                                  labelText: "Tutar",
                                ),
                              ),
                            ),
                            Expanded(
                              flex: 1,
                              child: DropdownButton(
                                elevation: 5,
                                value: expensesAmountValue,
                                onChanged: (String? newValue) {
                                  setState(() {
                                    expensesAmountValue = newValue!;
                                  });
                                },
                                items: [
                                  "TL",
                                  "EUR",
                                  "DOLAR",
                                  "POUND",
                                  "DİĞER"
                                ].map<DropdownMenuItem<String>>((String value) {
                                  return DropdownMenuItem<String>(
                                    value: value,
                                    child: Text(
                                      value,
                                    ),
                                  );
                                }).toList(),
                              ),
                            )
                          ],
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Row(
                          children: [
                            Padding(
                              padding: const EdgeInsets.only(
                                  right: 10.0, top: 5.0, bottom: 5.0),
                              child: Text("Masraf Türü: "),
                            ),
                            Padding(
                              padding: const EdgeInsets.only(
                                  left: 8.0,
                                  right: 10.0,
                                  top: 5.0,
                                  bottom: 5.0),
                              child: DropdownButton(
                                elevation: 5,
                                value: costTypeValue,
                                onChanged: (String? newValue) {
                                  setState(() {
                                    costTypeValue = newValue!;
                                  });
                                },
                                items: [
                                  "YAKIT",
                                  "ARABA",
                                  "DURAK",
                                  "VERGİ",
                                  "BAĞKUR",
                                  "DİĞER"
                                ].map<DropdownMenuItem<String>>((String value) {
                                  return DropdownMenuItem<String>(
                                    value: value,
                                    child: Text(
                                      value,
                                    ),
                                  );
                                }).toList(),
                              ),
                            ),
                          ],
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(15.0),
                        child: SizedBox(
                          height: 50,
                          width: 150,
                          child: ElevatedButton(
                            onPressed: () {
                              setState(() {
                                addExpensisEntry(
                                  "Gider",
                                  tfExpensesDate.text,
                                  tfExpensesDetail.text,
                                  int.parse(tfExpensesAmount.text),
                                  expensesAmountValue,
                                  costTypeValue,
                                );
                                print(
                                    "Tarih : ${tfExpensesDate.text} - Açıklama: ${tfExpensesDetail.text} Tutar: ${tfExpensesAmount.text} ${expensesAmountValue} Masraf Türü: ${costTypeValue}");
                                tfExpensesAmount.clear();
                                tfExpensesDate.text =
                                    "${DateTime.now().day}.${DateTime.now().month}.${DateTime.now().year}";
                                tfExpensesDetail.clear();
                                expensesAmountValue = "TL";
                                costTypeValue = "YAKIT";
                              });
                            },
                            child: Text("Ekle"),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ]),
        ));
  }
}
