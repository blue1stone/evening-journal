import 'package:achievements/screens/licenses_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart'
    as noti;
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../helpers/db_helper.dart';
import '../helpers/notification_helper.dart';
import '../widgets/alarm_time_picker.dart';
import 'detail_screen.dart';
import 'edit_screen.dart';

class OverviewScreen extends StatelessWidget {
  final GlobalKey<ScaffoldState> scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  Widget build(BuildContext context) {
    final statusBarSize = MediaQuery.of(context).padding.top;

    return Scaffold(
      key: scaffoldKey,
      body: CustomScrollView(
        slivers: <Widget>[
          SliverAppBar(
            bottom: const PreferredSize(
              preferredSize: Size.fromHeight(35),
              child: Text(''),
            ),
            flexibleSpace: Container(
              padding: EdgeInsets.only(
                  top: 15 + statusBarSize, left: 20, right: 20, bottom: 15),
              width: double.infinity,
              height: double.infinity,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  Row(
                    children: <Widget>[
                      Container(
                        width: 35,
                        child: Image.asset(
                          'assets/images/moon.png',
                          color: Color(0xFFF2D1B3),
                          fit: BoxFit.cover,
                        ),
                      ),
                      const SizedBox(
                        width: 15,
                      ),
                      Text(
                        'Overview',
                        style: Theme.of(context).textTheme.headline3,
                      ),
                    ],
                  ),
                  Row(
                    mainAxisSize: MainAxisSize.min,
                    children: <Widget>[
                      IconButton(
                        icon: const Icon(Icons.info_outline),
                        color: const Color(0xDDFFFFFF),
                        onPressed: () {
                          showDialog(
                            context: context,
                            barrierDismissible: true,
                            builder: (_) {
                              return AboutDialog();
                            },
                          );
                        },
                      ),
                      IconButton(
                        icon: const Icon(Icons.notifications),
                        color: const Color(0xDDFFFFFF),
                        onPressed: () async {
                          final sharedPreferences =
                              await SharedPreferences.getInstance();

                          requestIOSPermissions(
                              Provider.of<noti.FlutterLocalNotificationsPlugin>(
                                  context,
                                  listen: false));

                          showDialog(
                            context: context,
                            barrierDismissible: true,
                            builder: (_) {
                              return AlarmTimePicker(sharedPreferences);
                            },
                          );
                        },
                      ),
                    ],
                  ),
                ],
              ),
              alignment: Alignment.centerLeft,
            ),
            backgroundColor: Colors.transparent,
            expandedHeight: 150 + statusBarSize,
          ),
          OverviewList(),
        ],
      ),
    );
  }
}

