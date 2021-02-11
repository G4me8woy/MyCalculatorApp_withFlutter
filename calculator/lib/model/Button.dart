import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'EquationLogic.dart';

class Button {}

Widget buildButton(String value, BuildContext context) => GestureDetector(
      onTap: () {
        var display = context.read<EquationLogic>();
        display.equationUpdate(value);
      },
      child: Container(
        height: 70,
        width: 70,
        decoration: BoxDecoration(
            // border: Border.all(width: 1),
            color: Color.fromRGBO(55, 67, 83, 1),
            boxShadow: [
              BoxShadow(
                color: Color.fromRGBO(67, 76, 91, 1),
                blurRadius: 0, // soften the shadow
                spreadRadius: 0, //extend the shadow
                offset: Offset(
                  -2.5, // Move to right 10  horizontally
                  -2.5, // Move to bottom 10 Vertically
                ),
              ),
              BoxShadow(
                color: Colors.black,
                blurRadius: 0, // soften the shadow
                spreadRadius: 0, //extend the shadow
                offset: Offset(
                  1.0, // Move to right 10  horizontally
                  1.0, // Move to bottom 10 Vertically
                ),
              )
            ],
            borderRadius: BorderRadius.all(Radius.circular(15))),
        child: Center(
          child: Text(
            value,
            style: TextStyle(color: Colors.white, fontSize: 25),
          ),
        ),
      ),
    );
