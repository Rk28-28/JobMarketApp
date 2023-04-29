import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:groupb_final/views/utils/city_search_bar.dart';
import 'package:searchfield/searchfield.dart';
import '../utils/cities_list.dart';

class CompareCityPage extends StatefulWidget {
  const CompareCityPage({Key? key}) : super(key: key);

  @override
  _CompareCityPageState createState() => _CompareCityPageState();
}

class _CompareCityPageState extends State<CompareCityPage> {
  static City _dataCity = City("", 0, 0, 0, 0, 0);
  TextEditingController controller = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
        child: Scaffold(
      body: Column(
        children: [
          SearchBar(controller: controller, voidCallBack: () {
            setState(() {
              print("Callback");
            });
          }),
          FutureBuilder(
              future: getCityInformation(controller),
              builder: (context, future) {
                return Column(
                  children: [
                    Text("Name: ${_dataCity.name}"),
                    Text("Cost of living: ${_dataCity.costOfLivingAvg}"),
                    Text(
                        "Cost of living with rent: ${_dataCity.costOfLivingPlusRentAverage}"),
                    Text(
                        "Local purchasing power: ${_dataCity.localPurchasingPowerAverage}"),
                    Text("Median home price: ${_dataCity.medianHomePrice}"),
                    Text("Average rent: ${_dataCity.rentAvg}")
                  ],
                );
              })
        ],
      ),
    ));
  }
}

Future<void> getCityInformation(TextEditingController controller) async {
  DocumentSnapshot<Map<String, dynamic>> snapshot = await FirebaseFirestore
      .instance
      .collection('CityData')
      .doc(controller.text)
      .get();

  _CompareCityPageState._dataCity = City(
      snapshot["city"],
      snapshot["costOfLivingAvg"],
      snapshot["costOfLivingPlusRentAvg"],
      snapshot["localPurchasingPowerAvg"],
      snapshot["medianHomePrice"],
      snapshot["rentAvg"]);
}

class City {
  final String name;
  final dynamic costOfLivingAvg;
  final dynamic costOfLivingPlusRentAverage;
  final dynamic localPurchasingPowerAverage;
  final dynamic medianHomePrice;
  final dynamic rentAvg;

  City(this.name, this.costOfLivingAvg, this.costOfLivingPlusRentAverage,
      this.localPurchasingPowerAverage, this.medianHomePrice, this.rentAvg);
}