class OverviewList extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final db = Provider.of<AppDatabase>(context, listen: false);

    return StreamBuilder(
        stream: db.watchAllDays(),
        builder: (context, AsyncSnapshot<List<Day>> snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting)
            return SliverToBoxAdapter(
              child: Container(
                width: 200,
                height: 200,
                child: CircularProgressIndicator(),
              ),
            );
          // if (snapshot.data.isEmpty)
          //   return SliverToBoxAdapter(
          //     child: Text('No data yet.'),
          //   );
          return SliverList(
            delegate: SliverChildBuilderDelegate((context, i) {
              bool todayExists = false;
              if (snapshot.data.isNotEmpty) {
                todayExists = ((DateTime.now().year ==
                        DateTime.parse(snapshot.data[0].date).year) &&
                    (DateTime.now().month ==
                        DateTime.parse(snapshot.data[0].date).month) &&
                    (DateTime.now().day ==
                        DateTime.parse(snapshot.data[0].date).day));
              }

              return Container(
                width: double.infinity,
                height: 80,
                child: Row(
                  children: <Widget>[
                    ListLeadingDecoration(
                        !(i == snapshot.data.length) && !todayExists),
                    Container(
                      child: (i == 0 && !todayExists)
                          ? InkWell(
                              onTap: () {
                                Navigator.of(context)
                                    .pushNamed(EditScreen.routeName);
                              },
                              borderRadius: BorderRadius.circular(5),
                              child: Container(
                                alignment: Alignment.centerLeft,
                                width: 300,
                                child: Text(
                                  'Add today...',
                                  style: Theme.of(context)
                                      .textTheme
                                      .headline5
                                      .copyWith(color: Colors.white54),
                                ),
                              ),
                            )
                          : (i > 0 || todayExists)
                              ? InkWell(
                                  onTap: () {
                                    Navigator.of(context).pushNamed(
                                        DetailScreen.routeName,
                                        arguments: snapshot
                                            .data[todayExists ? i : i - 1].id);
                                  },
                                  borderRadius: BorderRadius.circular(5),
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceEvenly,
                                    children: <Widget>[
                                      Container(
                                        alignment: Alignment.centerLeft,
                                        width: 300,
                                        child: Text(
                                          DateFormat.MMMMEEEEd().format(
                                              DateTime.parse(snapshot
                                                  .data[todayExists ? i : i - 1]
                                                  .date)),
                                          style: Theme.of(context)
                                              .textTheme
                                              .headline5
                                              .copyWith(
                                                  color: Color(0xDDFFFFFF)),
                                        ),
                                      ),
                                      Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.start,
                                        children: <Widget>[
                                          CircleAvatar(
                                            radius: 6,
                                            backgroundColor: snapshot
                                                        .data[todayExists
                                                            ? i
                                                            : i - 1]
                                                        .rating >=
                                                    1
                                                ? Color(0xDDFFFFFF)
                                                : Color(0x44FFFFFF),
                                          ),
                                          const SizedBox(
                                            width: 5,
                                          ),
                                          CircleAvatar(
                                            radius: 6,
                                            backgroundColor: snapshot
                                                        .data[todayExists
                                                            ? i
                                                            : i - 1]
                                                        .rating >=
                                                    2
                                                ? Color(0xDDFFFFFF)
                                                : Color(0x44FFFFFF),
                                          ),
                                          const SizedBox(
                                            width: 5,
                                          ),
                                          CircleAvatar(
                                            radius: 6,
                                            backgroundColor: snapshot
                                                        .data[todayExists
                                                            ? i
                                                            : i - 1]
                                                        .rating >=
                                                    3
                                                ? Color(0xDDFFFFFF)
                                                : Color(0x44FFFFFF),
                                          ),
                                          const SizedBox(
                                            width: 5,
                                          ),
                                          CircleAvatar(
                                            radius: 6,
                                            backgroundColor: snapshot
                                                        .data[todayExists
                                                            ? i
                                                            : i - 1]
                                                        .rating >=
                                                    4
                                                ? Color(0xDDFFFFFF)
                                                : Color(0x44FFFFFF),
                                          ),
                                          const SizedBox(
                                            width: 5,
                                          ),
                                          CircleAvatar(
                                            radius: 6,
                                            backgroundColor: snapshot
                                                        .data[todayExists
                                                            ? i
                                                            : i - 1]
                                                        .rating >=
                                                    5
                                                ? const Color(0xDDFFFFFF)
                                                : const Color(0x44FFFFFF),
                                          )
                                        ],
                                      )
                                    ],
                                  ),
                                )
                              : null,
                    ),
                  ],
                ),
              );
            },
                childCount: (snapshot.data.isNotEmpty)
                    ? (!((DateTime.now().year ==
                                DateTime.parse(snapshot.data[0].date).year) &&
                            (DateTime.now().month ==
                                DateTime.parse(snapshot.data[0].date).month) &&
                            (DateTime.now().day ==
                                DateTime.parse(snapshot.data[0].date).day))
                        ? snapshot.data.length + 1
                        : snapshot.data.length)
                    : 1),
          );
        });
  }
}

class ListLeadingDecoration extends StatelessWidget {
  final bool _lastItem;
  ListLeadingDecoration(this._lastItem);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 20,
      height: 20,
      margin: const EdgeInsets.all(18),
      child: Stack(
        alignment: Alignment.center,
        overflow: Overflow.visible,
        children: <Widget>[
          CircleAvatar(
            backgroundColor: Theme.of(context).accentColor,
            radius: 8,
          ),
          if (_lastItem)
            Positioned(
              bottom: -50,
              child: DecoratedBox(
                child: const SizedBox(
                  width: 4,
                  height: 41,
                ),
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(15),
                    color: const Color(0xFFF2D1B3)),
              ),
            ),
          // Positioned(
          //   bottom: -16,
          //   child: DecoratedBox(
          //     child: SizedBox(
          //       width: 5,
          //       height: 14,
          //     ),
          //     decoration: BoxDecoration(
          //         borderRadius: BorderRadius.circular(15),
          //         color: Color(0xFFF2D1B3)),
          //   ),
          // ),
          // Positioned(
          //   bottom: -34,
          //   child: DecoratedBox(
          //     child: SizedBox(
          //       width: 5,
          //       height: 14,
          //     ),
          //     decoration: BoxDecoration(
          //         borderRadius: BorderRadius.circular(15),
          //         color: Color(0xFFF2D1B3)),
          //   ),
          // ),
        ],
      ),
    );
  }
}

class AboutDialog extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
      backgroundColor: Theme.of(context).backgroundColor,

      title: Text('About'),
      content: Column(
        mainAxisSize: MainAxisSize.min,
        children: <Widget>[
          ListTile(
            leading: Icon(
              Icons.account_circle,
              color: const Color(0xDDFFFFFF),
            ),
            title: Text('Made by Elias Ball in 2020'),
          ),
          ListTile(
            leading: Icon(
              Icons.list,
              color: const Color(0xDDFFFFFF),
            ),
            title: Text('3rd-party content & licenses'),
            onTap: () => Navigator.of(context).pushNamed(LicensesScreen.routeName),
          ),
        ],
      ),
    );
  }
}
