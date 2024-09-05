import 'dart:async';
import 'package:flutter/material.dart';

class SlideCardWidget extends StatefulWidget {
  final int initialCount; // 총 카운트 (초 단위)
  final Color cardColor;
  final double width;
  final double height;
  final Function(int) onCounterChange;

  const SlideCardWidget({
    super.key,
    this.initialCount = 600, // 예: 10분 = 600초
    this.cardColor = Colors.blueAccent,
    this.width = 200,
    this.height = 300,
    required this.onCounterChange,
  });

  @override
  _SlideCardWidgetState createState() => _SlideCardWidgetState();
}

class _SlideCardWidgetState extends State<SlideCardWidget> {
  late int counter;
  bool isSlidingSeconds = false; // 초 카드 슬라이드 여부
  bool isSlidingMinutes = false; // 분 카드 슬라이드 여부
  bool isPaused = true; // 일시정지 여부
  late Timer timer;
  int selectedMinutes = 10; // 선택된 분
  int pomodoroCount = 0;

  final List<int> minuteOptions = [5, 10, 15, 20, 25, 30]; // 시간 선택 옵션

  @override
  void initState() {
    super.initState();
    counter = widget.initialCount;
    startSliding();
  }

  @override
  void dispose() {
    timer.cancel();
    super.dispose();
  }

  void startSliding() {
    timer = Timer.periodic(const Duration(seconds: 1), (timer) {
      setState(() {
        if (counter > 1) {
          isSlidingSeconds = true;
          if (counter % 60 == 0 && counter != 0) {
            isSlidingMinutes = true;
          }

          Future.delayed(const Duration(milliseconds: 500), () {
            setState(() {
              if (counter > 0) {
                counter--;
              }
              isSlidingSeconds = false;
              if (isSlidingMinutes) {
                isSlidingMinutes = false;
              }
            });
          });
        } else {
          isPaused = true;
          counter = selectedMinutes * 60;
          timer.cancel();
          pomodoroCount = pomodoroCount + 1;
          widget.onCounterChange(pomodoroCount);
          return;
        }
      });
    });
  }

  void pauseTimer() {
    setState(() {
      isPaused = true; // 타이머 일시정지
      timer.cancel(); // 타이머 취소
    });
  }

  void resumeTimer() {
    setState(() {
      if (isPaused) {
        isPaused = false; // 타이머 재개
        if (!timer.isActive) {
          startSliding(); // 타이머 다시 시작
        }
      }
    });
  }

  void resetTimer() {
    setState(() {
      counter = selectedMinutes * 60; // 선택된 시간으로 초기화
      isPaused = true; // 초기화 후 일시정지 상태로 전환
      timer.cancel(); // 타이머가 작동 중이면 취소
    });
  }

  void selectMinutes(int minutes) {
    setState(() {
      selectedMinutes = minutes;
      counter = selectedMinutes * 60; // 선택된 시간으로 카운터 초기화
      isPaused = true; // 시간 선택 후 일시정지 상태로 유지
      timer.cancel(); // 타이머가 이미 작동 중이면 취소
    });
  }

  String getMinutes() {
    int minutes = (counter ~/ 60); // 분 계산
    return minutes.toString().padLeft(2, '0'); // 2자리로 패딩
  }

