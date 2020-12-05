import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:minimal_task/elements/task_card.dart';
import 'package:minimal_task/helpers/database_helper.dart';
import 'package:minimal_task/main.dart';
import 'package:minimal_task/screens/task_page.dart';
import 'package:minimal_task/utils/constants.dart';
import 'package:minimal_task/utils/shared_prefs.dart';

class HomePage extends StatefulWidget {
  final SharedPrefs sharedPrefs;

  const HomePage({Key key, this.sharedPrefs}) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  DatabaseHelper _dbHelper = DatabaseHelper();

  String _getGreeting() {
    int now = TimeOfDay.now().hour;
    if (now >= 5 && now <= 11) {
      return KStrings.goodMorning;
    } else if (now >= 12 && now <= 16) {
      return KStrings.goodAfternoon;
    } else if (now >= 17 && now <= 20) {
      return KStrings.goodEvening;
    } else {
      return KStrings.goodNight;
    }
  }

  @override
  void initState() {
    super.initState();
  }

  // _setDummyData() async {
  //   SharedPreferences prefs = await SharedPreferences.getInstance();
  //   setState(() {
  //     isCheck = prefs.getBool('dataSet') ?? true;
  //   });

  //   if (isCheck == true) {
  //     SetData().assign();
  //     prefs.setBool('dataSet', false);
  //   }
  // }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Stack(
          children: [
            Container(
              width: double.infinity,
              padding: EdgeInsets.symmetric(
                horizontal: 24.0,
              ),
              color: Color(0xFFFAF9FA),
              child: Stack(
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      _buildHeader(),
                      _buildTaskList(),
                    ],
                  ),
                  _buildFloatingButton(context),
                ],
              ),
            ),
            if (sharedPrefs.isFirst) _buildWelcomeScreen(context)
          ],
        ),
      ),
    );
  }

  Widget _buildWelcomeScreen(BuildContext context) {
    return BackdropFilter(
      filter: ImageFilter.blur(
        sigmaX: 5.0,
        sigmaY: 5.0,
      ),
      child: Align(
        alignment: Alignment.bottomCenter,
        child: Container(
          height: MediaQuery.of(context).size.height / 2,
          decoration: BoxDecoration(
            color: Color(0xFFFFFFFF),
            borderRadius: BorderRadius.only(
              topLeft: Radius.circular(24.0),
              topRight: Radius.circular(24.0),
            ),
          ),
          padding: EdgeInsets.all(24.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              SvgPicture.asset(KImages.logoIcon),
              Text(
                KStrings.whatNext,
                style: KStyles.largeHeadingLight,
              ),
              Text(
                KStrings.whatNextDescription,
                style: KStyles.bodyRegular.copyWith(
                  fontWeight: FontWeight.normal,
                ),
                textAlign: TextAlign.center,
              ),
              InkWell(
                onTap: () {
                  setState(() {
                    sharedPrefs.isFirst = false;
                  });
                },
                child: Container(
                  height: 60.0,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(20.0),
                    gradient: LinearGradient(
                      begin: Alignment(0.0, -1.0),
                      end: Alignment(0.0, 1.0),
                      colors: [
                        const Color(0xff4183ef),
                        const Color(0xff3a75d7)
                      ],
                      stops: [0.0, 1.0],
                    ),
                  ),
                  child: Center(
                    child: Text(
                      KStrings.getStarted,
                      style: KStyles.bodyRegular
                          .copyWith(color: Color(0xFFFFFFFF)),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildFloatingButton(BuildContext context) {
    return Positioned(
      bottom: 24.0,
      right: 0.0,
      child: GestureDetector(
        onTap: () => Navigator.push(
          context,
          MaterialPageRoute(
              builder: (context) => TaskPage(
                    task: null,
                  )),
        ).then((value) {
          setState(() {});
        }),
        child: Container(
          padding: EdgeInsets.all(18.0),
          width: 60.0,
          height: 60.0,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(20.0),
            color: Color(0xFF4285F4),
            gradient: LinearGradient(
              begin: Alignment(0.0, -1.0),
              end: Alignment(0.0, 1.0),
              colors: [Color(0xFF4183EF), Color(0xFF3A75D7)],
              stops: [0.0, 1.0],
            ),
          ),
          child: SvgPicture.asset(KImages.addIcon),
        ),
      ),
    );
  }

  Widget _buildTaskList() {
    return Expanded(
      child: FutureBuilder(
        initialData: [],
        future: _dbHelper.getTasks(),
        builder: (context, snapshot) {
          return ListView.builder(
            physics: BouncingScrollPhysics(),
            itemCount: snapshot.data.length,
            itemBuilder: (context, index) {
              return GestureDetector(
                onTap: () => Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => TaskPage(
                              task: snapshot.data[index],
                            ))).then((value) {
                  setState(() {});
                }),
                child: TaskCard(
                  title: snapshot.data[index].title,
                  desc: snapshot.data[index].description,
                ),
              );
            },
          );
        },
      ),
    );
  }

  Widget _buildHeader() {
    return Container(
      margin: EdgeInsets.only(bottom: 32.0, top: 32.0),
      child: Row(
        children: [
          SvgPicture.asset(
            KImages.logoIcon,
            height: 32.0,
          ),
          SizedBox(width: 24.0),
          Text(
            _getGreeting(),
            style: KStyles.headingRegular,
          ),
        ],
      ),
    );
  }
}
