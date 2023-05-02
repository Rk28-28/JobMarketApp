import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:searchfield/searchfield.dart';
import 'package:syncfusion_flutter_charts/sparkcharts.dart';

import '../utils/cities_list.dart';
//test



class CitySearchPage extends StatefulWidget {
  const CitySearchPage({Key? key}) : super(key: key);

  @override
  _CitySearchPageState createState() => _CitySearchPageState();
}

class _CitySearchPageState extends State<CitySearchPage> {

  String? dropdownValue;
  dynamic _selectedCity;
  City _dataCity = City("Selected City", 0, 0, 0);
  final _searchController = TextEditingController();
  bool _show = false;
  final _formKey = GlobalKey<FormState>();
  final _focus = FocusNode();

  @override
  void dispose() {
    _searchController.dispose();
    _focus.dispose();
    super.dispose();
  }

  List<String> Cities = [
    'Akron, OH',
    'Albany, NY',
    'Albuquerque, NM',
    'Ann Arbor, MI',
    'Atlanta, GA',
    'Austin, TX',
    'Baltimore, MD',
    'Birmingham, AL',
    'Boise, ID',
    'Boston, MA',
    'Buffalo, NY',
    'Charleston, SC',
    'Charlotte, NC',
    'Chicago, IL',
    'Cincinnati, OH',
    'Cleveland, OH',
    'Colorado Springs, CO',
    'Columbus, OH',
    'Dallas, TX',
    'Dayton, OH',
    'Denver, CO',
    'Des Moines, IA',
    'Detroit, MI',
    'Durham, NC',
    'Eugene, OR',
    'Fort Collins, CO',
    'Fort Lauderdale, FL',
    'Fort Worth, TX',
    'Greensboro, NC',
    'Honolulu, HI',
    'Houston, TX',
    'Indianapolis, IN',
    'Jacksonville, FL',
    'Jersey City, NJ',
    'Kansas City, MO',
    'Las Vegas, NV',
    'Lexington, KY',
    'Little Rock, AR',
    'Long Beach, CA',
    'Los Angeles, CA',
    'Louisville, KY',
    'Madison, WI',
    'Memphis, TN',
    'Mesa, AZ',
    'Miami, FL',
    'Milwaukee, WI',
    'Minneapolis, MN',
    'Nashville, TN',
    'New York, NY',
    'Oakland, CA',
    'Oklahoma City, OK',
    'Omaha, NE',
    'Orlando, FL',
    'Philadelphia, PA',
    'Phoenix, AZ',
    'Pittsburgh, PA',
    'Portland, OR',
    'Raleigh, NC',
    'Richmond, VA',
    'Rochester, NY',
    'Sacramento, CA',
    'Salt Lake City, UT',
    'San Antonio, TX',
    'San Diego, CA',
    'San Francisco, CA',
    'San Jose, CA',
    'Santa Barbara, CA',
    'Santa Clara, CA',
    'Seattle, WA',
    'Spokane, WA',
    'Syracuse, NY',
    'Tampa, FL',
    'Tucson, AZ',
    'Tulsa, OK',
    'Vancouver, WA',
    'Washington, DC',
    'Wichita, KS',
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.brown[100],
      body: Column(
      /*GridView.count(
          crossAxisCount: 1,
        childAspectRatio: 1.5,
        mainAxisSpacing: 16,
        crossAxisSpacing: 16,*/
          children: [
            _searchBar(context),
            /*DropdownButton(
                hint: Text("Select A City"),
                value: _selectedCity,
                alignment: AlignmentDirectional.center,
                items: Cities.map<DropdownMenuItem<String>>((String value) {
                  return DropdownMenuItem<String>(
                    value: value,
                    child: Text(value),
                  );
                }).toList(),
                onChanged: (value) {
                  setState(() {
                    _selectedCity = value;
                  });
                }),*/
           FutureBuilder(
              builder: (ctx, snapshot) {
                // Checking if future is resolved or not
                if (snapshot.connectionState == ConnectionState.done) {
                  // If we got an error
                  if (snapshot.hasError) {
                    return Center(
                      child: Text(
                        '${snapshot.error} occurred',
                        style: TextStyle(fontSize: 19),
                      ),
                    );

                    // if we got our data
                  } else if (snapshot.hasData) {
                    // Extracting data from snapshot object
                    final data = snapshot.data as String;
                    //print("Data" + data);

                    return Align(
                      alignment: Alignment.topLeft,
                      child: Text(
                        data,
                        style: TextStyle(fontSize: 18, color: Colors.black),
                      ),
                    );
                  }
                }

                // Displaying LoadingSpinner to indicate waiting state
                return const SizedBox(height: 0);
              },

              // Future that needs to be resolved
              // inorder to display something on the Canvas
              future: getdata(_selectedCity),
            ),
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
                        _gridCard("Mean Software Developer Salary (Adjusted)", "${_dataCity
                            .adjustedSalary}"),
                        _gridCard("Mean Software Developer Salary (Unadjusted)", "${_dataCity
                            .unadjustedSalary}"),
                        _rankgridCard("Software Developer Job Count Ranking", jobCountRank),
                        _rankgridCard("Adjusted Mean Salary Ranking", adjustedRank),
                        _rankgridCard("Unadjusted Mean Salary Ranking", unadjustedRank),
                      ],
                    ),
                  );
                }
            ),
          ],
        ),
      );
  }


  Widget _rankgridCard(String title, String data) {
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
            child: Text(data,
                textAlign: TextAlign.center,
                style: TextStyle(fontSize: 18,
                    fontWeight: FontWeight.bold)),
          ),
        ],
      ),
    );
  }

  Widget _gridCard(String title, String data){
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

  Widget _searchBar(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Padding(
          padding: const EdgeInsets.only(top: 20, right: 30, left: 30, bottom: 50),
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
                  _selectedCity = _searchController.text;
                });
                _show = true;
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
  String jobCountRank = '';
  String unadjustedRank = '';
  String adjustedRank = '';

  Future<String> getdata(cityPicked) async {
    DocumentReference<Map<String, dynamic>> diaryRef = FirebaseFirestore
        .instance
        .collection('CityData')
        .doc(cityPicked);

    String x = "";

    int numjobs=0;
    int adjustedsalary = 0;
    int unadjustedsalary = 0;
    await diaryRef.get().then(
            (querySnapshot) {
          print("Successfully completed");
          if (querySnapshot.data() != null) {
            numjobs = querySnapshot.get('numberOfSoftwareDeveloperJobs');
            adjustedsalary =
                querySnapshot.get('meanSoftwareDeveloperSalaryAdjusted');
            unadjustedsalary =
                querySnapshot.get('meanSoftwareDeveloperSalaryUnadjusted');

            x += '\n\n'+" Number Of Software Developer Jobs: " +
                querySnapshot.get('numberOfSoftwareDeveloperJobs').toString() +
                '\n\n';
            x += " Adjusted Mean Salary: \$" +
                querySnapshot.get('meanSoftwareDeveloperSalaryAdjusted')
                    .toString() + '\n\n';
            x += " Unadjusted Mean Salary: \$" +
                querySnapshot.get('meanSoftwareDeveloperSalaryUnadjusted')
                    .toString() + '\n\n\n\n\n\n\n\n';
          }
          else {
            x = "";
          }


          // x += querySnapshot.data().toString();
          //print(x);
        }
    );
          // x += querySnapshot.data().toString();
          //print(x);
    int countnumjobs = 1;
    int countadjustedsalary = 1;
    int countunadjustedsalary = 1;

    for (int i = 0; i < Cities.length;++i)
    {
      DocumentReference<Map<String, dynamic>> ref = FirebaseFirestore
          .instance
          .collection('CityData')
          .doc(Cities[i]);

      await ref.get().then(
              (querySnapshot) {
            print("Successfully completed");
              //Has more jobs than countnumjobs cities
              if((querySnapshot.get('numberOfSoftwareDeveloperJobs')) >= numjobs)
                {
                  ++countnumjobs;
                }
              if((querySnapshot.get('meanSoftwareDeveloperSalaryAdjusted')) >= adjustedsalary)
                {
                ++countadjustedsalary;
                }
              if((querySnapshot.get('meanSoftwareDeveloperSalaryUnadjusted')) >= unadjustedsalary)
                {
               ++countunadjustedsalary;
                }

              }
            );

    }
  if(x != "")
  {
    setState(() {
      jobCountRank = countnumjobs.toString() + ' of 77 \n\n';
      adjustedRank = countadjustedsalary.toString() +
          ' of 77 \n\n';
      unadjustedRank = countunadjustedsalary.toString() +
              ' of 77 \n\n';
    });
  }
    //print("Outside of Loop"+ x);
    return x;
  }

  /*Widget _chart() {
    return SfSparkAreaChart.custom(
      labelDisplayMode: SparkChartLabelDisplayMode.all,
        dataCount: 3,
        xValueMapper: (index) => data[index].xval,
        yValueMapper: (index) => data[index].yval
    );
  }*/


  Future<void> getCityInformation() async {
    DocumentSnapshot<Map<String, dynamic>> snapshot = await FirebaseFirestore.instance
        .collection('CityData').doc(_selectedCity).get();


    _dataCity = City(snapshot["city"], snapshot["numberOfSoftwareDeveloperJobs"],
        snapshot["meanSoftwareDeveloperSalaryAdjusted"],
        snapshot["meanSoftwareDeveloperSalaryUnadjusted"]);

    }

}

class City {
  final String name;
  final dynamic numberOfJobs;
  final dynamic adjustedSalary;
  final dynamic unadjustedSalary;


  City(this.name, this.numberOfJobs, this.adjustedSalary,
      this.unadjustedSalary);
}




