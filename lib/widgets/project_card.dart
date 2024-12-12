import 'package:flutter/material.dart';
import 'package:home_page/constants.dart';
import 'package:home_page/widgets/extensions.dart';


class ProjectCard extends StatelessWidget {
  const ProjectCard({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(children: [
      SizedBox(height: MediaQuery.sizeOf(context).width * 0.02),
      Text("Here’s a rephrased version with an alternative for 'WELCOME'",  style: TextStyle(
          fontSize: 22.adjust(),
          color: Colors.white.withOpacity(0.8))),
      SizedBox(height: MediaQuery.sizeOf(context).width * 0.01),
      Text("${Constants.Descriptions}",  style: TextStyle(
          fontSize: 18.adjust(),
          color: Colors.white.withOpacity(0.8)))
    ],);  }
}
