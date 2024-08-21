import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:stopwatch/controller/stopwatchcontroller.dart';

class StopwatchHome extends StatelessWidget {
  final StopwatchController stopwatchController = Get.put(StopwatchController());

  StopwatchHome({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            SizedBox(height: 30,),
            
            const SizedBox(height: 20),
            Expanded(
              child: Center(
                child: Obx(() {
                  var minutes = (stopwatchController.elapsedTime.value ~/ 60000).toString().padLeft(2, '0');
                  var seconds = ((stopwatchController.elapsedTime.value % 60000) ~/ 1000).toString().padLeft(2, '0');
                  var milliseconds = (stopwatchController.elapsedTime.value % 1000).toString().padLeft(3, '0');
                  return Container(
                    width: 300, // Taille du cercle
                    height: 300, // Taille du cercle
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      gradient: const RadialGradient(
                        colors: [Colors.purple, Colors.black],
                        center: Alignment(-0.3, -0.3),
                        focal: Alignment(-0.1, -0.1),
                        focalRadius: 2,
                      ),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.purple.withOpacity(0.6),
                          offset: const Offset(0, 6),
                          blurRadius: 12,
                          spreadRadius: 3,
                        ),
                      ],
                    ),
                    child: Center(
                      child: Transform(
                        transform: Matrix4.identity()
                          ..setEntry(3, 2, 0.001) // Perspective
                          ..rotateX(0.1)
                          ..rotateY(-0.2),
                        alignment: Alignment.center,
                        child: Text(
                          '$minutes:$seconds:$milliseconds',
                          style: const TextStyle(fontSize: 50.0, fontWeight: FontWeight.bold, color: Colors.white),
                        ),
                      ),
                    ),
                  );
                }),
              ),
            ),
            const SizedBox(height: 40),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Obx(() => ElevatedButton(
                  onPressed: stopwatchController.toggleStopwatch,
                  style: ElevatedButton.styleFrom(
                    backgroundColor: stopwatchController.isRunning.value ? Colors.black : Colors.purple,
                    padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 15),
                    textStyle: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                  ),
                  child: Text(stopwatchController.isRunning.value ? 'Stop' : 'Start'),
                )),
                const SizedBox(width: 20),
                ElevatedButton(
                  onPressed: stopwatchController.resetStopwatch,
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.black,
                    padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 15),
                    textStyle: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                  ),
                  child: const Text('Reset'),
                ),
                const SizedBox(width: 20),
                ElevatedButton(
                  onPressed: stopwatchController.recordLap,
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.purple,
                    padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 15),
                    textStyle: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                  ),
                  child: const Text('Lap'),
                ),
              ],
            ),
            const SizedBox(height: 40),
            Expanded(
              child: Obx(() => ListView.builder(
                itemCount: stopwatchController.laps.length,
                itemBuilder: (context, index) {
                  return Card(
                    margin: const EdgeInsets.symmetric(vertical: 5, horizontal: 20),
                    child: ListTile(
                      title: Text(
                        'Lap ${index + 1}: ${stopwatchController.laps[index]}',
                        style: const TextStyle(fontSize: 20),
                      ),
                    ),
                  );
                },
              )),
            ),
          ],
        ),
      ),
    );
  }
}
