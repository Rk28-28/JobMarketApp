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
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [

              const Padding( //Text that displays "Enter a Date"
                padding: EdgeInsets.fromLTRB(8,16,8,8),
                child: Text(("Enter a Date for your Interview:"),
                    style: TextStyle(fontSize: 16.0), textAlign: TextAlign.center),
              ),


              TextField(
                  controller: timeController, //editing controller of this TextField
                  style: TextStyle(color: Colors.black),
                  decoration: const InputDecoration(
                    icon: Icon(Icons.calendar_today), //icon of text field
                    filled: true,
                    fillColor: Colors.grey,
                  ),

                  readOnly: true,
                  onTap: () async {
                    //when click we have to show the datepicker
                    DateTime? pickedDate = await showDatePicker(
                        context: context,
                        initialDate: DateTime.now(), //get today's date
                        firstDate:DateTime.now(),
                        lastDate: DateTime(2023));
                    if(pickedDate != null ){
                      String formattedDate = DateFormat('yyyy-MM-dd').format(pickedDate); // format date in required form here we use yyyy-MM-dd that means time is removed
                      setState(() {
                        sendDateController.text = formattedDate; //set formatted date to TextField value.
                      });
                    }
                  }
              ),
              Padding(
                padding: EdgeInsets.fromLTRB(8,8,8,16),
                child: TextFormField(
                  controller: timeController,

                  decoration: InputDecoration(
                    filled: true,
                    fillColor: Colors.white.withOpacity(0.3),
                    border: OutlineInputBorder(),
                    hintText: 'Enter the time of the interview',
                  ),
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

              TextField(
                  controller: retrieveDateController, //editing controller of this TextField
                  style: TextStyle(color: Colors.black),
                  decoration: const InputDecoration(
                    icon: Icon(Icons.calendar_today), //icon of text field
                    filled: true,
                    fillColor: Colors.grey,
                  ),

                  readOnly: true,
                  onTap: () async {
                    //when click we have to show the datepicker
                    DateTime? pickedDate = await showDatePicker(
                        context: context,
                        initialDate: DateTime.now(), //get today's date
                        firstDate:DateTime.now(),
                        lastDate: DateTime(2023));
                    if(pickedDate != null ){
                      String formattedDate = DateFormat('yyyy-MM-dd').format(pickedDate); // format date in required form here we use yyyy-MM-dd that means time is removed
                      setState(() {
                        retrieveDateController.text = formattedDate; //set formatted date to TextField value.
                      });
                    }//
                  }
              ),
            ],
          ),
        ),
      ),


      );
    }
  }