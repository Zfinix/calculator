import 'package:calculator/services/providers.dart';
import 'package:calculator/utils/margin.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

import '../utils/colors.dart';

class App extends HookWidget {
  const App({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var provider = useProvider(appVM);
    return Scaffold(
      backgroundColor: Colors.black,
      body: ListView(
        children: [
          const YMargin(40),
          Padding(
            padding: const EdgeInsets.all(20),
            child: TextField(
                controller: provider.result,
                textAlign: TextAlign.end,
                style: TextStyle(
                  fontSize: 50,
                  color: Colors.white,
                )),
          ),
          YMargin(context.screenHeight(0.07)),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              Button(
                text: 'AC',
                onTap: () => provider.ac(),
              ),
              Button(
                text: '+/-',
                onTap: () => provider.kPrimary = -provider.kPrimary,
              ),
              Button(
                text: '%',
                onTap: () => provider.kPrimary = provider.kPrimary / 100,
              ),
              Button(
                text: '÷',
                onTap: () => provider.changeOperator('/'),
                color: primary,
                fontSize: 35,
              ),
            ],
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              Button(
                text: '7',
                color: number,
              ),
              Button(
                text: '8',
                color: number,
              ),
              Button(
                text: '9',
                color: number,
              ),
              Button(
                text: '×',
                onTap: () => provider.changeOperator('*'),
                color: primary,
                fontSize: 35,
              ),
            ],
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              Button(
                text: '4',
                color: number,
              ),
              Button(
                text: '5',
                color: number,
              ),
              Button(
                text: '6',
                color: number,
              ),
              Button(
                text: '-',
                onTap: () => provider.changeOperator('-'),
                color: primary,
                fontSize: 35,
              ),
            ],
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              Button(
                text: '3',
                color: number,
              ),
              Button(
                text: '2',
                color: number,
              ),
              Button(
                text: '1',
                color: number,
              ),
              Button(
                text: '+',
                onTap: () => provider.changeOperator('+'),
                color: primary,
                fontSize: 35,
              ),
            ],
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              Button(
                text: '0',
                color: number,
                douleSize: true,
              ),
              Button(
                text: '.',
                onTap: () => provider.kDecimal = true,
                color: number,
              ),
              Button(
                text: '=',
                onTap: () => provider.equal(),
                color: primary,
                fontSize: 35,
              ),
            ],
          )
        ],
      ),
    );
  }
}

class Button extends HookWidget {
  final text;
  final VoidCallback onTap;
  final Color color;
  final double fontSize;
  final bool douleSize;
  const Button({
    Key key,
    this.text,
    this.onTap,
    this.fontSize,
    this.douleSize = false,
    this.color,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var provider = useProvider(appVM);
    return Padding(
      padding: const EdgeInsets.all(11),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(100),
        child: Material(
          color: color ?? secondary,
          child: InkWell(
            onTap: onTap ??
                () {
                  provider.addDigit(int.parse(text));
                },
            highlightColor: Colors.transparent,
            child: Container(
              height: context.screenWidth(0.18),
              width: douleSize
                  ? (context.screenWidth(0.18) * 2.4)
                  : context.screenWidth(0.18),
              child: Row(
                mainAxisAlignment: douleSize
                    ? MainAxisAlignment.start
                    : MainAxisAlignment.center,
                children: [
                  if (douleSize) const XMargin(20),
                  Text(
                    text ?? '',
                    style: TextStyle(
                      fontSize: fontSize ?? 30,
                      fontWeight: FontWeight.w300,
                      color: color == primary || color == number
                          ? Colors.white
                          : null,
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
