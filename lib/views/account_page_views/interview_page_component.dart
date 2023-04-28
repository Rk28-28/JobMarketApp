import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class InterviewPage extends StatefulWidget {
    const InterviewPage({Key? key}) : super(key: key);

    @override
    _InterviewPageState createState() => _InterviewPageState();
}

TextEditingController sendDateController = new TextEditingController();
TextEditingController retrieveDateController = new TextEditingController();
TextEditingController timeController = new TextEditingController();
class _InterviewPageState extends State<InterviewPage> {

@override
Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
        title: Text('Set/View Interviews'),
        ),

      body: Container(
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Column(
            mainAxisSize: MainAxisSize.min,

            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: <Widget>[

              const Padding( //Text that displays "Enter a Date"
                padding: EdgeInsets.fromLTRB(8,16,8,8),
                child: Text(("Schedule a New Interview:"),
                    style: TextStyle(fontSize: 16.0), textAlign: TextAlign.center),
              ),

              Container( //Text box for typing in a date

                  child: TextField(
                      controller: sendDateController, //editing controller of this TextField
                      style: TextStyle(color: Colors.white),
                      decoration: const InputDecoration(
                        icon: Icon(Icons.calendar_today), //icon of text field
                        filled: true,
                        fillColor: Colors.white70,
                        hintText: "Enter date",
                      ),

                      readOnly: true,
                      onTap: () async {
                        //when click we have to show the datepicker
                        DateTime? pickedDate = await showDatePicker(
                            context: context,
                            initialDate: DateTime.now(), //get today's date
                            firstDate:DateTime.now(), //DateTime.now() - not to allow to choose before today.
                            lastDate: DateTime(2100));
                        if(pickedDate != null ){
                          String formattedDate = DateFormat('yyyy-MM-dd').format(pickedDate); // format date in required form here we use yyyy-MM-dd that means time is removed
                          setState(() {
                            sendDateController.text = formattedDate; //set formatted date to TextField value.
                          });
                        }
                      }
                  )
              ),



              Container(
                child: TextField(
                    controller: timeController, //editing controller of this TextField
                    decoration: const InputDecoration(
                      icon: Icon(Icons.access_time), //icon of text field
                      filled: true,
                      fillColor: Colors.white70,
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
                          timeController.text = newTime.toString();
                        });
                      }

                    }
                ),


              ),

              ElevatedButton(
                onPressed: () { // Send Date to Database
                },
                child: Text('Set Interview Date/Time'),
              ),



              const Padding( //Text that displays "Enter a Date"
                padding: EdgeInsets.fromLTRB(8,64,8,8),
                child: Text(("Retrieve Interview Info:"),
                    style: TextStyle(fontSize: 16.0), textAlign: TextAlign.center),
              ),
              Container( //Text box for typing in a date

                  child: TextField(
                      controller: retrieveDateController, //editing controller of this TextField
                      style: TextStyle(color: Colors.white),
                      decoration: const InputDecoration(
                        icon: Icon(Icons.calendar_today), //icon of text field
                        filled: true,
                        fillColor: Colors.white70,
                        hintText: "Enter date",
                      ),

                      readOnly: true,
                      onTap: () async {
                        //when click we have to show the datepicker
                        DateTime? pickedDate = await showDatePicker(
                            context: context,
                            initialDate: DateTime.now(), //get today's date
                            firstDate:DateTime.now(), //DateTime.now() - not to allow to choose before today.
                            lastDate: DateTime(2100));
                        if(pickedDate != null ){
                          String formattedDate = DateFormat('yyyy-MM-dd').format(pickedDate); // format date in required form here we use yyyy-MM-dd that means time is removed
                          setState(() {
                            retrieveDateController.text = formattedDate; //set formatted date to TextField value.
                          });
                        }
                      }
                  )
              ),

              Container(
                child: TextField(
                    controller: timeController, //editing controller of this TextField
                    decoration: const InputDecoration(
                      icon: Icon(Icons.access_time), //icon of text field
                      filled: true,
                      fillColor: Colors.white70,
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
                          timeController.text = newTime.toString();
                        });
                      }

                    }
                ),


              ),

              ElevatedButton(
                onPressed: () { // Send Date to Database
                },
                child: Text('Retrieve Interview Info'),
              ),
            ],
          ),
        ),
      ),


      );
    }
  }