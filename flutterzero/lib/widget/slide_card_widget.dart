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
      if (!isPaused) {
        setState(() {
          if (counter > 0) {
            isSlidingSeconds = true; // 초 카드 슬라이드를 시작
            widget.onCounterChange(counter);
          } else {
            timer.cancel();
          }

          if (counter % 60 == 0 && counter != 0) {
            isSlidingMinutes = true; // 분 카드 슬라이드를 시작 (초가 0일 때)
          }
        });

        // 애니메이션이 끝난 후 다시 카드 위치와 투명도를 초기화
        Future.delayed(const Duration(milliseconds: 500), () {
          setState(() {
            isSlidingSeconds = false; // 초 카드 슬라이드 종료
            if (isSlidingMinutes) {
              isSlidingMinutes = false; // 분 카드 슬라이드 종료
            }

            if (counter > 0) {
              counter--;
            }
          });
        });
      }
    });
  }

  void pauseTimer() {
    setState(() {
      isPaused = true;
    });
  }

  void resumeTimer() {
    setState(() {
      isPaused = false;
    });
  }

  void resetTimer() {
    setState(() {
      counter = widget.initialCount;
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
              onPressed: isPaused ? resumeTimer : pauseTimer,
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
