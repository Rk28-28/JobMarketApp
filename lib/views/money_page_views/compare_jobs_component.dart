import 'package:flutter/material.dart';


class CompareJobPage extends StatefulWidget {
  const CompareJobPage({Key? key}) : super(key: key);

  @override
  _CompareJobPageState createState() => _CompareJobPageState();
}

class _CompareJobPageState extends State<CompareJobPage> {
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
      body: Container(
          child: Row(
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
        ],
      ),
      )
    );
  }
}