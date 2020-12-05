import 'package:flutter/material.dart';
import 'package:minimal_task/utils/constants.dart';

class TaskCard extends StatelessWidget {
  final String title;
  final String desc;

  const TaskCard({Key key, this.title, this.desc}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: EdgeInsets.symmetric(
        horizontal: 24.0,
        vertical: 32.0,
      ),
      margin: EdgeInsets.only(bottom: 20.0),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(20.0),
        color: const Color(0xFFFFFFFF),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            title ?? KStrings.unnamedTask,
            overflow: TextOverflow.ellipsis,
            style: KStyles.headingDark,
          ),
          Padding(
            padding: const EdgeInsets.only(top: 10.0),
            child: Text(
              desc ?? KStrings.noDescriptionAddedYet,
              overflow: TextOverflow.ellipsis,
              maxLines: 3,
              style: KStyles.bodyRegular,
            ),
          ),
        ],
      ),
    );
  }
}
