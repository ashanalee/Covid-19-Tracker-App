import 'package:covid19_app/Services/states_services.dart';
import 'package:covid19_app/home/worldstate.dart';
import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';

import 'detail_screen.dart';

class CountriesList extends StatefulWidget {
  const CountriesList({super.key});

  @override
  State<CountriesList> createState() => _CountriesListState();
}

class _CountriesListState extends State<CountriesList> {

  TextEditingController controller = TextEditingController();

  @override
  Widget build(BuildContext context) {
    StatesServices statesServices = StatesServices();
    return Scaffold(
      backgroundColor: Colors.grey.shade800,
      appBar: AppBar(
        leading: GestureDetector(
            onTap: () {
              Navigator.push(context, MaterialPageRoute(builder: (context) => const Worldstate()));
            },
            child: const Icon(Icons.arrow_back_ios, color: Colors.white)
        ),
        elevation: 0,
        backgroundColor: Colors.grey.shade800,
      ),
      body: SafeArea(
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: TextFormField(
                onChanged: (value) {
                  setState(() {});
                },
                controller: controller,
                decoration: InputDecoration(
                  contentPadding: const EdgeInsets.symmetric(horizontal: 20),
                  hintText: 'Search with country name',
                  hintStyle: const TextStyle(color: Colors.white),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(50.0),
                  ),
                ),
              ),
            ),
            Expanded(
              child: FutureBuilder(
                future: statesServices.Countrieslist(),
                builder: (context, AsyncSnapshot<List<dynamic>> snapshot) {
                  if (!snapshot.hasData) {
                    return ListView.builder(
                      itemCount: 4,
                      itemBuilder: (context, index) {
                        return Shimmer.fromColors(
                          baseColor: Colors.grey.shade700,
                          highlightColor: Colors.grey.shade700,
                          child: Column(
                            children: [
                              ListTile(
                                leading: Container(height: 10, width: 89, color: Colors.white),
                                title: Container(height: 10, width: 89, color: Colors.white),
                                subtitle: Container(height: 10, width: 89, color: Colors.white),
                              ),
                            ],
                          ),
                        );
                      },
                    );
                  } else {
                    return ListView.builder(
                      itemCount: snapshot.data!.length,
                      itemBuilder: (context, index) {
                        String name = snapshot.data![index]['country'];
                        if (controller.text.isEmpty || name.toLowerCase().contains(controller.text.toLowerCase())) {
                          return Column(
                            children: [
                              InkWell(
                                onTap: () {
                                  Navigator.push(context, MaterialPageRoute(builder: (context) => DetailScreen(
                                    image: snapshot.data![index]['countryInfo']['flag'],
                                    name: snapshot.data![index]['country'],
                                    totalCases: snapshot.data![index]['cases'],
                                    totalRecovered: snapshot.data![index]['recovered'],
                                    totalDeaths: snapshot.data![index]['deaths'],
                                    active: snapshot.data![index]['active'],
                                    test: snapshot.data![index]['tests'],
                                    todayRecovered: snapshot.data![index]['todayRecovered'],
                                    critical: snapshot.data![index]['critical'],
                                  )));
                                },
                                child: ListTile(
                                  leading: Image(
                                      height: 50,
                                      width: 50,
                                      image: NetworkImage(snapshot.data![index]['countryInfo']['flag'])
                                  ),
                                  title: Text(snapshot.data![index]['country'], style: const TextStyle(color: Colors.white)),
                                  subtitle: Text(snapshot.data![index]['cases'].toString(), style: const TextStyle(color: Colors.white)),
                                ),
                              ),
                            ],
                          );
                        } else {
                          return Container();
                        }
                      },
                    );
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
