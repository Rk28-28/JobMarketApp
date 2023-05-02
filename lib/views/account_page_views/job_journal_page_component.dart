import 'dart:ui';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class JobJournalPage extends StatefulWidget {
  const JobJournalPage({Key? key}) : super(key: key);

  @override
  _JobJournalPageState createState() => _JobJournalPageState();
}

double sliderValue = 1;
TextEditingController companyController = new TextEditingController();
TextEditingController dateController = new TextEditingController();
TextEditingController timeController = new TextEditingController();
TextEditingController responseController = new TextEditingController();

class _JobJournalPageState extends State<JobJournalPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.brown[100],
      resizeToAvoidBottomInset: false,
      appBar: AppBar(
        backgroundColor: Colors.green[400],
        title: Text('My Interview Journal'),
      ),
      body: Container(
        width: double.infinity,
        height: double.infinity,
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            children: <Widget>[
              const Padding(
                padding: EdgeInsets.fromLTRB(8, 16, 8, 8),
                child: Text('What job/company were you interviewed for?',
                    style:
                        TextStyle(fontSize: 18.0, fontWeight: FontWeight.bold)),
              ),
              Padding(
                padding: EdgeInsets.fromLTRB(8, 8, 8, 16),
                child: TextFormField(
                  controller: companyController,
                  decoration: InputDecoration(
                    filled: true,
                    fillColor: Colors.white.withOpacity(0.3),
                    border: OutlineInputBorder(),
                  ),
                ),
              ),
              const Padding(
                padding: EdgeInsets.fromLTRB(8, 16, 8, 8),
                child: Text(
                  'What day was your interview?',
                  style: TextStyle(fontSize: 18.0, fontWeight: FontWeight.bold),
                ),
              ),
              Center(
                  //Text box for typing in a date
                  child: TextField(
                      controller: dateController,
                      //editing controller of this TextField
                      decoration: InputDecoration(
                        //contentPadding: EdgeInsets.symmetric(vertical: 15.0, horizontal: 10.0),
                        icon: const Icon(
                          Icons.calendar_today,
                          color: Colors.black,
                        ),
                        //icon of text field
                        filled: true,
                        fillColor: Colors.brown[50],
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
                            lastDate: DateTime.now());
                        if (pickedDate != null) {
                          String formattedDate = DateFormat('yyyy-MM-dd').format(
                              pickedDate); // format date in required form here we use yyyy-MM-dd that means time is removed
                          setState(() {
                            dateController.text =
                                formattedDate; //set formatted date to TextField value.
                          });
                        }
                      })),
              Padding(
                padding: const EdgeInsets.fromLTRB(8, 16, 8, 8),
                child: Text(
                  'What time was your interview?',
                  style: TextStyle(
                    fontSize: 18.0,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              Container(
                child: TextField(
                    controller: timeController,
                    //editing controller of this TextField
                    decoration: InputDecoration(
                      icon: const Icon(Icons.access_time, color: Colors.black),
                      //icon of text field
                      filled: true,
                      fillColor: Colors.brown[50],
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
                          timeController.text =
                              newTime.toString().substring(10, 15);
                        });
                      }
                    }),
              ),
              const Padding(
                padding: EdgeInsets.fromLTRB(8, 16, 8, 8),
                child: Text(
                  'Describe how your interview went:',
                  style: TextStyle(fontSize: 18.0, fontWeight: FontWeight.bold),
                ),
              ),
              Padding(
                padding: EdgeInsets.fromLTRB(8, 8, 8, 16),
                child: TextFormField(
                  controller: responseController,
                  decoration: InputDecoration(
                    filled: true,
                    fillColor: Colors.white.withOpacity(0.3),
                    border: OutlineInputBorder(),
                  ),
                ),
              ),
              const Padding(
                  padding: EdgeInsets.fromLTRB(8, 16, 8, 8),
                  child: Text(
                    'How would you rate your interview?',
                    style:
                        TextStyle(fontSize: 18.0, fontWeight: FontWeight.bold),
                  )),
              Slider(
                value: sliderValue,
                min: 1,
                max: 5,
                activeColor: Colors.green,
                inactiveColor: Colors.green[300],
                divisions: 4,
                label: sliderValue.round().toString(),
                onChanged: (double value) {
                  setState(() {
                    sliderValue = value;
                  });
                },
              ),

              Padding(
                padding: EdgeInsets.fromLTRB(8, 4, 16, 4),
                child: Row(
                  //Contains text for slider
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [Text('Terrible'), Text('Fantastic')],
                ),
              ),
              _space,
              Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                  children: [SizedBox(
                    height: 40,
                    child:
                    Image.asset('assets/reverseBee.png')
                  ),
                  SizedBox(
                    height: 60,
                    child:
                    Image.asset('assets/reverseLine.png')
                  ),
                  ]

              ),
              Flexible(
                child: Align(
                    alignment: Alignment.bottomCenter,
                    child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.green),
                      onPressed: () {
                        sendToDatabase(
                            companyController.text.toString(),
                            dateController.text.toString(),
                            timeController.text.toString(),
                            responseController.text.toString(),
                            sliderValue);
                        ScaffoldMessenger.of(context).showSnackBar(
                            const SnackBar(
                                content: Text('Processing Data',
                                    style: TextStyle(color: Colors.white))));
                      },
                      child: const Text('Enter',
                          style:
                              TextStyle(fontSize: 18.0, color: Colors.black)),
                    )),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

Future<void> sendToDatabase(String jobStr, String dateStr, String timeStr,
    String feedbackStr, double interviewValue) async {
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
    'Company/Job': jobStr,
    'Date of Interview': dateStr,
    'Time of Interview': timeStr,
    'Summary of Interview': feedbackStr,
    'Interview Rating': interviewValue
  });
}

Widget get _space => const SizedBox(height: 50);
