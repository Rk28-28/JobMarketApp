import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:groupb_final/main.dart';
import '../../custom_app_bar.dart';
import 'career_goal_page_component.dart';
import 'job_journal_page_component.dart';
import 'interview_page_component.dart';

class AccountPage extends StatefulWidget {
  const AccountPage({Key? key}) : super(key: key);

  @override
  _AccountPageState createState() => _AccountPageState();
}

class _AccountPageState extends State<AccountPage> {
  final int _selectedIndex = 4;

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      backgroundColor: Colors.brown[100],
      appBar: AppBar(
        title: const Text('Your Account'),
        backgroundColor: Colors.green[400],
      ),
      bottomNavigationBar: CustomBottomAppBar(
        selectedIndex: _selectedIndex,
      ),
      body: Container(
        color: Colors.brown[100],
        child: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Container(
              padding: EdgeInsets.symmetric(vertical: 40.0, horizontal: 20.0),
              decoration: BoxDecoration(
                color: Colors.green[400],
                borderRadius: const BorderRadius.only(
                  bottomLeft: Radius.circular(20.0),
                  bottomRight: Radius.circular(20.0),
                ),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                   CircleAvatar(
                    radius: 50.0,
                    backgroundColor: Colors.brown[50],
                    child: Icon(
                      Icons.person,
                      size: 60.0,
                      color: Colors.brown[100],
                    ),
                  ),
                  SizedBox(height: 10.0),
                  Text(
                    getUserName(),
                    style: const TextStyle(
                      color: Colors.black,
                      fontSize: 20.0,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ],
              ),
            ),
            SizedBox(height: 50.0),
            buildOptionButton(
              context,
              'My Interview Journal',
              Icon(Icons.book, color:Colors.black),
              JobJournalScreen(),
            ),
            SizedBox(height: 20.0),
            buildOptionButton(
              context,
              'My Career Goals',
              Icon(Icons.school, color:Colors.black),
              CareerGoalsScreen(),
            ),
            SizedBox(height: 20.0),
            buildOptionButton(
              context,
              'Set/View Interviews',
              Icon(Icons.calendar_today, color:Colors.black),
              InterviewScreen(),
            ),
            SizedBox(height: 50.0),
           ElevatedButton(
              style: ButtonStyle(
                backgroundColor: MaterialStateProperty.all(Colors.indigo[200]),
                minimumSize: MaterialStateProperty.all(Size(100, 40)),
              ),
              onPressed: () {
                FirebaseAuth.instance.signOut();
                Navigator.pushAndRemoveUntil(
                  context,
                  MaterialPageRoute(builder: (context) => MyApp()),
                      (_) => false,
                );
              },
              child: const Text(
                'Logout',
                style: TextStyle(color: Colors.black, fontSize: 16),
              ),
            ),
            SizedBox(height: 50.0),
          ],
        ),
      ),
      ),
    );
  }
  String getUserName(){
    if (FirebaseAuth.instance.currentUser!.isAnonymous) {
      return "Anonymous";
    }
    else {
      return FirebaseAuth.instance.currentUser!.displayName!;
    }
  }
  Widget buildOptionButton(
      BuildContext context,
      String text,
      Icon icon,
      Widget screen,
      ) {
    return ElevatedButton.icon(
        style: ButtonStyle(
        backgroundColor: MaterialStateProperty.all(Colors.brown[50]),
          minimumSize: MaterialStateProperty.all(Size(100, 50)),

        ),
    onPressed: () {
    Navigator.of(context).push(MaterialPageRoute(builder: (_) => screen));
    },
    icon: icon,
    label: Text(
    text,
    style: const TextStyle(color: Colors.green, fontWeight: FontWeight.bold, fontSize: 20),
    )
    );
}
}

class JobJournalScreen extends StatefulWidget {
  @override
  _JobJournalScreen createState() => _JobJournalScreen();
}

class _JobJournalScreen extends State<JobJournalScreen> {
  @override
  Widget build(BuildContext context) {
    return new JobJournalPage();
  }
}

class CareerGoalsScreen extends StatefulWidget {
  @override
  _CareerGoalsScreen createState() => _CareerGoalsScreen();
}

class _CareerGoalsScreen extends State<CareerGoalsScreen> {
  @override
  Widget build(BuildContext context) {
    return new CareerGoalPage();
  }
}

class InterviewScreen extends StatefulWidget {
  @override
  _InterviewScreen createState() => _InterviewScreen();
}

class _InterviewScreen extends State<InterviewScreen> {
  @override
  Widget build(BuildContext context) {
    return new InterviewPage();
  }
}
