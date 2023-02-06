import 'package:calculator/calc_tab.dart';
import 'package:calculator/my_colors.dart';
import 'package:calculator/providers/result_provider.dart';
import 'package:calculator/providers/user_input_provider.dart';
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:function_tree/function_tree.dart';

// ref.read(userInputProvider.notifier).state += buttons[index];

void preventNoneNumeric(
    {required String str, required WidgetRef ref, required int index}) {
  final RegExp regex = RegExp(r'\D{2,}');

  final userStr = ref.watch(userInputProvider);
  var str = userStr;
  str += buttons[index];
  if (regex.hasMatch(str)) {
    return;
  } else {
    ref.read(userInputProvider.notifier).state += buttons[index];
  }
}

class TabsContainer extends ConsumerWidget {
  const TabsContainer({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    var userInput = ref.watch(userInputProvider);
    return Align(
      alignment: Alignment.bottomCenter,
      child: Container(
        height: MediaQuery.of(context).size.height * 0.6,
        decoration: const BoxDecoration(
            color: MyColors.tabsDarkBackground,
            borderRadius: BorderRadius.only(
              topLeft: Radius.circular(36.0),
              topRight: Radius.circular(36.0),
            )),
        child: GridView.builder(
          padding: const EdgeInsets.all(30.0),
          shrinkWrap: true,
          itemCount: buttons.length,
          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 4,
            childAspectRatio: 1,
            mainAxisSpacing: 10.0,
            crossAxisSpacing: 10.0,
          ),
          itemBuilder: (_, index) {
            // AC button
            if (index == 0) {
              return CalcTab(
                text: buttons[index],
                color: MyColors.tabGreen,
                onTap: () {
                  ref.read(userInputProvider.notifier).state = '';
                  ref.read(resultProvider.notifier).state = '';
                },
              );
            }
            // '+/-' button
            else if (index == 1) {
              return CalcTab(
                text: buttons[index],
                color: MyColors.tabGreen,
                onTap: () {
                  if (userInput.isNotEmpty) {
                    if (userInput[0] == '-') {
                      ref.read(userInputProvider.notifier).state =
                          userInput.substring(1);
                    } else {
                      ref.read(userInputProvider.notifier).state =
                          '-$userInput';
                    }
                  }
                },
              );
            }
            //  '%' button
            else if (index == 2) {
              return CalcTab(
                text: buttons[index],
                color: MyColors.tabGreen,
                onTap: () {
                  if (userInput.isNotEmpty) {
                    ref.read(userInputProvider.notifier).state +=
                        buttons[index];
                  }
                },
              );
            }
            // '/' divide button
            else if (index == 3) {
              return CalcTab(
                text: buttons[index],
                color: MyColors.tabRed,
                onTap: () {
                  preventNoneNumeric(str: userInput, ref: ref, index: index);
                },
              );
            }
            // 'x' multiply button
            else if (index == 7) {
              return CalcTab(
                text: buttons[index],
                color: MyColors.tabRed,
                onTap: () {
                  preventNoneNumeric(str: userInput, ref: ref, index: index);
                },
              );
            }
            // '-' minus button
            else if (index == 11) {
              return CalcTab(
                text: buttons[index],
                color: MyColors.tabRed,
                onTap: () {
                  preventNoneNumeric(str: userInput, ref: ref, index: index);
                },
              );
            }
            // '+' plus button
            else if (index == 15) {
              return CalcTab(
                text: buttons[index],
                color: MyColors.tabRed,
                onTap: () {
                  preventNoneNumeric(str: userInput, ref: ref, index: index);
                },
              );
            } else if (index == 18) {
              return CalcTab(
                text: buttons[index],
                color: MyColors.white,
                onTap: () {
                  preventNoneNumeric(str: userInput, ref: ref, index: index);
                },
              );
            }
            // '=' equal button
            else if (index == 19) {
              return CalcTab(
                text: buttons[index],
                color: MyColors.tabRed,
                onTap: () {
                  if (userInput.isNotEmpty) {
                    var result = userInput.interpret();
                    print(result);
                    print(result.runtimeType);
                    if (result.isInfinite || result.isNaN) {
                      result = 0;
                    }

                    String finalResult = result
                        .toStringAsFixed(2)
                        .replaceFirst(RegExp(r'\.?0*$'), '');
                    ref.read(userInputProvider.notifier).state = finalResult;
                  }
                },
              );
            }
            // delete number button
            else if (index == 16) {
              return CalcTab(
                text: buttons[index],
                color: MyColors.white,
                onTap: () {
                  if (userInput.isNotEmpty) {
                    ref.read(userInputProvider.notifier).state =
                        userInput.substring(0, userInput.length - 1);
                  }
                },
              );
            } else {
              return CalcTab(
                text: buttons[index],
                color: MyColors.white,
                onTap: () {
                  ref.read(userInputProvider.notifier).state += buttons[index];
                },
              );
            }
          },
        ),
      ),
    );
  }
}

// 3 7 11 14 17
final List<String> buttons = [
  'AC', //0
  '+/-', //1
  '%', //2
  '/', //3
  '7', //4
  '8', //5
  '9', //6
  '*', //7
  '4', //8
  '5', //9
  '6', //10
  '-', //11
  '1', //12
  '2', //13
  '3', //14
  '+', //15
  '⇚', //16
  '0', //17
  '.', //18
  '=', // 19
];
