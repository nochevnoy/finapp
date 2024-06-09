import 'package:auto_route/auto_route.dart';
import 'package:finapp/app/navigation/router.dart';
import 'package:finapp/features/core/theme/fin_colors.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class FinAppBar extends StatelessWidget {
  final String? title;
  final bool hideActions;

  const FinAppBar({
    super.key,
    this.title,
    this.hideActions = false,
  });

  static PreferredSizeWidget withPreferredSize({
    required BuildContext context,
    String? title,
    Key? key,
    bool hideActions = false,
  }) {
    return PreferredSize(
      preferredSize: const Size.fromHeight(60),
      child: FinAppBar(
        key: key,
        title: title,
        hideActions: hideActions,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return AppBar(
      title: Text(title ?? 'FinApp'),
      backgroundColor: FinColors.gray1,
      actions: hideActions
          ? null
          : [
              CupertinoButton(
                padding: const EdgeInsets.only(left: 8.0, right: 8.0),
                color: FinColors.lightBlue,
                onPressed: () {
                  context.router.push(const FinAppCategoriesRoute());
                },
                child: const Text('Категории'),
              ),
              const SizedBox(width: 16.0),
            ],
    );
  }
}
