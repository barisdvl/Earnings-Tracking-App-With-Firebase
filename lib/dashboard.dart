import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:kazanctakip/detail.dart';
import 'package:syncfusion_flutter_charts/charts.dart';

class DashBoard extends StatefulWidget {
  const DashBoard({Key? key}) : super(key: key);

  @override
  _DashBoardState createState() => _DashBoardState();
}

class _DashBoardState extends State<DashBoard> {
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
  double incomeTotal = 40.0;
  double expensesTotal = 60.0;

  List<ChartData> chartData = <ChartData>[
    /*ChartData('Income', 56, const Color.fromRGBO(595, 570, 100, 100)),
    ChartData('Expenses', 44, const Color.fromRGBO(100, 100, 250, 50)),*/
  ];
  Future<void> addTotal() async {
    chartData.add(ChartData("Income", incomeTotal, Colors.green.shade500));
    chartData.add(ChartData("Expenses", expensesTotal, Colors.red.shade500));
  }

  @override
  void initState() {
    super.initState();
    addTotal();
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Center(
        child: Column(
          children: [
            Container(
              height: displayHeight(context) * 0.36,
              color: Colors.white,
              child: SfCircularChart(
                backgroundColor: Colors.blueGrey.shade800,
                annotations: <CircularChartAnnotation>[
                  CircularChartAnnotation(
                      widget: Container(
                          child: const Text('3.000,00 TL',
                              style: TextStyle(
                                  color: Colors.white, fontSize: 25)))),
                ],
                series: <CircularSeries>[
                  DoughnutSeries<ChartData, String>(
                    dataSource: chartData,
                    pointColorMapper: (ChartData data, _) => data.color,
                    xValueMapper: (ChartData data, _) => data.x,
                    yValueMapper: (ChartData data, _) => data.y,
                    startAngle: 590, // starting angle of pie
                    endAngle: 490, // ending angle of pie
                    innerRadius: '70%',
                  ),
                ],
              ),
            ),
            Row(
              children: [
                Container(
                  child: Padding(
                    padding: const EdgeInsets.only(
                        left: 7.0, right: 7.0, bottom: 2.0),
                    child: Text(
                      "Son 10 Hareket",
                      style: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                          color: Colors.white),
                    ),
                  ),
                ),
              ],
            ),
            SingleChildScrollView(
              child: Center(
                child: Column(
                  children: [
                    SizedBox(
                      height: displayHeight(context) * 0.50,
                      child: StreamBuilder<QuerySnapshot>(
                        stream: refEntries
                            .orderBy("entry_date", descending: true)
                            .limit(10)
                            .snapshots(),
                        builder: (BuildContext context,
                            AsyncSnapshot<QuerySnapshot> snapshot) {
                          if (snapshot.hasData) {
                            return ListView(
                              children: snapshot.data!.docs
                                  .map((DocumentSnapshot document) {
                                Map<String, dynamic> data =
                                    document.data() as Map<String, dynamic>;
                                DateTime myDateTime =
                                    data["entry_date"].toDate();

                                return GestureDetector(
                                  onTap: () {
                                    Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                            builder: (context) => DetailScreen(
                                                  entry_id: refEntries
                                                      .doc(document.id)
                                                      .id,
                                                )));
                                    print(
                                        "${refEntries.doc(document.id).id} - Push Detail Screen");
                                  },
                                  child: Card(
                                    color: (data["entry_type"] == "Gelir")
                                        ? Colors.green.shade500
                                        : (data["entry_type"] == "Gider")
                                            ? Colors.red.shade500
                                            : Colors.yellow.shade500,
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
                                        decoration: const BoxDecoration(
                                            color: Colors.white),
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
                                                fontSize: 15.0,
                                                color: Colors.white),
                                          ),
                                        ],
                                      ),
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
            ),
          ],
        ),
      ),
    );
  }
}

class ChartData {
  ChartData(this.x, this.y, this.color);
  final String x;
  final double y;
  final Color? color;
}
