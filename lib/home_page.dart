import 'package:flutter/material.dart';

import 'custom_app_bar.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final int _selectedIndex = 2;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Home Page'),
        backgroundColor: Colors.brown[100],
      ),
      backgroundColor: Colors.brown[50], // Set background color to tan
      bottomNavigationBar: CustomBottomAppBar(
        selectedIndex: _selectedIndex,
      ),
     // Set background color to tan
    body: SafeArea(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.only(left: 16, top: 16),
              child: RichText(
                text: const TextSpan(
                  text: 'Hi Future ',
                  style: TextStyle(
                    fontSize: 26,
                    fontWeight: FontWeight.bold,
                    color: Colors.black,
                  ),
                  children: <TextSpan>[
                    TextSpan(
                      text: 'Software Developer',
                      style: TextStyle(
                        fontSize: 26,
                        fontWeight: FontWeight.bold,
                        color: Colors.green,

                      ),
                    ),
                  ],
                ),
              ),
            ),
            const Padding(
              padding: EdgeInsets.only(left: 16, top: 8),
              child: Text(
                'Find your dream job here',
                style: TextStyle(
                  fontSize: 20,
                  color: Colors.black,
                ),
              ),
            ),
            const SizedBox(height: 32),
            Expanded(
              child: Container(
                decoration: BoxDecoration(
                  color: Colors.brown[100],
                  borderRadius: const BorderRadius.only(
                    topLeft: Radius.circular(32),
                    topRight: Radius.circular(32),
                  ),
                ),
                child: Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      SizedBox(height: 16),
                      const Padding(
                        padding: EdgeInsets.only(left: 16),
                        child: Text(
                          'Popular Cities',
                          style: TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                      const SizedBox(height: 16),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          _buildSearchButton('New York'),
                          _buildSearchButton('San Francisco'),
                          _buildSearchButton('Seattle'),
                        ],
                      ),
                      const SizedBox(height: 16),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          _buildSearchButton('Austin'),
                          _buildSearchButton('Boston'),
                          _buildSearchButton('Chicago'),
                        ],
                      ),
                      const SizedBox(height: 32),
                      const Padding(
                        padding: EdgeInsets.only(left: 16),
                        child: Text(
                          'In-Demand Skills',
                          style: TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                      const SizedBox(height: 16),
                      Expanded(
                        child: GridView.count(
                          crossAxisCount: 2,
                          mainAxisSpacing: 16,
                          crossAxisSpacing: 16,
                          children: [
                            _buildSkillCard(
                              context,
                              'Programming',
                              'Programming is the process of designing, writing, testing, and maintaining computer programs.',
                              Icons.code_sharp
                            ),
                            _buildSkillCard(
                              context,
                              'Data Analysis',
                              'Data analysis is the process of inspecting, cleaning, transforming, and modeling data in order to discover useful information.',
                                Icons.analytics
                            ),
                            _buildSkillCard(
                              context,
                              'Project Management',
                              'Project management is the practice of leading the work of a team to achieve goals and meet success criteria at a specified time.',
                                Icons.schedule
                            ),
                            _buildSkillCard(
                              context,
                              'User Experience Design',
                              'User experience design is the process of enhancing user satisfaction by improving the usability, accessibility, and pleasure provided in the interaction between the user and the product.',
                            Icons.design_services
                            ),
                            _buildSkillCard(
                              context,
                              'Artificial Intelligence',
                              'Artificial intelligence is the simulation of human intelligence processes by computer systems.',
                            Icons.smart_toy
                            ),
                            _buildSkillCard(
                              context,
                              'Mobile App Development',
                              'Mobile app development is the process of creating software applications that run on a mobile device, such as a smartphone or tablet.',
                            Icons.smartphone
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildSearchButton(String text) {
    return ElevatedButton(
      onPressed: () {},
      style: ButtonStyle(
        backgroundColor: MaterialStateProperty.all(Colors.green),
        shape: MaterialStateProperty.all(
          RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(20.0),
          ),
        ),
      ),
      child: Text(
        text,
        style: const TextStyle(
          fontSize: 18.0,
          fontWeight: FontWeight.bold,
          color: Colors.black,
        ),
      ),
    );
  }

  Widget _buildSkillCard(BuildContext context, String title, String description, IconData icon) {
    return GestureDetector(
      onTap: () => _showSkillDescription(context, title, description),
      child: Card(
        color: Colors.orange[200],
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(icon, size: 64),
            const SizedBox(height: 16),
            Text(
              title,
              style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
              textAlign: TextAlign.center,
            ),
          ],
        ),
      ),
    );
  }

  void _showSkillDescription(BuildContext context, String title,
      String description) {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Text(title),
          content: Text(description),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(context),
              child: const Text('OK'),
            ),
          ],
        );
      },
    );
  }
}

