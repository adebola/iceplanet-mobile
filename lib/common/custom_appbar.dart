import 'package:flutter/material.dart';
import '../constants/app_colors.dart';

class CustomAppBar extends StatelessWidget implements PreferredSizeWidget {
  final String appBarName;

  const CustomAppBar({super.key, required this.appBarName});

  @override
  Widget build(BuildContext context) {
    return AppBar(
      backgroundColor: AppColors.groceryWhite,
      elevation: 2,
      centerTitle: true,
      title: Align(
        alignment: Alignment.topLeft,
        child: Text(
          appBarName,
          style: const TextStyle(
              color: AppColors.groceryTitle,
              fontSize: 18,
              fontWeight: FontWeight.w600),
        ),
      ),
      leading: IconButton(
        icon: const Icon(Icons.arrow_back),
        onPressed: () {
          // Handle back button press, typically by popping the current route
          Navigator.of(context).pop();
        },
      ),
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}
