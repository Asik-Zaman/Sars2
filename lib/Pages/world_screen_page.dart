import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:pie_chart/pie_chart.dart';
import 'package:sars2/Model/total_model.dart';
import 'package:sars2/Pages/country_list_page.dart';

import 'package:sars2/Utility/api_services.dart';

class WorldScreenPage extends StatefulWidget {
  const WorldScreenPage({Key? key}) : super(key: key);

  @override
  State<WorldScreenPage> createState() => _WorldScreenPageState();
}

class _WorldScreenPageState extends State<WorldScreenPage>
    with TickerProviderStateMixin {
  late final AnimationController _controller = AnimationController(
    duration: const Duration(milliseconds: 1000),
    vsync: this,
  )..repeat();

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  final colorList = <Color>[
    Color(0xff4285F4),
    Color(0xff1aa260),
    Color(0xffde5246),
  ];

  WorldStatesViewModel newsListViewModel = WorldStatesViewModel();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.blueGrey[800],
      body: SafeArea(
        child: Padding(
          padding: EdgeInsets.all(20),
          child: Column(
            children: [
              SizedBox(
                height: MediaQuery.of(context).size.height * .01,
              ),
              FutureBuilder(
                  future: newsListViewModel.fetchWorldRecords(),
                  builder: (context, AsyncSnapshot<TotalModel> snapshot) {
                    if (!snapshot.hasData) {
                      return Expanded(
                          flex: 1,
                          child: SpinKitFadingCircle(
                            size: 50,
                            color: Colors.white,
                            controller: _controller,
                          ));
                    } else {
                      return Column(
                        children: [
                          PieChart(
                              chartType: ChartType.ring,
                              chartRadius:
                                  MediaQuery.of(context).size.width / 3.2,
                              animationDuration: Duration(milliseconds: 1200),
                              legendOptions: LegendOptions(
                                showLegendsInRow: false,
                                legendPosition: LegendPosition.left,
                                showLegends: true,
                                legendTextStyle: TextStyle(
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              chartValuesOptions: const ChartValuesOptions(
                                showChartValueBackground: true,
                                showChartValues: true,
                                showChartValuesInPercentage: true,
                                showChartValuesOutside: false,
                                decimalPlaces: 1,
                              ),
                              colorList: colorList,
                              chartLegendSpacing: 50,
                              initialAngleInDegree: 0,
                              ringStrokeWidth: 15,
                              dataMap: {
                                "Total": double.parse(
                                    snapshot.data!.cases!.toString()),
                                "Recovered": double.parse(
                                    snapshot.data!.recovered!.toString()),
                                "Deaths": double.parse(
                                    snapshot.data!.deaths!.toString()),
                              }),
                          Padding(
                            padding: EdgeInsets.symmetric(
                                vertical:
                                    MediaQuery.of(context).size.height * .04),
                            child: Card(
                              color: Colors.blueGrey[400],
                              child: Column(
                                children: [
                                  ReusableRow(
                                      title: 'Total Cases',
                                      value: snapshot.data!.cases.toString()),
                                  ReusableRow(
                                      title: 'Deaths',
                                      value: snapshot.data!.deaths.toString()),
                                  ReusableRow(
                                      title: 'Recovered',
                                      value:
                                          snapshot.data!.recovered.toString()),
                                  ReusableRow(
                                      title: 'Active',
                                      value: snapshot.data!.active.toString()),
                                  ReusableRow(
                                      title: 'Critical',
                                      value:
                                          snapshot.data!.critical.toString()),
                                  ReusableRow(
                                      title: 'Today Deaths',
                                      value: snapshot.data!.todayDeaths
                                          .toString()),
                                  ReusableRow(
                                      title: 'Today Recovered',
                                      value: snapshot.data!.todayRecovered
                                          .toString()),
                                ],
                              ),
                            ),
                          ),
                          GestureDetector(
                            onTap: () {
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) =>
                                          CountryListScreen()));
                            },
                            child: Container(
                                height: 50,
                                decoration: BoxDecoration(
                                    color: Color(0xff1aa260),
                                    borderRadius: BorderRadius.circular(10)),
                                child: Center(
                                  child: Text(
                                    'Track Countries',
                                    style: TextStyle(color: Colors.white),
                                  ),
                                )),
                          ),
                        ],
                      );
                    }
                  }),
            ],
          ),
        ),
      ),
    );
  }
}

class ReusableRow extends StatelessWidget {
  final String title, value;
  const ReusableRow({Key? key, required this.title, required this.value})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: 10, right: 10, top: 10, bottom: 5),
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [Text(title), Text(value)],
          ),
          Divider()
        ],
      ),
    );
  }
}
