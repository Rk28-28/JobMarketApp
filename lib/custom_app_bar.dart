import 'package:flutter/material.dart';
import 'package:groupb_final/views/money_page_views/main_money_page_component.dart';
import 'package:groupb_final/views/search_page_views/main_search_page_component.dart';
import 'package:groupb_final/views/account_page_views/main_account_page_component.dart';
import 'package:groupb_final/views/video_page_views/main_video_page_component.dart';

import 'home_page.dart';

class CustomBottomAppBar extends StatelessWidget {
  final int selectedIndex;

  const CustomBottomAppBar({
    Key? key,
    required this.selectedIndex,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BottomAppBar(
      shape: const CircularNotchedRectangle(),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          IconButton(
            icon: Icon(Icons.video_library),
            onPressed: () => Navigator.of(context).pushReplacement(
              MaterialPageRoute(builder: (_) => VideoPage()),
            ),
            color: selectedIndex == 0 ? Colors.blue : Colors.grey,
          ),
          IconButton(
            icon: Icon(Icons.attach_money),
            onPressed: () => Navigator.of(context).pushReplacement(
              MaterialPageRoute(builder: (_) => MoneyPage()),
            ),
            color: selectedIndex == 1 ? Colors.blue : Colors.grey,
          ),
          IconButton(
            icon: Icon(Icons.home),
            onPressed: () => Navigator.of(context).pushReplacement(
              MaterialPageRoute(builder: (_) => MyHomePage()),
            ),
            color: selectedIndex == 2 ? Colors.blue : Colors.grey,
          ),
          IconButton(
            icon: Icon(Icons.search),
            onPressed: () => Navigator.of(context).pushReplacement(
              MaterialPageRoute(builder: (_) => SearchPage()),
            ),
            color: selectedIndex == 3 ? Colors.blue : Colors.grey,
          ),
          IconButton(
            icon: Icon(Icons.person),
            onPressed: () => Navigator.of(context).pushReplacement(
              MaterialPageRoute(builder: (_) => AccountPage()),
            ),
            color: selectedIndex == 4 ? Colors.blue : Colors.grey,
          ),
        ],
      ),
    );
  }
}

