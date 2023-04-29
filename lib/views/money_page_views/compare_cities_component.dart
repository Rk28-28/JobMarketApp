import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:searchfield/searchfield.dart';
import '../utils/cities_list.dart';

class CompareCityPage extends StatefulWidget {
  const CompareCityPage({Key? key}) : super(key: key);

  @override
  _CompareCityPageState createState() => _CompareCityPageState();
}

class _CompareCityPageState extends State<CompareCityPage> {
  dynamic _selectedCity;
  final _formKey = GlobalKey<FormState>();
  final _focus = FocusNode();
  final _searchController = TextEditingController();
  City _dataCity = City("", 0, 0, 0, 0, 0);

  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    _searchController.dispose();
    _focus.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
        onTap: () => FocusScope.of(context).unfocus(),
        child: Scaffold(
          body: Column(
            children: [
              _searchBar(context),
              FutureBuilder(
                  future: getCityInformation(),
                  builder: (context, future) {
                    return Column(
                      children: [
                        Text(
                         "Name: ${_dataCity.name}"
                        ),
                        Text(
                          "Cost of living: ${_dataCity.costOfLivingAvg}"
                        ),
                        Text(
                            "Cost of living with rent: ${_dataCity.costOfLivingPlusRentAverage}"
                        ),
                        Text(
                            "Local purchasing power: ${_dataCity.localPurchasingPowerAverage}"
                        ),
                        Text(
                            "Median home price: ${_dataCity.medianHomePrice}"
                        ),
                        Text(
                            "Average rent: ${_dataCity.rentAvg}"
                        )
                      ],
                    );
                  })
            ],
          ),
        ));
  }

  Widget _searchBar(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Padding(
          padding: const EdgeInsets.only(top: 40, right: 30, left: 30),
          child: Form(
            key: _formKey,
            child: SearchField(
              searchInputDecoration: const InputDecoration(
                enabledBorder: OutlineInputBorder(
                    borderSide: BorderSide(color: Colors.grey, width: 2)),
                focusedBorder: OutlineInputBorder(
                    borderSide: BorderSide(color: Colors.grey, width: 2)),
              ),
              hint: "Search Cities",
              focusNode: _focus,
              controller: _searchController,
              maxSuggestionsInViewPort: 6,
              inputType: TextInputType.text,
              itemHeight: 50,
              onSuggestionTap: (value) {
                setState(() {
                  _selectedCity = value.item;
                });
                _selectedCity = _searchController.text;
                print(_selectedCity);
                getCityInformation();
                _formKey.currentState?.validate();
                _focus.unfocus();
              },
              suggestions: CitiesList.getCities
                  .map((e) => SearchFieldListItem(e))
                  .toList(),
            ),
          ),
        )
      ],
    );

  }

  Future<void> getCityInformation() async {
    DocumentSnapshot<Map<String, dynamic>> snapshot = await FirebaseFirestore.instance
        .collection('CityData').doc(_selectedCity).get();

    _dataCity = City(snapshot["city"], snapshot["costOfLivingAvg"],snapshot["costOfLivingPlusRentAvg"],
      snapshot["localPurchasingPowerAvg"], snapshot["medianHomePrice"], snapshot["rentAvg"]);
  }
}

class City {
  final String name;
  final double costOfLivingAvg;
  final double costOfLivingPlusRentAverage;
  final double localPurchasingPowerAverage;
  final int medianHomePrice;
  final double rentAvg;
  
  City(this.name, this.costOfLivingAvg, this.costOfLivingPlusRentAverage, 
      this.localPurchasingPowerAverage, this.medianHomePrice, this.rentAvg);
}