  String getSeconds() {
    int seconds = counter % 60; // 초 계산
    return seconds.toString().padLeft(2, '0'); // 2자리로 패딩
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        // 시간 선택 스크롤 영역
        SizedBox(
          height: 80,
          child: ListView.builder(
            scrollDirection: Axis.horizontal,
            itemCount: minuteOptions.length,
            itemBuilder: (context, index) {
              bool isSelected = minuteOptions[index] == selectedMinutes;
              return GestureDetector(
                onTap: () {
                  if (isPaused) {
                    setState(() {
                      selectedMinutes = minuteOptions[index];
                      selectMinutes(selectedMinutes);
                    });
                  }
                },
                child: AnimatedContainer(
                  duration: const Duration(milliseconds: 300),
                  width: isSelected ? 80 : 60, // 선택된 시간은 더 크게 표시
                  height: isSelected ? 80 : 60,
                  margin: const EdgeInsets.symmetric(horizontal: 10),
                  decoration: BoxDecoration(
                    color: isSelected ? Colors.blueAccent : Colors.grey,
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: Center(
                    child: Text(
                      '${minuteOptions[index]}',
                      style: TextStyle(
                        fontSize: isSelected ? 28 : 22, // 선택된 시간은 더 크게 표시
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ),
              );
            },
          ),
        ),
        const SizedBox(height: 20),
        // 카드 슬라이드 표시
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            // 왼쪽 분 카드
            Stack(
              children: [
                AnimatedSlide(
                  offset: isSlidingMinutes
                      ? const Offset(-1.5, 0)
                      : Offset.zero, // 왼쪽으로 이동
                  duration: isSlidingMinutes
                      ? const Duration(milliseconds: 500)
                      : const Duration(milliseconds: 0),
                  child: AnimatedOpacity(
                    opacity: isSlidingMinutes ? 0.0 : 1.0, // 사라지면서 투명도 조절
                    duration: const Duration(milliseconds: 500),
                    child: Container(
                      width: widget.width,
                      height: widget.height,
                      decoration: BoxDecoration(
                        color: widget.cardColor,
                        borderRadius: BorderRadius.circular(15),
                        boxShadow: const [
                          BoxShadow(
                            color: Colors.black26,
                            offset: Offset(0, 4),
                            blurRadius: 10,
                          ),
                        ],
                      ),
                      child: Center(
                        child: Text(
                          getMinutes(), // 분 형식으로 출력
                          style: const TextStyle(
                            fontSize: 60,
                            color: Colors.white,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
            const Text(
              ":",
              style: TextStyle(
                color: Colors.white,
                fontSize: 80,
              ),
            ),
            // 오른쪽 초 카드
            Stack(
              children: [
                AnimatedSlide(
                  offset: isSlidingSeconds
                      ? const Offset(1.5, 0)
                      : Offset.zero, // 오른쪽으로 이동
                  duration: isSlidingSeconds
                      ? const Duration(milliseconds: 500)
                      : const Duration(milliseconds: 0),
                  child: AnimatedOpacity(
                    opacity: isSlidingSeconds ? 0.0 : 1.0, // 사라지면서 투명도 조절
                    duration: const Duration(milliseconds: 500),
                    child: Container(
                      width: widget.width,
                      height: widget.height,
                      decoration: BoxDecoration(
                        color: widget.cardColor,
                        borderRadius: BorderRadius.circular(15),
                        boxShadow: const [
                          BoxShadow(
                            color: Colors.black26,
                            offset: Offset(0, 4),
                            blurRadius: 10,
                          ),
                        ],
                      ),
                      child: Center(
                        child: Text(
                          getSeconds(), // 초 형식으로 출력
                          style: const TextStyle(
                            fontSize: 60,
                            color: Colors.white,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
        const SizedBox(height: 20),
        // 버튼들
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            ElevatedButton(
              onPressed: () {
                setState(() {
                  if (isPaused) {
                    resumeTimer(); // 재생
                  } else {
                    pauseTimer(); // 일시정지
                  }
                });
              },
              style: ElevatedButton.styleFrom(
                fixedSize: const Size(120, 50),
              ),
              child: Text(isPaused ? '재생' : '일시정지'),
            ),
            const SizedBox(width: 20),
            ElevatedButton(
              onPressed: isPaused ? resetTimer : null,
              style: ElevatedButton.styleFrom(
                fixedSize: const Size(120, 50),
              ),
              child: const Text('초기화'),
            ),
          ],
        ),
      ],
    );
  }
}
