import 'package:flutter/material.dart';

class DesignScreen extends StatefulWidget {
  const DesignScreen({super.key});

  @override
  State<DesignScreen> createState() => _DesignScreenState();
}

class _DesignScreenState extends State<DesignScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(
              height: 20,
            ),
            const Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Icon(Icons.people),
                Icon(Icons.add),
              ],
            ),
            const SizedBox(
              height: 20,
            ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text("Monday 16"),
                Row(
                  spacing: 8,
                  children: [
                    const Text("TODAY"),
                    Center(
                      child: Container(
                        width: 5.0, // 너비 5px
                        height: 5.0, // 높이 5px
                        decoration: const BoxDecoration(
                          color: Color(0xFFB22581), // 빨간색
                          shape: BoxShape.circle, // 원 모양
                        ),
                      ),
                    ),
                    const Text("17"),
                    const Text("18"),
                    const Text("19"),
                    const Text("20"),
                  ],
                )
              ],
            )
          ],
        ),
      ),
    );
  }
}
