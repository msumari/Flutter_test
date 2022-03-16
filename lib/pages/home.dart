import 'package:flutter/material.dart';
import 'package:navierre/api/getdata.dart';
import 'package:navierre/pages/detail.dart';
import 'package:navierre/reusablewidget/condition.dart';

class Homepage extends StatefulWidget {
  const Homepage({Key? key}) : super(key: key);

  @override
  _HomepageState createState() => _HomepageState();
}

class _HomepageState extends State<Homepage> {
  late Future<GetData> futureGetData;

  @override
  void initState() {
    super.initState();
    var url = Uri.parse(
        "https://firebasestorage.googleapis.com/v0/b/navierre-test.appspot.com/o/data.json?alt=media&token=95462ce7-0718-4111-87ca-6c2ae9c78180");
    futureGetData = GetData.getData(url);
    WidgetsBinding.instance!.addPostFrameCallback((_) => showOverlay()
     );
  }

  OverlayEntry? entry;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: const Text("Navierre"),
        backgroundColor: const Color(0xFFd66394),
        elevation: 0,
      ),
      body: Container(
        padding: const EdgeInsets.all(16.0),
        width: MediaQuery.of(context).size.width,
        height: MediaQuery.of(context).size.height,
        decoration: const BoxDecoration(
          gradient: LinearGradient(colors: [
            Color(0xFFd66394),
            Color(0xFFca6da1),
            Color(0xFFc273a9),
            Color(0xFFba7ab2),
            Color(0xFFb181bb),
            Color(0xFFad85c1),
            Color(0xFFa18fce),
            Color(0xFFa38fcd),
            Color(0xFF9b94d4),
          ], begin: Alignment.topCenter, end: Alignment.bottomCenter),
        ),
        child: FutureBuilder<GetData>(
            future: futureGetData,
            builder: (BuildContext context, AsyncSnapshot<GetData> snapshot) {
              
              if (snapshot.hasData) {
                final temp = integer(snapshot.data!.temp);
                
                return Column(
                  children: <Widget>[
                    Container(
                      padding: const EdgeInsets.all(16.0),
                      height: 250,
                      width: 230,
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(25),
                      ),
                      child: Column(
                        children: <Widget>[
                          SizedBox(
                            height: 70,
                            child: Center(
                              child: Text(
                                '${snapshot.data!.city}, ${snapshot.data!.state}',
                                style: const TextStyle(
                                  fontSize: 17.0,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.black,
                                ),
                              ),
                            ),
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Column(
                                children: <Widget>[
                                  Row(
                                    children: [
                                      Text(
                                        '${temp}°',
                                        style: const TextStyle(
                                          fontSize: 55.0,
                                          fontWeight: FontWeight.bold,
                                          color: Colors.black,
                                        ),
                                      ),
                                      // ignore: prefer_const_constructors
                                      Text(
                                        "c",
                                        style: const TextStyle(
                                          fontSize: 10.0,
                                          fontWeight: FontWeight.bold,
                                          color: Colors.black,
                                        ),
                                      )
                                    ],
                                  ),
                                  const Text(
                                    'Sunday,11 am',
                                    style: TextStyle(
                                      fontSize: 12.0,
                                      color: Colors.grey,
                                    ),
                                  ),
                                ],
                              ),
                              Container(
                                  width: 70,
                                  height: 15,
                                  decoration: BoxDecoration(
                                    color: const Color(0xFFd66394),
                                    borderRadius: BorderRadius.circular(25),
                                  ),
                                  child: Center(
                                    child: Text(
                                      '${snapshot.data!.weather}',
                                      style: const TextStyle(
                                        fontSize: 10.0,
                                        fontWeight: FontWeight.bold,
                                        color: Colors.white,
                                      ),
                                    ),
                                  ))
                            ],
                          ),
                        ],
                      ),
                    ),
                   const  Divider(
                      color: Colors.transparent,
                      thickness:0.0,
                      height: 80,
                    ),
                    conditionTab(Icons.opacity, "Precipitation", snapshot.data!.precipitation, "%"),
                    conditionTab(Icons.thermostat_sharp, "Humidity", snapshot.data!.humidity, "%"),
                    conditionTab(Icons.air_outlined, "Wind", snapshot.data!.windspeed, "km/h"),
                  ],
                );
              } else if (snapshot.hasError) {
                return Text("${snapshot.error}");
              }
              return const CircularProgressIndicator(
                color: Colors.white,
              );
            }),
      ),
    );
  }

  integer(double temp) {
    return temp.toInt();
  }

 

  void showOverlay() {
    entry = OverlayEntry(
      builder: (context) => Positioned(
        left: 85,
        bottom: 150,
        child: OutlinedButton(
          child: const Text(
            'Details',
            style: TextStyle(color: Colors.white),
          ),
          style: OutlinedButton.styleFrom(
              backgroundColor: const Color(0xFF5e53c1),
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(15)),
              shadowColor: const Color(0xFF9b94d4),
              elevation: 5,
              fixedSize: const Size(150, 45)),
          onPressed: () {
            Navigator.push(context,
                MaterialPageRoute(builder: (context) => const Details()));
                hideoverlay();
          },
        ),
      ),
    );

    final overlay = Overlay.of(context);
    overlay!.insert(entry!);
  }

  void hideoverlay() {
    entry?.remove();
    entry = null;
  }
}
