import 'package:flutter/material.dart';


class JobJournalPage extends StatefulWidget {
  const JobJournalPage({Key? key}) : super(key: key);

  @override
  _JobJournalPageState createState() => _JobJournalPageState();
}

class _JobJournalPageState extends State<JobJournalPage> {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('My Job Search Journal'),

        ),
    );
  }
}