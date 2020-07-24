import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';

import '../helpers/db_helper.dart';
import 'edit_screen.dart';

class DetailScreen extends StatelessWidget {
  static const routeName = '/detail';

  final _smileys = [
    'assets/images/sad_2.png',
    'assets/images/sad_1.png',
    'assets/images/neutral.png',
    'assets/images/happy_1.png',
    'assets/images/happy_2.png'
  ];

  @override
  Widget build(BuildContext context) {
    final id = ModalRoute.of(context).settings.arguments as String;

    return Scaffold(
      body: StreamBuilder<Day>(
        stream: Provider.of<AppDatabase>(context, listen: false).watchDay(id),
        builder: (context, AsyncSnapshot<Day> snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting ||
              snapshot.data == null)
            return const Center(
              child: CircularProgressIndicator(),
            );

          List<dynamic> achievements = snapshot.data.achievementsString != null
              ? (json.decode(snapshot.data.achievementsString) as List<dynamic>)
              : [];

          final statusBarSize = MediaQuery.of(context).padding.top;

          return CustomScrollView(
            slivers: <Widget>[
              SliverAppBar(
                automaticallyImplyLeading: false,
                bottom: const PreferredSize(
                  preferredSize: Size.fromHeight(35),
                  child: Text(''),
                ),
                flexibleSpace: Container(
                  padding: EdgeInsets.only(
                      top: 15 + statusBarSize, right: 15, bottom: 15),
                  width: double.infinity,
                  height: double.infinity,
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: <Widget>[
                      Padding(
                        padding: const EdgeInsets.all(10),
                        child: IconButton(
                          icon: Icon(
                            Icons.arrow_back,
                            color: Color(0xBBFFFFFF),
                          ),
                          onPressed: () => Navigator.of(context).pop(),
                        ),
                      ),
                      Expanded(
                        child: Text(
                          DateFormat.EEEE()
                              .format(DateTime.parse(snapshot.data.date)),
                          style: Theme.of(context).textTheme.headline3,
                        ),
                      ),
                      IconButton(
                        icon: Icon(
                          Icons.delete,
                          color: Color(0xBBFFFFFF),
                        ),
                        onPressed: () {
                          Provider.of<AppDatabase>(context, listen: false)
                              .deleteDay(snapshot.data);
                          Navigator.of(context).pop(snapshot.data);
                        },
                      ),
                      Padding(
                        padding: const EdgeInsets.all(10),
                        child: IconButton(
                          icon: Icon(
                            Icons.edit,
                            color: Color(0xBBFFFFFF),
                          ),
                          onPressed: () => Navigator.of(context).pushNamed(
                              EditScreen.routeName,
                              arguments: snapshot.data.id),
                        ),
                      ),
                    ],
                  ),
                  alignment: Alignment.centerLeft,
                ),
                backgroundColor: Colors.transparent,
                expandedHeight: 100 + statusBarSize,
              ),
              SliverToBoxAdapter(
                child: Padding(
                  padding: const EdgeInsets.all(15),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Row(
                        children: <Widget>[
                          Image.asset(
                            'assets/images/list.png',
                            color: Color(0xFFF2D1B3),
                            width: 40,
                          ),
                          const SizedBox(
                            width: 15,
                          ),
                          Expanded(
                            child: Text('What did I achieve today?',
                                style: Theme.of(context)
                                    .textTheme
                                    .headline5
                                    .copyWith(color: Color(0xFFF2D1B3))),
                          ),
                        ],
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      ConstrainedBox(
                        constraints: BoxConstraints(maxHeight: 200),
                        child: ListView.builder(
                            padding: EdgeInsets.zero,
                            shrinkWrap: true,
                            itemCount: achievements.isNotEmpty
                                ? achievements.length
                                : 1,
                            itemBuilder: (context, i) {
                              if (achievements.isEmpty)
                                return Text('...',
                                    style:
                                        Theme.of(context).textTheme.headline6);
                              return Row(
                                children: <Widget>[
                                  Padding(
                                    padding: const EdgeInsets.all(15),
                                    child: CircleAvatar(
                                      radius: 3,
                                      backgroundColor: Color(0xDDFFFFFF),
                                    ),
                                  ),
                                  Text(
                                    achievements[i],
                                    style:
                                        Theme.of(context).textTheme.headline6,
                                  ),
                                ],
                              );
                            }),
                      ),
                      const SizedBox(
                        height: 30,
                      ),
                      Row(
                        children: <Widget>[
                          Image.asset(
                            'assets/images/better.png',
                            color: Color(0xFFF2D1B3),
                            width: 40,
                          ),
                          const SizedBox(
                            width: 15,
                          ),
                          Expanded(
                            child: Text(
                              'What one thing could I have done better?',
                              style: Theme.of(context)
                                  .textTheme
                                  .headline5
                                  .copyWith(color: Color(0xFFF2D1B3)),
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      Text(
                        snapshot.data.betterString.isEmpty
                            ? '...'
                            : snapshot.data.betterString,
                        style: Theme.of(context).textTheme.headline6,
                      ),
                      const SizedBox(
                        height: 30,
                      ),
                      Row(
                        children: <Widget>[
                          Image.asset(
                            'assets/images/ranking.png',
                            color: Color(0xFFF2D1B3),
                            width: 40,
                          ),
                          const SizedBox(
                            width: 15,
                          ),
                          Expanded(
                            child: Text(
                              'How satisfied am I with my day?',
                              style: Theme.of(context)
                                  .textTheme
                                  .headline5
                                  .copyWith(color: Color(0xFFF2D1B3)),
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(
                        height: 20,
                      ),
                      Container(
                          width: double.infinity,
                          height: 60,
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: <Widget>[
                              Text(
                                '${snapshot.data.rating}/5',
                                style: Theme.of(context).textTheme.headline6,
                              ),
                              const SizedBox(
                                width: 40,
                              ),
                              Image.asset(
                                _smileys[snapshot.data.rating - 1],
                                color: Color(0xDDFFFFFF),
                                fit: BoxFit.contain,
                              ),
                            ],
                          )),
                      const SizedBox(
                        height: 30,
                      ),
                      Row(
                        children: <Widget>[
                          Image.asset(
                            'assets/images/highlight.png',
                            color: Color(0xFFF2D1B3),
                            width: 40,
                          ),
                          const SizedBox(
                            width: 15,
                          ),
                          Expanded(
                            child: Text(
                              'What was my highlight of the day?',
                              style: Theme.of(context)
                                  .textTheme
                                  .headline5
                                  .copyWith(color: Color(0xFFF2D1B3)),
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      Text(
                        snapshot.data.highlightString.isEmpty
                            ? '...'
                            : snapshot.data.highlightString,
                        style: Theme.of(context).textTheme.headline6,
                      ),
                    ],
                  ),
                ),
              )
            ],
          );
        },
      ),
    );
  }
}
