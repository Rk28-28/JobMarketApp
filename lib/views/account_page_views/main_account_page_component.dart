import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:groupb_final/main.dart';
import '../../login_page.dart';
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
  int _selectedIndex = 4;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Account Page'),
      ),
      bottomNavigationBar: CustomBottomAppBar(
        selectedIndex: _selectedIndex,
      ),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.only(top: 60.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Text(
                "Hello, ${getUserName()}",
                style: const TextStyle(fontSize: 30),
              ),
              Padding(
                padding: const EdgeInsets.only(top: 100.0),
                child: Container(
                  width: 300,
                  child: ElevatedButton(
                    onPressed: () {
                      // Navigator to Extra Info screen
                      Navigator.of(context)
                          .push(MaterialPageRoute(builder: (BuildContext context) {
                        return JobJournalScreen();
                      }));
                    },
                    child: Text('My Job Search Journal'),
                  ),
                ),
              ),
              Container(
                width: 300,
                child: ElevatedButton(
                  onPressed: () {
                    // Navigator to Extra Info screen
                    Navigator.of(context)
                        .push(MaterialPageRoute(builder: (BuildContext context) {
                      return CareerGoalsScreen();
                    }));
                  },
                  child: Text('My Career Goals'),
                ),
              ),
              Container(
                width: 300,
                child: ElevatedButton(
                  onPressed: () {
                    // Navigator to Extra Info screen
                    Navigator.of(context)
                        .push(MaterialPageRoute(builder: (BuildContext context) {
                      return InterviewScreen();
                    }));
                  },
                  child: Text('Set/View Interviews'),
                ),
              ),
              Container(
                width: 300,
                child: ElevatedButton(
                    onPressed: () {
                      FirebaseAuth.instance.signOut();
                      /* This is used to navigate back to the login screen when signed out,
                    otherwise it will stay frozen on the accounts page, don't ask me why
                    this works
                    */
                      Navigator.pushAndRemoveUntil(
                          context,
                          MaterialPageRoute(builder: (context) => MyApp()),
                          (_) => false);
                    },
                    child: Text('Logout')),
              )
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
