import 'package:flutter/material.dart';
import 'package:flutterzero/widget/meeting_card.dart';

class DesignScreen extends StatefulWidget {
  const DesignScreen({super.key});

  @override
  State<DesignScreen> createState() => _DesignScreenState();
}

class _DesignScreenState extends State<DesignScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF1F1F1F),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(10),
          child: Column(
            spacing: 10,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(
                height: 10,
              ),
              const Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Icon(Icons.people),
                  Icon(Icons.add),
                ],
              ),
              Padding(
                padding: const EdgeInsets.all(6),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text(
                      "MONDAY 16",
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 12,
                      ),
                    ),
                    SingleChildScrollView(
                      scrollDirection: Axis.horizontal,
                      child: Row(
                        spacing: 12,
                        children: [
                          Row(
                            spacing: 6,
                            children: [
                              const Text(
                                "TODAY",
                                style: TextStyle(
                                  fontSize: 38,
                                  color: Colors.white,
                                ),
                              ),
                              Center(
                                child: Container(
                                  margin: const EdgeInsets.only(
                                    top: 6,
                                  ),
                                  width: 8.0,
                                  height: 8.0,
                                  decoration: const BoxDecoration(
                                    color: Color(0xFFB22581),
                                    shape: BoxShape.circle,
                                  ),
                                ),
                              ),
                            ],
                          ),
                          Text(
                            "17",
                            style: TextStyle(
                              color: Colors.grey[600],
                              fontSize: 36,
                              fontWeight: FontWeight.w400,
                            ),
                          ),
                          Text(
                            "18",
                            style: TextStyle(
                              color: Colors.grey[600],
                              fontSize: 36,
                              fontWeight: FontWeight.w400,
                            ),
                          ),
                          Text(
                            "19",
                            style: TextStyle(
                              color: Colors.grey[600],
                              fontSize: 36,
                              fontWeight: FontWeight.w400,
                            ),
                          ),
                          Text(
                            "20",
                            style: TextStyle(
                              color: Colors.grey[600],
                              fontSize: 36,
                              fontWeight: FontWeight.w400,
                            ),
                          ),
                          Text(
                            "21",
                            style: TextStyle(
                              color: Colors.grey[600],
                              fontSize: 36,
                              fontWeight: FontWeight.w400,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(
                height: 10,
              ),
              const MeetingCard(
                startHour: "11",
                startMinute: "30",
                endHour: "12",
                endMinute: "20",
                meetingTitle: "DESIGN MEETING",
                participants: ["Alex", "Helena", "Nana"],
                color: Color(0xFFFEF754),
              ),
              const MeetingCard(
                startHour: "12",
                startMinute: "35",
                endHour: "14",
                endMinute: "00",
                meetingTitle: "DAILY PROJECT",
                participants: ["ME", "RICHARD", "CIRY", "+4"],
                color: Color(0xFF9C6BCE),
              ),
              const MeetingCard(
                startHour: "15",
                startMinute: "00",
                endHour: "16",
                endMinute: "30",
                meetingTitle: "WEEKLY PLANNING",
                participants: ["Den", "NANA", "MARK"],
                color: Color(0xFFBCEE4B),
              )
            ],
          ),
        ),
      ),
    );
  }
}
