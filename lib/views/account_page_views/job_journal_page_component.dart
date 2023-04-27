import 'package:flutter/material.dart';


class JobJournalPage extends StatefulWidget {
  const JobJournalPage({Key? key}) : super(key: key);

  @override
  _JobJournalPageState createState() => _JobJournalPageState();
}

double sliderValue = 1;
TextEditingController companyController = new TextEditingController();
TextEditingController likeController = new TextEditingController();
TextEditingController dislikeController = new TextEditingController();
TextEditingController recommendController = new TextEditingController();

class _JobJournalPageState extends State<JobJournalPage> {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('My Job Search Journal'),
      ),

        body: Container(

          width: double.infinity,
          height: double.infinity,

        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Form( //form
            child: SingleChildScrollView(
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: <Widget>[
                  Flexible(
                    child: Column( //First inner column
                      children: [

                        const Padding(
                          padding: EdgeInsets.fromLTRB(8,16,8,8),
                          child: Text('What job/company are you writing about?',
                              style: TextStyle(fontSize: 18.0)

                          ),
                        ),

                        Padding(
                          padding: EdgeInsets.fromLTRB(8,8,8,16),
                          child: TextFormField(
                            style: TextStyle(color: Colors.white),
                            controller: companyController,

                            decoration: InputDecoration(
                              filled: true,
                              fillColor: Colors.white.withOpacity(0.3),
                              border: OutlineInputBorder(),
                            ),

                          ),
                        )],

                    ),
                  ),
                  Flexible(
                    child:
                    Column( //Second inner column
                        children: [

                          const Padding(
                            padding: EdgeInsets.fromLTRB(8,16,8,8),
                            child: Text('What did you like about this job/company?',
                              style: TextStyle(fontSize: 18.0),

                            ),
                          ),

                          Padding(
                            padding: EdgeInsets.fromLTRB(8,8,8,16),
                            child: TextFormField(
                              controller: likeController,

                              decoration: InputDecoration(
                                  filled: true,
                                  fillColor: Colors.white.withOpacity(0.3),
                                  border: OutlineInputBorder(),
                              ),

                            ),
                          ),
                        ]    //children
                    ),
                  ),

                  Flexible(
                      child:
                      Column( //Third inner column
                      children: [

                  const Padding(
                    padding: EdgeInsets.fromLTRB(8,16,8,8),
                        child: Text('What did you dislike about this job/company?',
                        style: TextStyle(fontSize: 18.0),

                          ),
                        ),

                  Padding(
                    padding: EdgeInsets.fromLTRB(8,8,8,16),
                      child: TextFormField(
                      controller: likeController,

                  decoration: InputDecoration(
                      filled: true,
                      fillColor: Colors.white.withOpacity(0.3),
                      border: OutlineInputBorder(),
                      ),

                ),
                ),
                ]    //children
                ),
                ),

                Flexible(
                child:
                Column( //Fourth inner column
                    children: [

                    const Padding(
                      padding: EdgeInsets.fromLTRB(8,16,8,8),
                    child: Text('Do you have any recommendations for this job/company?',
                    style: TextStyle(fontSize: 18.0),

                    ),
                    ),

                    Padding(
                      padding: EdgeInsets.fromLTRB(8,8,8,16),
                    child: TextFormField(
                    controller: likeController,

                    decoration: InputDecoration(
                    filled: true,
                    fillColor: Colors.white.withOpacity(0.3),
                    border: OutlineInputBorder(),
                    ),

                  ),
                  ),
                  ]    //children
                  ),
                  ),

            Flexible(
              child:
                    Column(//final inner column
                      children: [
                        const Padding(
                            padding: EdgeInsets.fromLTRB(8,16,8,8),
                            child: Text('How would you rate your interview?', style: TextStyle(fontSize: 18.0),)
                        ),

                        Slider(
                          value: sliderValue,
                          min: 1,
                          max: 5,
                          divisions: 4,
                          label: sliderValue.round().toString(),
                          onChanged: (double value) {
                            setState(() {
                              sliderValue = value;
                            });
                          },
                        ),
                        Padding(
                          padding:EdgeInsets.fromLTRB(8,4,16,4),
                          child: Row( //Contains text for slider
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text('Terrible'),

                              Text('Fantastic')
                            ],
                          ),
                        ),
                      ],//children
                    ),
                  ),
                  Flexible(
                      child: Align(
                        alignment: Alignment.bottomCenter,
                        child: ElevatedButton(
                            onPressed: () {
                                ScaffoldMessenger.of(context).showSnackBar(
                                    const SnackBar(content: Text('Processing Data', style: TextStyle(color: Colors.white))));
                            }, child: const Text('Enter', style: TextStyle(fontSize: 18.0))
                        ),
                      )
                  ),

                ],
              ),
            ),
          ),
        ),



        )

    );
  }
}