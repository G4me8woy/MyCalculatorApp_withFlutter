import 'package:flutter/cupertino.dart';
import 'package:provider/provider.dart';
import '../model/EquationLogic.dart';

class AnswerSection extends StatelessWidget {
  final BuildContext inheritedContext;
  AnswerSection(this.inheritedContext);
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.fromLTRB(0, 0, 10, 0),
      // width: MediaQuery.of(inheritedContext).size.width,
      // decoration: BoxDecoration(border: Border.all(width: 1)),
      child: Text(
        "${inheritedContext.read<EquationLogic>().answer}",
        // "0",
        style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
      ),
    );
  }
}
