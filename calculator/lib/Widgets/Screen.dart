import 'package:calculator/model/AnswerLogic.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../model/EquationLogic.dart';
import 'AnswerSection.dart';
import 'EquationSection.dart';

class Screen extends StatelessWidget {
  final BuildContext inheritedContext;

  Screen(this.inheritedContext);
  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        border: Border.all(width: 1),
        borderRadius: BorderRadius.only(
          bottomLeft: Radius.circular(15),
          bottomRight: Radius.circular(15),
        ),
      ),
      height: MediaQuery.of(inheritedContext).size.height * 0.2,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.end,
        children: [
          EquationSection(inheritedContext),
          AnswerSection(inheritedContext),
        ],
      ),
    );
  }
}
