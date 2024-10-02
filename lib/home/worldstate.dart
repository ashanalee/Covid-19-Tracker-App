import 'package:covid19_app/Modal/world_state_model.dart';
import 'package:covid19_app/Services/states_services.dart';
import 'package:covid19_app/home/countaries_list.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:pie_chart/pie_chart.dart';
import 'package:flutter/services.dart';

class Worldstate extends StatefulWidget {
  const Worldstate({super.key});

  @override
  State<Worldstate> createState() => _WorldstateState();
}

class _WorldstateState extends State<Worldstate> with TickerProviderStateMixin {

  late final AnimationController _controller = AnimationController(
      duration: const Duration(seconds: 5),
      vsync: this
  )..repeat();

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  Future<bool> _onWillPop() async {
    SystemNavigator.pop();
    return Future.value(false);
  }

  @override
  Widget build(BuildContext context) {
    StatesServices statesServices = StatesServices();
    return WillPopScope(
      onWillPop: _onWillPop,
      child: Scaffold(
        backgroundColor: Colors.grey.shade800,
        body: SafeArea(
          child: Padding(
            padding: const EdgeInsets.all(15.0),
            child: Column(
              children: [
                SizedBox(height: MediaQuery.of(context).size.height * 0.01,),
                FutureBuilder(
                  future: statesServices.fetchworkstaterecord(),
                  builder: (context, AsyncSnapshot<WorldStateModel> snapshot) {
                    if (!snapshot.hasData) {
                      return Expanded(
                        flex: 1,
                        child: SpinKitFadingCircle(
                          color: Colors.white,
                          size: 50,
                          controller: _controller,
                        ),
                      );
                    } else {
                      return Column(
                        children: [
                          PieChart(
                            dataMap: {
                              'Total': double.parse(snapshot.data!.cases!.toString()),
                              'Recovered': double.parse(snapshot.data!.recovered!.toString()),
                              'Deaths': double.parse(snapshot.data!.deaths.toString()),
                            },
                            chartValuesOptions: const ChartValuesOptions(
                              showChartValuesInPercentage: true,
                            ),
                            chartRadius: MediaQuery.of(context).size.width / 3.2,
                            animationDuration: const Duration(milliseconds: 1200),
                            chartType: ChartType.ring,
                            colorList: const [
                              Color(0xFF4285F4),
                              Color(0xFF1AA268),
                              Color(0xFFDE5246),
                            ],
                            legendOptions: const LegendOptions(
                              legendPosition: LegendPosition.left,
                              legendTextStyle: TextStyle(
                                color: Colors.white,
                              ),
                            ),
                          ),
                          Padding(
                            padding: EdgeInsets.symmetric(vertical: MediaQuery.of(context).size.height * 0.06),
                            child: Card(
                              child: Column(
                                children: [
                                  ReuseableRow(title: 'Total Cases', value: snapshot.data!.cases.toString()),
                                  ReuseableRow(title: 'Deaths', value: snapshot.data!.deaths.toString()),
                                  ReuseableRow(title: 'Recovered', value: snapshot.data!.recovered.toString()),
                                  ReuseableRow(title: 'Active', value: snapshot.data!.active.toString()),
                                  ReuseableRow(title: 'Critical', value: snapshot.data!.critical.toString()),
                                  ReuseableRow(title: 'Today Deaths', value: snapshot.data!.todayDeaths.toString()),
                                  ReuseableRow(title: 'Today Recovered', value: snapshot.data!.todayRecovered.toString()),
                                ],
                              ),
                            ),
                          ),
                          GestureDetector(
                            onTap: () {
                              Navigator.push(context, MaterialPageRoute(builder: (context) =>  const CountriesList()));
                            },
                            child: Container(
                              height: 50,
                              decoration: BoxDecoration(
                                color: const Color(0xFF1aa260),
                                borderRadius: BorderRadius.circular(10),
                              ),
                              child: const Center(
                                child: Text('Track Countries', style: TextStyle(color: Colors.white)),
                              ),
                            ),
                          )
                        ],
                      );
                    }
                  },
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class ReuseableRow extends StatelessWidget {
  final String title;
  final String value;

  const ReuseableRow({super.key, required this.title, required this.value});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(10, 10, 10, 5),
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(title),
              Text(value),
            ],
          ),
          const SizedBox(height: 2),
          const Divider(),
        ],
      ),
    );
  }
}
