import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:english_words/english_words.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:intl/intl.dart';

class CareerGoalPage extends StatefulWidget {
  const CareerGoalPage({Key? key}) : super(key: key);

  @override
  _CareerGoalPageState createState() => _CareerGoalPageState();
}

class _CareerGoalPageState extends State<CareerGoalPage> {
  /*DatabaseReference dbRef = FirebaseDatabase.instance.ref('liked');
  final _suggestions = <WordPair>[];
  var _saved = <WordPair>{};
  final _biggerFont = const TextStyle(fontSize: 18.0);*/

  int _termValue = -1;
  final goal = TextEditingController();
  int _progressionValue = -1;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        resizeToAvoidBottomInset: false,
        backgroundColor: Colors.brown[100],
        appBar: AppBar(
          backgroundColor: Colors.green[400],
          title: const Text('My Career Goals'),
          actions: [
            IconButton(
              icon: const Icon(Icons.list),
              onPressed: () async {
                Navigator.of(context).push(MaterialPageRoute(
                    builder: (BuildContext context) {
                      return GoalComplete();
                    }));
              },
            )
          ],
        ),
        body: Container(
            width: double.infinity,
            height: double.infinity,
            child: Column(children: <Widget>[
              Column(//First inner column
                  children: [
                const Padding(
                  padding: EdgeInsets.fromLTRB(16, 32, 16, 16),
                  child: Text('Long Term or Short Term Goal?',
                      style: TextStyle(fontSize: 18, color: Colors.black)),
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    Radio<int>(
                      activeColor: Colors.black,
                      fillColor: MaterialStateColor.resolveWith(
                          (states) => Colors.black),
                      value: 0,
                      groupValue: _termValue,
                      onChanged: (newValue) =>
                          setState(() => _termValue = newValue!),
                    ),
                    Text(
                      'Long Term',
                      style: TextStyle(
                          fontSize: 18.0, fontWeight: FontWeight.bold),
                    ),
                    Radio<int>(
                      activeColor: Colors.black,
                      fillColor: MaterialStateColor.resolveWith(
                          (states) => Colors.black),
                      value: 1,
                      groupValue: _termValue,
                      onChanged: (newValue) =>
                          setState(() => _termValue = newValue!),
                    ),
                    Text(
                      'Short Term',
                      style: TextStyle(
                          fontSize: 18.0, fontWeight: FontWeight.bold),
                    ),
                  ],
                )
              ]),
              Column(children: <Widget>[
                const Padding(
                  padding: EdgeInsets.fromLTRB(8, 16, 8, 8),
                  child: Text('What is your Career Goal?',
                      style: TextStyle(
                          fontSize: 18.0, fontWeight: FontWeight.bold)),
                ),
                TextField(
                  style: TextStyle(fontSize: 18.0, fontWeight: FontWeight.bold),
                  controller: goal,
                  keyboardType: TextInputType.multiline,
                  minLines: 1,
                  maxLines: 5,
                  decoration: InputDecoration(
                    hintText: 'Goal',
                    hintStyle:
                        TextStyle(fontSize: 18.0, fontWeight: FontWeight.bold),
                    filled: true,
                    fillColor: Colors.white.withOpacity(0.3),
                  ),
                )
              ]),
              Column(//Second inner column
                  children: [
                const Padding(
                  padding: EdgeInsets.fromLTRB(16, 32, 16, 16),
                  child: Text('Complete or In-Progress?',
                      style: TextStyle(fontSize: 18.0, color: Colors.black)),
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    Radio<int>(
                      activeColor: Colors.black,
                      fillColor: MaterialStateColor.resolveWith(
                          (states) => Colors.black),
                      value: 0,
                      groupValue: _progressionValue,
                      onChanged: (newValue) =>
                          setState(() => _progressionValue = newValue!),
                    ),
                    const Text(
                      'Complete!',
                      style: TextStyle(
                          fontSize: 18.0, fontWeight: FontWeight.bold),
                    ),
                    Radio<int>(
                      activeColor: Colors.black,
                      fillColor: MaterialStateColor.resolveWith(
                          (states) => Colors.black),
                      value: 1,
                      groupValue: _progressionValue,
                      onChanged: (newValue) =>
                          setState(() => _progressionValue = newValue!),
                    ),
                    const Text(
                      'In-Progress!',
                      style: TextStyle(
                          fontSize: 18.0, fontWeight: FontWeight.bold),
                    ),
                  ],
                )
              ]),
              Column(children: <Widget>[
                Container(
                    margin: const EdgeInsets.only(top: 30),
                    child: SizedBox(
                      width: 150,
                      child: ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.green,
                        ),
                        onPressed: () {
                          sendToDatabase(_termValue, goal.text.toString(),
                              _progressionValue);
                        },
                        child: const Text('Submit'),
                      ),
                    )),
                /*Container(
                    margin: const EdgeInsets.only(top: 30),
                    child: SizedBox(
                      width: 150,
                      child: ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.blueAccent,
                        ),
                        onPressed: () {
                          // Navigator to Track Behaviors screen
                          Navigator.of(context).push(MaterialPageRoute(
                              builder: (BuildContext context) {
                                return SleepDataViewScreen();
                              }));
                        },
                        child: Text('Past Sleep Data'),
                      ),
                    ))*/
              ])
            ])));
  }

