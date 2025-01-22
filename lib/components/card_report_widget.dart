import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class ReportCard extends StatelessWidget {
  final String imageSrc;
  final String title;
  final String amount;
  final Color color;

  const ReportCard({
    super.key,
    required this.title,
    required this.imageSrc,
    required this.amount,
    this.color = const Color(0xFFf5f5f7),
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 10,
      color: color,
      shadowColor: color,
      child: Padding(
        padding: const EdgeInsets.fromLTRB(8.0, 15.0, 15.0, 0.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(
              width: 50,
              height: 50,
              child: SvgPicture.asset(
                imageSrc,
                semanticsLabel: 'Icon',
                fit: BoxFit.contain,
              ),
            ),
            const SizedBox(
              height: 10,
            ),
            Text(
              title,
              style: const TextStyle(fontSize: 18, color: Colors.black),
            ),
            Row(
              children: [
                Text(
                  amount,
                  style: const TextStyle(
                      color: Colors.black,
                      fontSize: 24,
                      fontWeight: FontWeight.w500),
                ),
                const Spacer(),
                const Icon(Icons.arrow_forward, color: Colors.black),
              ],
            )
          ],
        ),
      ),
    );
  }
}
