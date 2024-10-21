import 'package:flutter/material.dart';
import 'package:badges/badges.dart' as badges;

class HomePageAppBarIcon extends StatefulWidget {
  final IconData icon;
  final int? number;

  const HomePageAppBarIcon({
    super.key,
    required this.icon,
    this.number,
  });

  @override
  State<HomePageAppBarIcon> createState() => _HomePageAppBarIconState();
}

class _HomePageAppBarIconState extends State<HomePageAppBarIcon> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 10),
      child: widget.number != null
          ? badges.Badge(
              badgeContent: Text(
                widget.number.toString(),
              ),
              child: Icon(
                widget.icon,
                color: Colors.green,
              ),
            )
          : Icon(
              widget.icon,
              color: Colors.green,
            ),
    );
  }
}
