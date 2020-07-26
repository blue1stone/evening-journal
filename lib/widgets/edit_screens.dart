import 'dart:ui';

import 'package:flutter/material.dart';

class AchieveScreen extends StatefulWidget {
  @override
  _AchieveScreenState createState() => _AchieveScreenState();

  AchieveScreen(this.valueSetter, this.initialValue);
  final Function(List<String>) valueSetter;
  final List<String> initialValue;
}

class _AchieveScreenState extends State<AchieveScreen> {
  var textEditingController = TextEditingController();
  List<String> achievements;
  var focusNode = FocusNode();

  @override
  void initState() {
    super.initState();

    achievements = [...widget.initialValue] ?? [];
  }

  Widget _buildRowDecoration() {
    return Padding(
      padding: const EdgeInsets.all(15),
      child: CircleAvatar(
        radius: 3,
        backgroundColor: Color(0xDDFFFFFF),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    var statusBarSize = MediaQuery.of(context).padding.top;

    return Padding(
      padding:
          EdgeInsets.only(bottom: MediaQuery.of(context).viewInsets.bottom),
      child: Column(
        children: <Widget>[
          Container(
            padding:
                EdgeInsets.only(top: statusBarSize + 15, left: 20, right: 15),
            height: 230,
            alignment: Alignment.centerLeft,
            child: Row(
              children: <Widget>[
                Image.asset(
                  'assets/images/list.png',
                  color: const Color(0xFFF2D1B3),
                  width: 50,
                ),
                const SizedBox(
                  width: 20,
                ),
                Expanded(
                  child: Text(
                    'What did I achieve today?',
                    style: Theme.of(context).textTheme.headline4,
                  ),
                ),
              ],
            ),
          ),
          Expanded(
            child: ListView.builder(
              itemBuilder: (context, i) {
                if (i == achievements.length)
                  return Row(
                    children: <Widget>[
                      _buildRowDecoration(),
                      Expanded(
                        child: TextField(
                          key: ValueKey(i),
                          focusNode: focusNode,
                          textCapitalization: TextCapitalization.sentences,
                          controller: textEditingController,
                          cursorColor: Theme.of(context).accentColor,
                          style: Theme.of(context).textTheme.headline6,
                          onSubmitted: (val) {
                            if (val == null) return;
                            if (val.trim().isEmpty) {
                              focusNode.unfocus();
                              textEditingController.clear();
                              return;
                            }
                            textEditingController.clear();
                            setState(() {
                              achievements.add(val);
                            });
                            widget.valueSetter(achievements);
                          },
                          decoration: InputDecoration(
                            hintText: 'Add an achievement...',
                            border: InputBorder.none,
                            focusedBorder: InputBorder.none,
                            enabledBorder: InputBorder.none,
                            errorBorder: InputBorder.none,
                            disabledBorder: InputBorder.none,
                          ),
                        ),
                      ),
                    ],
                  );
                return Row(
                  children: <Widget>[
                    _buildRowDecoration(),
                    Expanded(
                      child: TextField(
                        style: Theme.of(context).textTheme.headline6,
                        maxLines: 1,
                        textCapitalization: TextCapitalization.sentences,
                        cursorColor: Theme.of(context).accentColor,
                        controller: TextEditingController()
                          ..text = achievements[i],
                        onSubmitted: (val) {
                          if (val.trim().isEmpty) {
                            setState(() {
                              achievements.removeAt(i);
                            });
                            widget.valueSetter(achievements);
                            return;
                          }
                          setState(() {
                            achievements[i] = val;
                          });
                          widget.valueSetter(achievements);
                        },
                        decoration: InputDecoration(
                          border: InputBorder.none,
                          focusedBorder: InputBorder.none,
                          enabledBorder: InputBorder.none,
                          errorBorder: InputBorder.none,
                          disabledBorder: InputBorder.none,
                        ),
                      ),
                    ),
                  ],
                );
              },
              itemCount: achievements.length + 1,
            ),
          ),
        ],
      ),
    );
  }
}

class BetterScreen extends StatefulWidget {
  @override
  _BetterScreenState createState() => _BetterScreenState();

  BetterScreen(this.valueSetter, this.initialValue);
  final Function(String) valueSetter;
  final String initialValue;
}

class _BetterScreenState extends State<BetterScreen> {
  var textEditingController = TextEditingController();

  @override
  void initState() {
    super.initState();

    textEditingController.text = widget.initialValue ?? '';

    textEditingController.addListener(() {
      widget.valueSetter(textEditingController.text);
    });
  }

  @override
  void dispose() {
    super.dispose();

    textEditingController.addListener(() {
      widget.valueSetter(textEditingController.text);
    });
  }

  @override
  Widget build(BuildContext context) {
    var statusBarSize = MediaQuery.of(context).padding.top;

    return Column(
      children: <Widget>[
        Container(
          padding:
              EdgeInsets.only(top: statusBarSize + 15, left: 20, right: 15),
          height: 230,
          alignment: Alignment.centerLeft,
          child: Row(
            children: <Widget>[
              Image.asset(
                'assets/images/better.png',
                color: const Color(0xFFF2D1B3),
                width: 50,
              ),
              const SizedBox(
                width: 20,
              ),
              Expanded(
                child: Text(
                  'What one thing could I have done better?',
                  style: Theme.of(context).textTheme.headline4,
                ),
              ),
            ],
          ),
        ),
        Expanded(
          child: SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.all(15),
              child: TextField(
                textCapitalization: TextCapitalization.sentences,
                style: Theme.of(context).textTheme.headline6,
                cursorColor: Theme.of(context).accentColor,
                maxLines: null,
                controller: textEditingController,
                decoration: InputDecoration(
                  hintText: 'Write something...',
                  border: InputBorder.none,
                  focusedBorder: InputBorder.none,
                  enabledBorder: InputBorder.none,
                  errorBorder: InputBorder.none,
                  disabledBorder: InputBorder.none,
                ),
                keyboardType: TextInputType.multiline,
              ),
            ),
          ),
        ),
      ],
    );
  }
}

