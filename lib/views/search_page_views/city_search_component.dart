import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:syncfusion_flutter_charts/sparkcharts.dart';
//test



class CitySearchPage extends StatefulWidget {
  const CitySearchPage({Key? key}) : super(key: key);

  @override
  _CitySearchPageState createState() => _CitySearchPageState();
}

class _CitySearchPageState extends State<CitySearchPage> {
  /*int jobCountRank = 0;
  int adjustedRank = 0;
  int unadjustedRank = 0;*/

  String? dropdownValue;
  var CityPicked;


 /* late List<rankData> data = [
    rankData(xval: 'SD Job Count', yval: 0),
    rankData(xval: 'Adjusted Salary', yval: 0),
    rankData(xval: 'Unadjusted Salary', yval: 0),

  ];*/

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
      body: Column(
      /*GridView.count(
          crossAxisCount: 1,
        childAspectRatio: 1.5,
        mainAxisSpacing: 16,
        crossAxisSpacing: 16,*/
          children: [
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
                        style: TextStyle(fontSize: 18, color: Colors.black),
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
           //_chart()
          ],
        ),
      );
  }


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

      /*setState(() {
        countnumjobs = jobCountRank;
        countadjustedsalary = adjustedRank;
        countunadjustedsalary = unadjustedRank;
        data[0].yval = jobCountRank;
        data[1].yval = adjustedRank;
        data[2].yval = unadjustedRank;
      });*/
              }
            );

    }
  if(x != "")
  {
    x += " Software Developer Job Count Ranking: " +
        countnumjobs.toString() + ' of 77 \n\n';
    x += " Adjusted Mean Salary Ranking: " + countadjustedsalary.toString() +
        ' of 77 \n\n';
    x +=
        " Unadjusted Mean Salary Ranking: " + countunadjustedsalary.toString() +
            ' of 77 \n\n';
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


}


class rankData {
  rankData({required this.xval, required this.yval});
  final String xval;
  late int yval;
}



