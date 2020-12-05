import 'package:flutter/material.dart';

class KStrings {
  KStrings._();
//Constant Strings
  static const String whatNext = 'What\'s next';
  static const String whatNextDescription =
      '''Minimal task, is a simple app to list
  your task and to check when finished.''';
  static const String getStarted = 'Get Started';
  static const String goodMorning = 'Good Morning,';
  static const String goodAfternoon = 'Good Afternoon,';
  static const String goodEvening = 'Good Evening,';
  static const String goodNight = 'Good Night,';
  static const String enterTaskTitle = 'Enter Task title.';
  static const String enterTaskDescription =
      'Enter Description for the task...';
  static const String createNewTask = 'Add a new task.';
  static const String unnamedTask = 'Unnamed task!';
  static const String noDescriptionAddedYet = 'No description added yet!';
  static const String dummyHeading = 'Get Started.';
  static const String dummyDescription = 'Hello User! Welcome to Minimal_Task app, this is a default task that you can edit or delete to start using the app.';
  static const String dummyTask1 = 'Create a new task ';
  static const String dummyTask2 = 'Add some description.';
  static const String dummyTask3 = 'Delete this default task.';
}

class KImages {
  KImages._();
  //Image path
  static const String logoIcon = 'assets/icons/logo_icon.svg';
  static const String addIcon = 'assets/icons/add_icon.svg';
  static const String deleteIcon = 'assets/icons/delete_icon.svg';
  static const String backIcon = 'assets/icons/back_arrow_icon.svg';
  static const String checkIcon = 'assets/icons/check_icon.svg';
}

class KColors {
  KColors._();
  static const Color lightText = Color(0x998F948F);
  static const Color regularText = Color(0xFF8F948F);
  static const Color darkText = Color(0xFF073042);
}

//Text Style
class KStyles {
  KStyles._();
  //Text Style
  static final TextStyle leargeHeadingRegularLight = TextStyle(
    fontSize: 26,
    color: KColors.regularText,
    fontWeight: FontWeight.w700,
  );
  static final TextStyle largeHeadingLight = leargeHeadingRegularLight.copyWith(
    color: KColors.lightText,
  );
  static final TextStyle largeHeadingDark = leargeHeadingRegularLight.copyWith(
    color: KColors.darkText,
  );
  static final TextStyle headingRegular = TextStyle(
    fontSize: 22.0,
    color: KColors.regularText,
    fontWeight: FontWeight.w700,
  );
  static final TextStyle headingDark = headingRegular.copyWith(
    color: KColors.darkText,
  );

  static final TextStyle bodyRegular = TextStyle(
    fontSize: 16.0,
    color: KColors.regularText,
    fontWeight: FontWeight.w600,
    height: 1.5,
  );

  static final TextStyle bodyDark = bodyRegular.copyWith(
    color: KColors.darkText,
  );
}
