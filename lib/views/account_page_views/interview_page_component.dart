import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class InterviewPage extends StatefulWidget {
  const InterviewPage({Key? key}) : super(key: key);

  @override
  _InterviewPageState createState() => _InterviewPageState();
}

TextEditingController sendDateController = new TextEditingController();
TextEditingController retrieveDateController = new TextEditingController();
TextEditingController sendTimeController = new TextEditingController();
TextEditingController retrieveTimeController = new TextEditingController();
TextEditingController dataController = new TextEditingController();
Future<String> str = "" as Future<String>;

class _InterviewPageState extends State<InterviewPage> {
  @override
  Widget build(BuildContext context) {
    bool buttonpressed = false;
    return Scaffold(
      backgroundColor: Colors.brown[100],
      appBar: AppBar(
        backgroundColor: Colors.green[400],
        title: Text('Set/View Interviews'),
      ),
      body: Container(
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: <Widget>[
              const Padding(
                //Text that displays "Enter a Date"
                padding: EdgeInsets.fromLTRB(8, 16, 8, 8),
                child: Text(("Schedule a New Interview:"),
                    style:
                        TextStyle(fontSize: 16.0, fontWeight: FontWeight.bold),
                    textAlign: TextAlign.center),
              ),
              Container(
                  //Text box for typing in a date

                  child: TextField(
                      controller: sendDateController,
                      //editing controller of this TextField
                      decoration: InputDecoration(
                        icon: Icon(Icons.calendar_today), //icon of text field
                        filled: true,
                        fillColor: Colors.brown[50],
                        hintText: "Enter date",
                      ),
                      readOnly: true,
                      onTap: () async {
                        //when click we have to show the datepicker
                        DateTime? pickedDate = await showDatePicker(
                            context: context,
                            initialDate: DateTime.now(),
                            //get today's date
                            firstDate: DateTime.now(),
                            //DateTime.now() - not to allow to choose before today.
                            lastDate: DateTime(2100));
                        if (pickedDate != null) {
                          String formattedDate = DateFormat('yyyy-MM-dd').format(
                              pickedDate); // format date in required form here we use yyyy-MM-dd that means time is removed
                          setState(() {
                            sendDateController.text =
                                formattedDate; //set formatted date to TextField value.
                          });
                        }
                      })),
              Container(
                child: TextField(
                    controller: sendTimeController,
                    //editing controller of this TextField
                    decoration: InputDecoration(
                      icon: const Icon(Icons.access_time), //icon of text field
                      filled: true,
                      fillColor: Colors.brown[50],
                      hintText: "Enter time",
                    ),
                    readOnly: true,
                    onTap: () async {
                      TimeOfDay _time = TimeOfDay(hour: 12, minute: 00);

                      final TimeOfDay? newTime = await showTimePicker(
                        context: context,
                        initialTime: _time,
                      );
                      if (newTime != null) {
                        setState(() {
                          sendTimeController.text =
                              newTime.toString().substring(10, 15);
                        });
                      }
                    }),
              ),
              SizedBox(height: 10),
              ElevatedButton(
                style: ButtonStyle(
                  backgroundColor: MaterialStateProperty.all(Colors.green[300]),
                  minimumSize: MaterialStateProperty.all(Size(
                      100, 45)), // specify the minimum width and height here
                ),
                onPressed: () {
                  // Send Date to Database
                  sendToDatabase(sendDateController.text.toString(),
                      sendTimeController.text.toString());
                  ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
                      content: Text('Processing Data',
                          style: TextStyle(color: Colors.white))));
                },
                child: const Text(
                  'Set Interview Date/Time',
                  style: TextStyle(color: Colors.black),
                ),
              ),
              const Padding(
                //Text that displays "Enter a Date"
                padding: EdgeInsets.fromLTRB(8, 64, 8, 8),
                child: Text(("Retrieve Interview Info:"),
                    style:
                        TextStyle(fontSize: 16.0, fontWeight: FontWeight.bold),
                    textAlign: TextAlign.center),
              ),
              Container(
                  //Text box for typing in a date

                  child: TextField(
                      controller: retrieveDateController,
                      //editing controller of this TextField
                      decoration: InputDecoration(
                        icon: const Icon(Icons.calendar_today),
                        //icon of text field
                        filled: true,
                        fillColor: Colors.brown[50],
                        hintText: "Enter date",
                      ),
                      readOnly: true,
                      onTap: () async {
                        //when click we have to show the datepicker
                        DateTime? pickedDate = await showDatePicker(
                            context: context,
                            initialDate: DateTime.now(),
                            //get today's date
                            firstDate: DateTime(2023),
                            //DateTime.now() - not to allow to choose before today.
                            lastDate: DateTime(2100)); //t
                        if (pickedDate != null) {
                          String formattedDate = DateFormat('yyyy-MM-dd').format(
                              pickedDate); // format date in required form here we use yyyy-MM-dd that means time is removed
                          setState(() {
                            retrieveDateController.text =
                                formattedDate; //set formatted date to TextField value.
                          });
                        }
                      })),
              Container(
                child: TextField(
                    controller: retrieveTimeController,
                    //editing controller of this TextField
                    decoration: InputDecoration(
                      icon: const Icon(Icons.access_time), //icon of text field
                      filled: true,
                      fillColor: Colors.brown[50],
                      hintText: "Enter time",
                    ),
                    readOnly: true,
                    onTap: () async {
                      TimeOfDay _time = TimeOfDay(hour: 12, minute: 00);

                      final TimeOfDay? newTime = await showTimePicker(
                        context: context,
                        initialTime: _time,
                      );
                      if (newTime != null) {
                        setState(() {
                          retrieveTimeController.text =
                              newTime.toString().substring(10, 15);
                        });
                      }
                    }),
              ),
              SizedBox(height: 10),
              FutureBuilder(
                  builder: (ctx, snapshot) {
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

                        String singleline = data.replaceAll(",", "\n");

                        print("Data :" + data);
                        //String x = loop(getdata());
                        return Align(
                          alignment: Alignment.topLeft,
                          child: Text(
                            singleline,
                            style:
                                TextStyle(fontSize: 14.4, color: Colors.black),
                          ),
                        );
                      }
                    }

                    // Displaying LoadingSpinner to indicate waiting state
                    return Center(
                      child: CircularProgressIndicator(),
                    );
                  },
                  future: retrieveData(retrieveDateController.text.toString(),
                      retrieveTimeController.text.toString())),
            ],
          ),
        ),
      ),
    );
  }
}

