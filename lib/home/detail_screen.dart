import 'dart:core';

import 'package:covid19_app/home/countaries_list.dart';
import 'package:flutter/material.dart';

class DetailScreen extends StatefulWidget {

  String image ;
  String  name ;
  int totalCases , totalDeaths, totalRecovered , active , critical, todayRecovered , test;

  DetailScreen({super.key,
    required this.image ,
    required this.name ,
    required this.totalCases,
    required this.totalDeaths,
    required this.totalRecovered,
    required this.active,
    required this.critical,
    required this.todayRecovered,
    required this.test,

  }) ;

  @override
  _DetailScreenState createState() => _DetailScreenState();
}

class _DetailScreenState extends State<DetailScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey.shade800,
      appBar: AppBar(
        leading: GestureDetector(
            onTap: () {
              Navigator.push(context, MaterialPageRoute(builder: (context) => const CountriesList()));
            },
            child: const Icon(Icons.arrow_back_ios, color: Colors.white)),
        backgroundColor: Colors.grey.shade700,
        title: Text(widget.name, style: const TextStyle(color: Colors.white)),
        centerTitle: true,

      ),
      body: SafeArea(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Stack(
              alignment: Alignment.topCenter,
              children: [

                Padding(
                  padding:  EdgeInsets.only(top: MediaQuery.of(context).size.height * .067),
                  child: Card(
                    child: Column(
                      children: [
                        SizedBox(height: MediaQuery.of(context).size.height * .06,),
                        ReusableRow(title: 'Cases', value: widget.totalCases.toString(),),
                        ReusableRow(title: 'Recovered', value:  widget.totalRecovered.toString(),),
                        ReusableRow(title: 'Death', value:  widget.totalDeaths.toString(),),
                        ReusableRow(title: 'Critical', value: widget.critical.toString(),),
                        ReusableRow(title: 'Today Recovered', value:widget.totalRecovered.toString(),),

                      ],
                    ),
                  ),
                ),
                Positioned(
                  child: CircleAvatar(
                    radius: 50,
                    backgroundImage: NetworkImage(widget.image),
                  ),
                ),
              ],
            )

          ],
        ),
      ),
    );
  }
}


class ReusableRow extends StatelessWidget {
  String title, value ;
  ReusableRow({super.key , required this.title, required this.value});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: 10 , right: 10 , top: 10 , bottom: 5),
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(title),
              Text(value)
            ],
          ),
          const SizedBox(height: 5,),
          const Divider()
        ],
      ),
    );
  }
}