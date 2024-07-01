import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class CustomTabBar extends StatefulWidget {
  TabController controller;
  List<Tab> tabs;
  List<Widget> tabbarViews;

  CustomTabBar(
      {super.key,
      required this.controller,
      required this.tabbarViews,
      required this.tabs});

  @override
  State<CustomTabBar> createState() => _CustomTabBarState();
}

class _CustomTabBarState extends State<CustomTabBar> {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(
              10.0,
            ),
            color: Colors.grey[300],
          ),
          child: TabBar(
            controller: widget.controller,
            indicatorPadding: const EdgeInsets.all(4),
            indicator: BoxDecoration(
              borderRadius: BorderRadius.circular(
                10.0,
              ),
              color: Colors.white,
            ),
            labelStyle: const TextStyle(
              color: Colors.black,
              fontSize: 16,
              fontWeight: FontWeight.w500,
            ),
            unselectedLabelStyle: const TextStyle(
              color: Colors.grey,
              fontSize: 16,
              fontWeight: FontWeight.w500,
            ),
            tabs: widget.tabs,
          ),
        ),
        Expanded(
          child: TabBarView(
            controller: widget.controller,
            children: widget.tabbarViews,
          ),
        ),
      ],
    );
  }
}