Future<void> sendToDatabase(String dateStr, String timeStr) async {
  FirebaseAuth auth = FirebaseAuth.instance;
  final User? user = auth.currentUser;
  final uid = user?.uid;

  DocumentReference<Map<String, dynamic>> interviewJournalRef =
      FirebaseFirestore.instance
          .collection('users')
          .doc(auth.currentUser?.uid)
          .collection(dateStr)
          .doc(timeStr);

  interviewJournalRef.set({
    'Date of Interview': dateStr,
    'Time of Interview': timeStr,
  });
}

Future<String> retrieveData(String dateStr, String timeStr) async {
  FirebaseAuth auth = FirebaseAuth.instance;
  final User? user = auth.currentUser;
  final uid = user?.uid;
  String str = "\n";

  if (dateStr.isEmpty && timeStr.isEmpty) {
    str += "Please Choose a Date and a Time";
  } else if (timeStr.isEmpty) {
    str += "Please Choose a Time";
  } else if (dateStr.isEmpty) {
    str += "Please Choose a Date";
  } else {
    DocumentReference<Map<String, dynamic>> interviewJournalRef =
        FirebaseFirestore.instance
            .collection('users')
            .doc(auth.currentUser?.uid)
            .collection(dateStr)
            .doc(timeStr);

    await interviewJournalRef.get().then((querySnapshot) {
      print("Successfully completed");
      if (querySnapshot.data().toString() == "null") {
        str += "No Data";
      } else {
        str += " " +
            querySnapshot
                .data()
                .toString()
                .substring(1, querySnapshot.data().toString().length - 1);
      }
    });
  }

  return str;
}