/*Widget _buildSuggestions() {
    return ListView.builder(
        padding: const EdgeInsets.all(16.0),
        itemBuilder: (context, i) {
          if (i.isOdd) return const Divider();

          final index = i ~/ 2;
          if (index >= _suggestions.length) {
            _suggestions.addAll(generateWordPairs().take(10));
          }
          return _buildRow(_suggestions[index]);
        });
  }

  Widget _buildRow(WordPair pair) {
    final alreadySaved = _saved.contains(pair);
    return ListTile(
      title: Text(
        pair.asCamelCase,
        style: _biggerFont,
      ),
      trailing: Icon(
        alreadySaved ? Icons.check_box_outlined : Icons.check_box_outline_blank,
        color: alreadySaved ? Colors.green : null,
      ),
      onTap: () {
        setState(() {
          if (alreadySaved) {
            _saved.remove(pair);
            dbRef
                .orderByChild('name')
                .equalTo(pair.asCamelCase.toString())
                .once()
                .then((event) {
              if (event.snapshot.value != null) {
                Map<dynamic, dynamic> children = event.snapshot.value as Map<dynamic, dynamic>;
                children.forEach((key, value) {
                  dbRef.child(key).remove();
                });
              }
            });
          } else {
            _saved.add(pair);
            dbRef.push().child("name").set(pair.asCamelCase.toString());
          }
        });
      },
    );
  }*/
}

Future<void> sendToDatabase(
    int termValue, String goal, int progressionValue) async {
  String term = termValue.toString();
  String progression = progressionValue.toString();
  switch (term) {
    case "0":{term = 'Long Term';} break;
    case "1":{term = 'Short Term';} break;
    case "-1":{term = 'no option selected';} break;
  }
  switch(progression){
    case "0":{progression = 'Complete!';} break;
    case "1":{progression = 'In-Progress';} break;
    case "-1":{progression = 'no option selected;';} break;
  }

  FirebaseAuth auth = FirebaseAuth.instance;

  DateTime now = DateTime.now();
  var formatter = DateFormat('yyyy-MM-dd hh:mm');
  String dateStr = formatter.format(now);

  DocumentReference<Map<String, dynamic>> myCareerGoalsRef = FirebaseFirestore
      .instance
      .collection('users')
      .doc(auth.currentUser?.uid)
      .collection('Goals')
      .doc(dateStr);

  myCareerGoalsRef.set({
    'Length of Goal': term,
    'Goal': goal,
    'Career Goal Term': progression,
  });
}

class GoalComplete extends StatefulWidget {
  const GoalComplete({Key? key}) : super(key: key);

  @override
  _GoalCompleteState createState() => _GoalCompleteState();
}

TextEditingController goalViewer =
TextEditingController(); //To be used to grab input from date text field
final regex = RegExp(
    r"\d{4}\-(0[1-9]|1[012])\-(0[1-9]|[12][0-9]|3[01])"); //Regex for checking validation of input - Will work on later
var _formKey = GlobalKey<FormState>();
int _progressionValue = -1;