class RateScreen extends StatefulWidget {
  @override
  _RateScreenState createState() => _RateScreenState();

  RateScreen(this.valueSetter, this.initialValue);
  final Function(int) valueSetter;
  final int initialValue;
}

class _RateScreenState extends State<RateScreen> {
  var _rating = 3.0;

  final _smileys = [
    'assets/images/sad_2.png',
    'assets/images/sad_1.png',
    'assets/images/neutral.png',
    'assets/images/happy_1.png',
    'assets/images/happy_2.png'
  ];
  // final _descriptions = [
  //   'Not at all.',
  //   'Not really.',
  //   'It was okay.',
  //   'Rather satisfied.',
  //   'Absolutely satisfied!'
  // ];

  @override
  void initState() {
    super.initState();

    _rating = widget.initialValue.toDouble() ?? 3.0;

    widget.valueSetter(_rating.toInt());
  }

  @override
  Widget build(BuildContext context) {
    var statusBarSize = MediaQuery.of(context).padding.top;

    return Column(
      children: <Widget>[
        Container(
          padding:
              EdgeInsets.only(top: statusBarSize + 15, left: 20, right: 15),
          height: 230,
          alignment: Alignment.centerLeft,
          child: Row(
            children: <Widget>[
              Image.asset(
                'assets/images/ranking.png',
                color: const Color(0xFFF2D1B3),
                width: 50,
              ),
              const SizedBox(
                width: 20,
              ),
              Expanded(
                child: Text(
                  'How satisfied am I with my day?',
                  style: Theme.of(context).textTheme.headline4,
                ),
              ),
            ],
          ),
        ),
        Expanded(
          child: SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 50),
              child: Column(
                children: <Widget>[
                  Image.asset(
                    _smileys[_rating.toInt() - 1],
                    color: Color(0xFFF2D1B3),
                    width: 200,
                    height: 200,
                    fit: BoxFit.cover,
                  ),
                  // SizedBox(
                  //   height: 20,
                  // ),
                  // Text(
                  //   _descriptions[_rating.toInt() - 1],
                  //   style: Theme.of(context).textTheme.headline5,
                  // ),
                  const SizedBox(
                    height: 50,
                  ),
                  Slider(
                    value: _rating,
                    onChanged: (val) {
                      setState(() {
                        _rating = val;
                      });
                      widget.valueSetter(_rating.toInt());
                    },
                    min: 1,
                    max: 5,
                    divisions: 4,
                    activeColor: Theme.of(context).accentColor,
                    inactiveColor: Theme.of(context).accentColor.withAlpha(70),
                  )
                ],
              ),
            ),
          ),
        ),
      ],
    );
  }
}

class HighlightScreen extends StatefulWidget {
  @override
  _HighlightScreenState createState() => _HighlightScreenState();

  HighlightScreen(this.valueSetter, this.initialValue);
  final Function(String) valueSetter;
  final String initialValue;
}

class _HighlightScreenState extends State<HighlightScreen> {
  var textEditingController = TextEditingController();

  @override
  void initState() {
    super.initState();

    textEditingController.text = widget.initialValue ?? '';

    textEditingController.addListener(() {
      widget.valueSetter(textEditingController.text);
    });
  }

  @override
  void dispose() {
    super.dispose();

    textEditingController.removeListener(() {
      widget.valueSetter(textEditingController.text);
    });
  }

  @override
  Widget build(BuildContext context) {
    var statusBarSize = MediaQuery.of(context).padding.top;

    return Column(
      children: <Widget>[
        Container(
          padding:
              EdgeInsets.only(top: statusBarSize + 15, left: 20, right: 15),
          height: 230,
          alignment: Alignment.centerLeft,
          child: Row(
            children: <Widget>[
              Image.asset(
                'assets/images/highlight.png',
                color: const Color(0xFFF2D1B3),
                width: 50,
              ),
              const SizedBox(
                width: 20,
              ),
              Expanded(
                child: Text(
                  'What was my highlight of the day?',
                  style: Theme.of(context).textTheme.headline4,
                ),
              ),
            ],
          ),
        ),
        Expanded(
          child: SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.all(15),
              child: TextField(
                textCapitalization: TextCapitalization.sentences,
                style: Theme.of(context).textTheme.headline6,
                cursorColor: Theme.of(context).accentColor,
                maxLines: null,
                controller: textEditingController,
                decoration: InputDecoration(
                  hintText: 'Write something...',
                  border: InputBorder.none,
                  focusedBorder: InputBorder.none,
                  enabledBorder: InputBorder.none,
                  errorBorder: InputBorder.none,
                  disabledBorder: InputBorder.none,
                ),
                keyboardType: TextInputType.multiline,
              ),
            ),
          ),
        ),
      ],
    );
  }
}
