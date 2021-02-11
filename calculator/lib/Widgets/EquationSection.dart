import 'package:flutter/cupertino.dart';
import 'package:provider/provider.dart';
import '../model/EquationLogic.dart';

class EquationSection extends StatelessWidget {
  final BuildContext inheritedContext;

  EquationSection(this.inheritedContext);

  @override
  Widget build(inheritedContext) {
    return Container(
      width: MediaQuery.of(inheritedContext).size.width,
      // decoration: BoxDecoration(border: Border.all(width: 1)),
      child: Text(
        inheritedContext.read<EquationLogic>().displayEquation,
        // inheritedContext.read<Logic>().test,
        style: TextStyle(fontSize: 20),
      ),
    );
  }
}
