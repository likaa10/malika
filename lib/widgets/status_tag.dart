import 'package:flutter/material.dart';

class StatusTag extends StatelessWidget {
  final bool isTerlambat;
  final VoidCallback onTap;

  const StatusTag({super.key, required this.isTerlambat, required this.onTap});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
        decoration: BoxDecoration(
          color: isTerlambat ? Colors.red.shade50 : Colors.grey.shade100,
          borderRadius: BorderRadius.circular(20),
        ),
        child: Row(
          children: [
            Text(
              isTerlambat ? "TERLAMBAT" : "HADIR",
              style: TextStyle(
                fontWeight: FontWeight.bold,
                color: isTerlambat ? Colors.red : Colors.grey.shade600,
              ),
            ),
          ],
        ),
      ),
    );
  }
}