class _GoalCompleteState extends State<GoalComplete> {
  DatabaseReference dbRef = FirebaseDatabase.instance.ref('liked');
  final _biggerFont = const TextStyle(fontSize: 18.0);
  final _saved = <WordPair>{};
  List<Map<dynamic, dynamic>> dataList = [];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.brown[100],
      appBar: AppBar(
        backgroundColor: Colors.green[400],
        title: const Text('Career Goals'),
        leading: GestureDetector(
          onTap: () {
            Navigator.pop(context, _saved);
          },
          child: const Icon(Icons.arrow_back_ios),
        ),
      ),
      body: Container(
        width: double.infinity,
        height: double.infinity,
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: Form(
                key: _formKey,
                child: SingleChildScrollView(
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: <Widget>[
                      Padding(
                        //Text that displays "Enter a Date"
                        padding: EdgeInsets.fromLTRB(16, 32, 16, 16),
                        child: Text(("Enter a Date:"),
                            style:
                            TextStyle(fontSize: 28.0, color: Colors.black),
                            textAlign: TextAlign.center),
                      ),
                      Container(
                        //Text box for typing in a date

                        child: TextFormField(
                          controller: goalViewer,
                          maxLength: 16,

                          style: TextStyle(fontSize: 18, color: Colors.black),
                          textAlignVertical: TextAlignVertical.top,
                          inputFormatters: <TextInputFormatter>[
                            FilteringTextInputFormatter.deny(RegExp(r'\n')),
                          ],
                          // Only numbers can be entered

                          decoration: InputDecoration(
                            filled: true,
                            fillColor: Colors.white.withOpacity(0.3),
                            border: OutlineInputBorder(),
                            hintText: 'Date must be of form "YYYY-MM-DD hh:mm"',
                            hintStyle: TextStyle(color: Colors.black),
                          ),

                          validator: (value) {
                            if (value == null ||
                                value.isEmpty ||
                                !regex.hasMatch(value)) {
                              return "Error: Input must be of form 'YYYY-MM-DD";
                            }
                            return null;
                          },
                        ),
                      ),
                      Padding(
                        padding: EdgeInsets.fromLTRB(0, 16, 0, 16),
                        child: ElevatedButton(
                          style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.green,
                        ),
                          onPressed: () {},
                          child: const Text("Fetch Entry",
                              style: TextStyle(fontSize: 18.0)),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
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

              // Future that needs to be resolved
              // inorder to display something on the Canvas
              future: getdata(goalViewer.text.toString()),
            ),
            Column(//Second inner column
                children: [
                  const Padding(
                    padding: EdgeInsets.fromLTRB(16, 32, 16, 16),
                    child: Text('Complete or In-Progress?',
                        style: TextStyle(fontSize: 18.0, color: Colors.black)),
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      Radio<int>(
                        activeColor: Colors.black,
                        fillColor: MaterialStateColor.resolveWith(
                                (states) => Colors.black),
                        value: 0,
                        groupValue: _progressionValue,
                        onChanged: (newValue) =>
                            setState(() => _progressionValue = newValue!),
                      ),
                      const Text(
                        'Complete!',
                        style: TextStyle(
                            fontSize: 18.0, fontWeight: FontWeight.bold),
                      ),
                      Radio<int>(
                        activeColor: Colors.black,
                        fillColor: MaterialStateColor.resolveWith(
                                (states) => Colors.black),
                        value: 1,
                        groupValue: _progressionValue,
                        onChanged: (newValue) =>
                            setState(() => _progressionValue = newValue!),
                      ),
                      const Text(
                        'In-Progress!',
                        style: TextStyle(
                            fontSize: 18.0, fontWeight: FontWeight.bold),
                      ),
                    ],
                  )
                ]),
          ],
        ),
      ),
    );
  }
}

Future<String> getdata(String goal) async {
  FirebaseAuth auth = FirebaseAuth.instance;
  String str = "\n";
  DateTime now = DateTime.now();
  var formatter = DateFormat('yyyy-MM-dd hh:mm');
  String dateStr = formatter.format(now);

  if (dateStr.isEmpty) {
    str += "Please Choose a Date";
  } else {
    DocumentReference<Map<String, dynamic>> myCareerGoalsRef = FirebaseFirestore.instance
        .collection('users')
        .doc(auth.currentUser?.uid)
        .collection('Goals')
        .doc(goal);

    await myCareerGoalsRef.get().then((querySnapshot) {
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

String loop(String data) {
  String s = data.toString();
  return s;
}

