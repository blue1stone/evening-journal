import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../helpers/db_helper.dart';
import '../widgets/edit_screens.dart';

class EditScreen extends StatefulWidget {
  static const routeName = '/edit';

  @override
  _EditScreenState createState() => _EditScreenState();
}

class _EditScreenState extends State<EditScreen> {
  var _currentScreenId = 0;

  List<String> _achievements = [];
  String _betterString;
  int _rating = 3;
  String _highlight;

  Day _currentDay;

  void _setAchievements(List<String> input) {
    _achievements = [...input];
  }

  void _setBetterString(String input) {
    _betterString = input;
  }

  void _setRating(int input) {
    _rating = input;
  }

  void _setHighlight(String input) {
    _highlight = input;
  }

  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

  Future<bool> _onWillPop() async {
    if (_currentScreenId == 0) return true;
    setState(() {
      _currentScreenId--;
    });
    return false;
  }

  @override
  Widget build(BuildContext context) {
    final id = ModalRoute.of(context).settings.arguments as String;

    return WillPopScope(
      onWillPop: _onWillPop,
      child: Scaffold(
        key: _scaffoldKey,
        body: FutureBuilder(
            future: (id != null && _currentDay == null)
                ? Provider.of<AppDatabase>(context, listen: false).getDay(id)
                : Future(() {}),
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting)
                return const Center(
                  child: CircularProgressIndicator(),
                );

              if (id != null && _currentDay == null) {
                _currentDay = snapshot.data;
                _achievements = _currentDay.achievementsString != null
                    ? (json.decode(_currentDay.achievementsString))
                        .cast<String>()
                    : [];
                _betterString = _currentDay.betterString;
                _rating = _currentDay.rating;
                _highlight = _currentDay.highlightString;
              }

              return Column(
                children: <Widget>[
                  if (_currentScreenId == 0)
                    Expanded(
                      child: AchieveScreen(_setAchievements, _achievements),
                    ),
                  if (_currentScreenId == 1)
                    Expanded(
                      child: BetterScreen(_setBetterString, _betterString),
                    ),
                  if (_currentScreenId == 2)
                    Expanded(
                      child: RateScreen(_setRating, _rating),
                    ),
                  if (_currentScreenId == 3)
                    Expanded(
                      child: HighlightScreen(_setHighlight, _highlight),
                    ),
                  Padding(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 15, vertical: 15),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: <Widget>[
                        IconButton(
                            icon: Icon(
                              Icons.arrow_back,
                              color: Color(0xAAFFFFFF),
                            ),
                            onPressed: () {
                              if (_currentScreenId == 0) {
                                Navigator.of(context).pop();
                                return;
                              }
                              setState(() {
                                _currentScreenId--;
                              });
                            }),
                        RaisedButton.icon(
                          onPressed: _currentScreenId == 3
                              ? () {
                                  final now = DateTime.now();
                                  var day = Day(
                                    id: _currentDay != null
                                        ? _currentDay.id
                                        : '${now.year}/${now.month}/${now.day}',
                                    date: _currentDay != null
                                        ? _currentDay.date
                                        : now.toIso8601String(),
                                    achievementsString: _achievements.isNotEmpty
                                        ? json.encode(_achievements)
                                        : null,
                                    betterString: _betterString != null
                                        ? _betterString
                                        : '',
                                    rating: _rating,
                                    highlightString:
                                        _highlight != null ? _highlight : '',
                                  );
                                  Provider.of<AppDatabase>(context,
                                          listen: false)
                                      .upsertDay(day);
                                  Navigator.of(context).pop();
                                }
                              : () {
                                  setState(() {
                                    _currentScreenId++;
                                  });
                                },
                          icon: Icon(_currentScreenId == 3
                              ? Icons.save
                              : Icons.arrow_forward),
                          label: Text(_currentScreenId == 3 ? 'SAVE' : 'NEXT'),
                          color: Theme.of(context).accentColor,
                          padding: const EdgeInsets.symmetric(
                              vertical: 10, horizontal: 18),
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(50)),
                        )
                      ],
                    ),
                  ),
                ],
              );
            }),
      ),
    );
  }
}
