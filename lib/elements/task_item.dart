import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:minimal_task/utils/constants.dart';

class TaskItem extends StatelessWidget {
  final String text;
  final bool isDone;

  const TaskItem({Key key, this.text, this.isDone = false}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 24.0, vertical: 6.0),
      child: Row(
        children: [
          isDone
              ? Container(
                padding: EdgeInsets.all(4.0),
                  margin: EdgeInsets.only(right: 12.0),
                  width: 20,
                  height: 20,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(6.0),
                    color: Color(0xFF3DDC84),
                  ),
                  child: SvgPicture.asset(KImages.checkIcon),
                )
              : Container(
                  margin: EdgeInsets.only(right: 12.0),
                  width: 20.0,
                  height: 20.0,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(6.0),
                    color: Color(0xFFFFFFFF),
                    border: Border.all(
                      width: 1.5,
                      color: Color(0xFF3DDC84),
                    ),
                  ),
                ),
          Expanded(
            child: Text(
              text ?? KStrings.unnamedTask,
              overflow: TextOverflow.ellipsis,
              style: isDone
                  ? KStyles.bodyRegular
                      .copyWith(decoration: TextDecoration.lineThrough)
                  : KStyles.bodyDark,
            ),
          ),
        ],
      ),
    );
  }
}
