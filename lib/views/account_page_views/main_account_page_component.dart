import 'package:flutter/material.dart';

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
    padding: const EdgeInsets.all(20.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            ElevatedButton(
              onPressed: () { // Navigator to Extra Info screen
              Navigator.of(context).push(MaterialPageRoute(builder: (BuildContext context){
                return JobJournalScreen();
                }));
                },
              child: Text('My Job Search Journal'),
            ),
            SizedBox(height: 20.0),
            ElevatedButton(
              onPressed: () { // Navigator to Extra Info screen
                Navigator.of(context).push(MaterialPageRoute(builder: (BuildContext context){
                  return CareerGoalsScreen();
                }));
              },
              child: Text('My Career Goals'),
            ),
            ElevatedButton(
              onPressed: () { // Navigator to Extra Info screen
                Navigator.of(context).push(MaterialPageRoute(builder: (BuildContext context){
                  return InterviewScreen();
                }));
              },
              child: Text('Set/View Interviews'),
            ),

           // TODO: Add logout button here?

          ],
        ),
      ),
      ),
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