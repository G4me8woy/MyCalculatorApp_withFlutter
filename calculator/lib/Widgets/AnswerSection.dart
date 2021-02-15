import 'package:calculator/model/AnswerLogic.dart';
import 'package:flutter/cupertino.dart';
import 'package:provider/provider.dart';
import '../model/EquationLogic.dart';

class AnswerSection extends StatelessWidget {
  final BuildContext inheritedContext;
  AnswerSection(this.inheritedContext);
  @override
  Widget build(inheritedContext) {
    return Consumer<AnswerLogic>(
      builder: (inheritedContext, display, child) => Container(
        padding: EdgeInsets.fromLTRB(0, 0, 10, 0),
        child: Text(
          inheritedContext.read<AnswerLogic>().answer,
          style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
        ),
      ),
    );
  }
}
