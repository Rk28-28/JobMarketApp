import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
//test
class CitySearchPage extends StatefulWidget {
  const CitySearchPage({Key? key}) : super(key: key);

  @override
  _CitySearchPageState createState() => _CitySearchPageState();
}

class _CitySearchPageState extends State<CitySearchPage> {


  String? dropdownValue;
  var CityPicked;



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
        appBar: AppBar(
          title: Text('Search for Jobs Based on City'),
        ),
        body: Container(
          child:Column(
          children:[
            DropdownButton(
                hint: Text("Select A City"),
                value: CityPicked,
                alignment: AlignmentDirectional.center,
                items: Cities.map<DropdownMenuItem<String>>((String value) {
                  return DropdownMenuItem<String>(
                    value: value,
                    child: Text(value),
                  );
                }).toList(),
                onChanged: (value) {
                  setState(() {
                    CityPicked = value;
                  });
                }),

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
                      style: TextStyle(fontSize: 14.4,color: Colors.black),
                    ),
                  );
                }
              }

              // Displaying LoadingSpinner to indicate waiting state
              return Center(
                child: CircularProgressIndicator(),
              );
            },

            // Future that needs to be resolved
            // inorder to display something on the Canvas
            future: getdata(CityPicked),
          ),
    ],
        ),
        ),
    );
  }

}
Future<String> getdata(cityPicked) async {

  DocumentReference<Map<String, dynamic>> diaryRef = FirebaseFirestore
      .instance
      .collection('CityData')
      .doc(cityPicked);

  String x = "";
  await diaryRef.get().then(
          (querySnapshot) {
        print("Successfully completed");
        x += "Number Of Software Developer Jobs: "+ querySnapshot.get('numberOfSoftwareDeveloperJobs').toString() + '\n';
        x += "Software Developer Adjusted Salary Mean: "+ querySnapshot.get('meanSoftwareDeveloperSalaryAdjusted').toString() + '\n';
        x += "Software Developer Unadjusted Salary Mean: "+ querySnapshot.get('meanSoftwareDeveloperSalaryUnadjusted').toString() + '\n';
       // x += querySnapshot.data().toString();
        //print(x);
      }
  );
  //print("Outside of Loop"+ x);
  return x;
}



