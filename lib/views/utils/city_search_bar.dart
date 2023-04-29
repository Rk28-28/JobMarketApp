import '../money_page_views/compare_cities_component.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:groupb_final/views/utils/cities_list.dart';
import 'package:searchfield/searchfield.dart';

class SearchBar extends StatefulWidget {
  final TextEditingController controller;
  final VoidCallback voidCallBack;

  const SearchBar({Key? key, required this.controller, required this.voidCallBack}) : super(key: key);

  @override
  State<SearchBar> createState() => _searchBar();
}

class _searchBar extends State<SearchBar>{
  dynamic _selectedCity;
  final _focus = FocusNode();


  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    controller.dispose();
    _focus.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Padding(
            padding: const EdgeInsets.only(top: 40, right: 30, left: 30),
            child: SearchField(
              searchInputDecoration: const InputDecoration(
                enabledBorder: OutlineInputBorder(
                    borderSide: BorderSide(color: Colors.grey, width: 2)),
                focusedBorder: OutlineInputBorder(
                    borderSide: BorderSide(color: Colors.grey, width: 2)),
              ),
              hint: "Search Cities",
              focusNode: _focus,
              controller: _searchController,
              maxSuggestionsInViewPort: 6,
              inputType: TextInputType.text,
              itemHeight: 50,
              onSuggestionTap: (value) {
                setState(() {
                  _selectedCity = value.item;
                  voidCallBack;
                });
                voidCallBack;
                getCityInformation(_searchController);
                _focus.unfocus();
              },
              suggestions: CitiesList.getCities
                  .map((e) => SearchFieldListItem(e))
                  .toList(),
            ),
          )
        ],
      ),
    );

  }
}