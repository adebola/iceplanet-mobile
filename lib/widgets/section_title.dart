import 'package:flutter/material.dart';
import '../constants/app_colors.dart';

class SectionTitle extends StatelessWidget {
  final String title; // Add a title property

  const SectionTitle({
    super.key,
    required this.title, // Require the title in the constructor
  });

  @override
  Widget build(BuildContext context) {
    return Text(
      title, // Use the title property here
      style: const TextStyle(
        color: AppColors.groceryTitle,
        fontSize: 16,
        fontWeight: FontWeight.w600, // Use FontWeight.w600 for 600 weight
      ),
    );
  }
}
