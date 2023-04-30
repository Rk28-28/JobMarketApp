import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:searchfield/searchfield.dart';

import '../utils/cities_list.dart';


class CompareJobPage extends StatefulWidget {
  const CompareJobPage({Key? key}) : super(key: key);

  @override
  _CompareJobPageState createState() => _CompareJobPageState();
}

class _CompareJobPageState extends State<CompareJobPage> {
  dynamic _selectedCity;
  dynamic _secondselectedCity;
  final _firstFormKey = GlobalKey<FormState>();
  final _secondFormKey = GlobalKey<FormState>();
  final _focus = FocusNode();
  final _secondfocus = FocusNode();
  final _searchController = TextEditingController();
  final _secondsearchController = TextEditingController();
  bool _show = false;
  bool _secondshow = false;
  City _dataCity = City("First City", 0, 0, 0, 0);
  City _seconddataCity = City("Second City", 0, 0, 0, 0);

  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    _searchController.dispose();
    _secondsearchController.dispose();
    _focus.dispose();
    _secondfocus .dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
        onTap: () => FocusScope.of(context).unfocus(),
        child: Scaffold(
            backgroundColor: Colors.brown[100],
            resizeToAvoidBottomInset: false,
            body: Column(
              children: [
                SizedBox(height: 20),
                Text("Compare Salaries By City", style: TextStyle(fontWeight: FontWeight.bold,
                fontSize: 20)),
                  _FirstSearchBar(context),
                  _SecondSearchBar(context),

                FutureBuilder(
                    future: getCityInformation(),
                    builder: (context, future) {
                      return Expanded(
                        child: GridView.count(
                          crossAxisCount: 2,
                          childAspectRatio: 1.2,
                          mainAxisSpacing: 16,
                          crossAxisSpacing: 16,
                          children: [
                            Card(
                              color: Colors.green[600],
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Text("${_dataCity.name}",
                                      textAlign: TextAlign.center,
                                      style: TextStyle(fontSize: 24,
                                          fontWeight: FontWeight.bold)),
                                ],
                              ),
                            ),
                            Card(
                              color: Colors.green[600],
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Text("${_seconddataCity.name}",
                                      textAlign: TextAlign.center,
                                      style: TextStyle(fontSize: 24,
                                          fontWeight: FontWeight.bold)),
                                ],
                              ),
                            ),
                          Card(
                            color: Colors.green[300],
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Text("Number of Software Developer Jobs",
                                    textAlign: TextAlign.center,
                                    style: TextStyle(fontSize: 20,
                                        fontWeight: FontWeight.bold)),
                                SizedBox(height: 16),
                                Visibility(
                                  visible: _show,
                                  child: Text(
                                      "${_dataCity.numberOfJobs}",
                                      textAlign: TextAlign.center,
                                      style: TextStyle(fontSize: 18,
                                          fontWeight: FontWeight.bold)),
                                ),
                              ],
                            ),
                          ),
                          Card(
                            color: Colors.green[300],
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Text("Number of Software Developer Jobs",
                                    textAlign: TextAlign.center,
                                    style: TextStyle(fontSize: 20,
                                        fontWeight: FontWeight.bold)),
                                SizedBox(height: 16),
                                Visibility(
                                  visible: _secondshow,
                                  child: Text(
                                      "${_seconddataCity.numberOfJobs}",
                                      textAlign: TextAlign.center,
                                      style: TextStyle(fontSize: 18,
                                          fontWeight: FontWeight.bold)),
                                ),
                              ],
                            ),
                          ),
                            _firstgridCard("Mean Software Developer Salary (Adjusted)", "${_dataCity
                                .adjustedSalary}"),
                            _secondgridCard("Mean Software Developer Salary (Adjusted)", "${_seconddataCity
                                .adjustedSalary}"),
                            _firstgridCard("Mean Software Developer Salary (Unadjusted)", "${_dataCity
                                .adjustedSalary}"),
                            _secondgridCard("Mean Software Developer Salary (Unadjusted)", "${_seconddataCity
                                .adjustedSalary}"),
                            _firstgridCard("Mean Unadjusted Salary for All Occupations", "${_dataCity
                                .unadjustedAll}"),
                            _secondgridCard("Mean Unadjusted Salary for All Occupations", "${_seconddataCity
                                .unadjustedAll}"),
                          ],
                        ),
                      );
                    }
                )
              ],
            )
        )
    );
  }

  Widget _firstgridCard(String title, String data){
    return Card(
      color: Colors.green[300],
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(title,
              textAlign: TextAlign.center,
              style: TextStyle(fontSize: 20,
                  fontWeight: FontWeight.bold)),
          SizedBox(height: 16),
          Visibility(
            visible: _show,
            child: Text(
                "\$" + data,
                textAlign: TextAlign.center,
                style: TextStyle(fontSize: 18,
                    fontWeight: FontWeight.bold)),
          ),
        ],
      ),
    );
  }
  Widget _secondgridCard(String title, String data){
    return Card(
      color: Colors.green[300],
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(title,
              textAlign: TextAlign.center,
              style: TextStyle(fontSize: 20,
                  fontWeight: FontWeight.bold)),
          SizedBox(height: 16),
          Visibility(
            visible: _secondshow,
            child: Text(
                "\$" + data,
                textAlign: TextAlign.center,
                style: TextStyle(fontSize: 18,
                    fontWeight: FontWeight.bold)),
          ),
        ],
      ),
    );
  }

  Widget _FirstSearchBar(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Padding(
          padding: const EdgeInsets.only(top: 20, right: 30, left: 30, bottom: 20),
          child: Form(
            key: _firstFormKey,
            child: SearchField(
              searchInputDecoration: const InputDecoration(
                enabledBorder: OutlineInputBorder(
                    borderSide: BorderSide(color: Colors.grey, width: 2)),
                focusedBorder: OutlineInputBorder(
                    borderSide: BorderSide(color: Colors.grey, width: 2)),
              ),
              hint: "Enter First City",
              focusNode: _focus,
              controller: _searchController,
              maxSuggestionsInViewPort: 6,
              inputType: TextInputType.text,
              itemHeight: 50,
              onSuggestionTap: (value) {
                setState(() {
                  _selectedCity = _searchController.text;
                });
                _show = true;
                _firstFormKey.currentState?.validate();
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

  Widget _SecondSearchBar(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Padding(
          padding: const EdgeInsets.only(top: 20, right: 30, left: 30, bottom: 50),
          child: Form(
            key: _secondFormKey,
            child: SearchField(
              searchInputDecoration: const InputDecoration(
                enabledBorder: OutlineInputBorder(
                    borderSide: BorderSide(color: Colors.grey, width: 2)),
                focusedBorder: OutlineInputBorder(
                    borderSide: BorderSide(color: Colors.grey, width: 2)),
              ),
              hint: "Enter Second City",
              focusNode: _secondfocus,
              controller: _secondsearchController,
              maxSuggestionsInViewPort: 6,
              inputType: TextInputType.text,
              itemHeight: 50,
              onSuggestionTap: (value) {
                setState(() {
                  _secondselectedCity = _secondsearchController.text;
                });
                _secondshow = true;
                _secondFormKey.currentState?.validate();
                _secondfocus.unfocus();
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

    DocumentSnapshot<Map<String, dynamic>> secondsnapshot = await FirebaseFirestore.instance
        .collection('CityData').doc(_secondselectedCity).get();

    _dataCity = City(snapshot["city"], snapshot["numberOfSoftwareDeveloperJobs"],
        snapshot["meanSoftwareDeveloperSalaryAdjusted"],
        snapshot["meanSoftwareDeveloperSalaryUnadjusted"], snapshot["meanUnadjustedSalaryAllOccupations"]);

    _seconddataCity = City(secondsnapshot["city"], secondsnapshot["numberOfSoftwareDeveloperJobs"],
        secondsnapshot["meanSoftwareDeveloperSalaryAdjusted"],
        secondsnapshot["meanSoftwareDeveloperSalaryUnadjusted"], secondsnapshot["meanUnadjustedSalaryAllOccupations"]);
  }
}

class City {
  final String name;
  final dynamic numberOfJobs;
  final dynamic adjustedSalary;
  final dynamic unadjustedSalary;
  final dynamic unadjustedAll;


  City(this.name, this.numberOfJobs, this.adjustedSalary,
      this.unadjustedSalary, this.unadjustedAll);
}

