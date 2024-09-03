import 'package:flutter/material.dart';

class MeetingCard extends StatelessWidget {
  final String startHour;
  final String startMinute;
  final String endHour;
  final String endMinute;
  final String meetingTitle;
  final List<String> participants;
  final Color color;

  const MeetingCard(
      {super.key,
      required this.startHour,
      required this.startMinute,
      required this.endHour,
      required this.endMinute,
      required this.meetingTitle,
      required this.participants,
      required this.color});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: color,
        borderRadius: BorderRadius.circular(24),
      ),
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Row(
          spacing: 14,
          children: [
            Column(
              spacing: 6,
              children: [
                Text(
                  startHour,
                  style: const TextStyle(
                    fontSize: 22,
                    height: 0.7,
                    letterSpacing: -1,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                Text(
                  startMinute,
                  style: const TextStyle(
                    fontSize: 14,
                    height: 0.7,
                    fontWeight: FontWeight.w600,
                    letterSpacing: -1,
                  ),
                ),
                Container(
                  width: 0.6,
                  height: 18.0,
                  color: Colors.black,
                ),
                Text(
                  endHour,
                  style: const TextStyle(
                    fontSize: 22,
                    height: 0.7,
                    letterSpacing: -1,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                Text(
                  endMinute,
                  style: const TextStyle(
                    fontSize: 14,
                    height: 0.7,
                    fontWeight: FontWeight.w600,
                    letterSpacing: -1,
                  ),
                ),
                const SizedBox(
                  height: 24,
                )
              ],
            ),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    meetingTitle,
                    style: const TextStyle(
                        fontSize: 48, height: 0.9, fontWeight: FontWeight.w500),
                  ),
                  const SizedBox(
                    height: 28,
                  ),
                  Row(
                    children: participants.map((participant) {
                      final isMe = participant.toUpperCase() == "ME";
                      return Padding(
                        padding: const EdgeInsets.only(right: 24.0),
                        child: Text(
                          participant.toUpperCase(),
                          style: TextStyle(
                            fontSize: 12,
                            color: isMe ? Colors.black : Colors.black54,
                            fontWeight: FontWeight.w700,
                          ),
                        ),
                      );
                    }).toList(),
                  ),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
