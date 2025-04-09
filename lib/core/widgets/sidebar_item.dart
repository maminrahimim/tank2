import 'package:flutter/material.dart';

class SidebarItem extends StatelessWidget {
  const SidebarItem({super.key, required this.icon, required this.text, required this.isHovered, required this.onTap});

  final IconData icon;
  final String text;
  final bool isHovered;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.all(15),
        child: SingleChildScrollView(
          scrollDirection: Axis.horizontal,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(icon, color: Colors.white),
              if (isHovered) ...[
                const SizedBox(width: 10),
                Text(text, style: const TextStyle(color: Colors.white)),
                // Add more expanded items here
              ],
            ],
          ),
        ),
      ),
    );
  }
}
