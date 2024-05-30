import 'package:flutter/material.dart';

class DetailCard extends StatelessWidget {
  final String title;
  final String description;

  const DetailCard({
    Key? key,
    required this.title,
    required this.description,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {

    return Container(
      width: 120.0,
      height: 2,
      padding: const EdgeInsets.all(8.0),
      margin: EdgeInsets.symmetric(horizontal: 20.0),
      decoration: BoxDecoration(
        color: Colors.purple[200],
        borderRadius: BorderRadius.circular(10),
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(title, style: TextStyle(color: Colors.white, fontSize: 18, fontWeight: FontWeight.bold)),
          SizedBox(height: 4),
          Text(description, style: TextStyle(color: Colors.white70, fontSize: 16)),
        ],
      ),
    );
  }
}
