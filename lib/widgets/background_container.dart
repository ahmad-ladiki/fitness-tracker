import 'package:flutter/material.dart';

class BackgroundContainer extends StatelessWidget {
  final Widget child;
  final double opacity;

  const BackgroundContainer({
    super.key,
    required this.child,
    this.opacity = 0.5,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      height: double.infinity,
      decoration: BoxDecoration(
        image: DecorationImage(
          image: const AssetImage('assets/images/backgrounds/Gym.jpg'),
          fit: BoxFit.cover,
          colorFilter: ColorFilter.mode(
            Colors.black.withOpacity(0.2),
            BlendMode.darken,
          ),
        ),
      ),
      child: Theme(
        data: Theme.of(context).copyWith(
          textTheme: Theme.of(context).textTheme.apply(
            bodyColor: Colors.white,
            displayColor: Colors.white,
          ),
          inputDecorationTheme: InputDecorationTheme(
            labelStyle: const TextStyle(color: Colors.white70),
            hintStyle: const TextStyle(color: Colors.white54),
            border: OutlineInputBorder(
              borderSide: const BorderSide(color: Colors.white),
              borderRadius: BorderRadius.circular(8),
            ),
            enabledBorder: OutlineInputBorder(
              borderSide: const BorderSide(color: Colors.white70),
              borderRadius: BorderRadius.circular(8),
            ),
            focusedBorder: OutlineInputBorder(
              borderSide: const BorderSide(color: Colors.white),
              borderRadius: BorderRadius.circular(8),
            ),
          ),
          dropdownMenuTheme: DropdownMenuThemeData(
            textStyle: const TextStyle(color: Colors.white),
            inputDecorationTheme: const InputDecorationTheme(
              labelStyle: TextStyle(color: Colors.white70),
            ),
            menuStyle: MenuStyle(
              backgroundColor: MaterialStateProperty.resolveWith((states) {
                return Colors.black.withOpacity(0.7);
              }),
              elevation: MaterialStateProperty.resolveWith((states) => 0),
            ),
          ),
          popupMenuTheme: const PopupMenuThemeData(
            color: Colors.black87,
            textStyle: TextStyle(
              color: Colors.white,
              fontSize: 16,
            ),
          ),
        ),
        child: child,
      ),
    );
  }
} 