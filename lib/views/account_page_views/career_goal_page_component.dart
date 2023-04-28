import 'package:flutter/material.dart';

import 'package:flutter/material.dart';
import 'package:english_words/english_words.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_database/firebase_database.dart';
/*
Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(const MyApp());
}*/

class InitGoal extends StatelessWidget {
  const InitGoal({super.key});
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Test change 1',
      theme: ThemeData(
        primaryColor: Colors.white,
      ),
      home: FutureBuilder(
        future: Firebase.initializeApp(),
        builder: (context, snapshot) {
          if (snapshot.hasError) {
            print('Error: ${snapshot.error.toString()}');
            return const Text("Something went wrong!");
          } else if (snapshot.hasData) {
            return const CareerGoalPage();
          } else {
            return const Center(
              child: CircularProgressIndicator(),
            );
          }
        },
      ),
    );
  }
}

class CareerGoalPage extends StatefulWidget {
  const CareerGoalPage({Key? key}) : super(key: key);

  @override
  _CareerGoalPageState createState() => _CareerGoalPageState();
}

class GoalComplete extends StatefulWidget {
  const GoalComplete({Key? key}) : super(key: key);

  @override
  _GoalCompleteState createState() => _GoalCompleteState();
}

class _GoalCompleteState extends State<GoalComplete> {
  DatabaseReference dbRef = FirebaseDatabase.instance.ref('liked');
  final _biggerFont = const TextStyle(fontSize: 18.0);
  final _saved = <WordPair>{};
  List<Map<dynamic, dynamic>> dataList = [];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Test changed 3"),
        leading: GestureDetector(
          onTap: () {
            Navigator.pop(context, _saved);
          },
          child: const Icon(Icons.arrow_back_ios),
        ),
      ),
      body: FutureBuilder(
          future: dbRef.once(),
          builder: (context, event) {

            if (event.hasData) {
              dataList.clear();
              if (event.data?.snapshot.value == null) {
                return const Center(
                  child: Text("No liked history!",
                    style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18.0),
                  ),
                );
              }
              Map<dynamic, dynamic> values = event.data!.snapshot.value as Map<dynamic, dynamic>;
              values.forEach((key, values) {
                dataList.add(values);
                final reg = RegExp(r"(?=[A-Z])");
                var parts = values['name'].split(reg);
                _saved.add(WordPair(parts[0], parts[1]).toLowerCase());
              });
              return ListView.builder(
                shrinkWrap: true,
                padding: const EdgeInsets.all(16.0),
                itemCount: dataList.length,
                itemBuilder: (BuildContext context, int index) {
                  return Card(
                    child: Column(
                      children: <Widget>[
                        ListTile(
                            trailing: const Icon(Icons.delete),
                            title: Text(dataList[index]['name'],
                                style: _biggerFont),
                            onTap: () => dbRef
                                .orderByChild('name')
                                .equalTo(dataList[index]['name'])
                                .once()
                                .then((event) {
                              Map<dynamic, dynamic> children =
                              event.snapshot.value as Map<dynamic, dynamic>;
                              children.forEach((key, value) {
                                dbRef.child(key).remove();
                              });
                              setState(() {});
                            })),
                      ],
                    ),
                  );
                },
              );
            }
            return const Center(
                child: CircularProgressIndicator()
            );
          }),
    );
  }
}

class _CareerGoalPageState extends State<CareerGoalPage> {
  DatabaseReference dbRef = FirebaseDatabase.instance.ref('liked');
  final _suggestions = <WordPair>[];
  var _saved = <WordPair>{};
  final _biggerFont = const TextStyle(fontSize: 18.0);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Test Change 2'),
        actions: [
          IconButton(
            icon: const Icon(Icons.list),
            onPressed: () async {
              final data = await Navigator.push(context,
                  MaterialPageRoute(builder: (context) => const GoalComplete()));
              setState(() {
                if(data != null) {
                  _saved = data;
                }
              });
            },
          )
        ],
      ),
      body: _buildSuggestions(),
    );
  }

  Widget _buildSuggestions() {
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
  }
}

