import 'package:flutter/material.dart';
import 'dart:async';

class WorkoutTimer extends StatefulWidget {
  final Function(int duration, double calories) onWorkoutComplete;
  final String workoutType;
  final double weight; // in kg

  const WorkoutTimer({
    super.key,
    required this.onWorkoutComplete,
    required this.workoutType,
    required this.weight,
  });

  @override
  State<WorkoutTimer> createState() => _WorkoutTimerState();
}

class _WorkoutTimerState extends State<WorkoutTimer> {
  Timer? _timer;
  int _seconds = 0;
  bool _isRunning = false;
  double _caloriesBurned = 0.0;

  // MET values for different workout types (Metabolic Equivalent of Task)
  final Map<String, double> _metValues = {
    'Cardio': 8.0,
    'Strength': 6.0,
    'Flexibility': 3.0,
    'Other': 5.0,
  };

  @override
  void dispose() {
    _timer?.cancel();
    super.dispose();
  }

  void _startTimer() {
    _timer = Timer.periodic(const Duration(seconds: 1), (timer) {
      setState(() {
        _seconds++;
        _calculateCalories();
      });
    });
    setState(() {
      _isRunning = true;
    });
  }

  void _stopTimer() {
    _timer?.cancel();
    setState(() {
      _isRunning = false;
    });
    widget.onWorkoutComplete(_seconds ~/ 60, _caloriesBurned);
  }

  void _resetTimer() {
    _timer?.cancel();
    setState(() {
      _seconds = 0;
      _caloriesBurned = 0.0;
      _isRunning = false;
    });
  }

  void _calculateCalories() {
    // Formula: Calories = MET * weight(kg) * time(hours)
    final metValue = _metValues[widget.workoutType] ?? 5.0;
    final hours = _seconds / 3600;
    setState(() {
      _caloriesBurned = metValue * widget.weight * hours;
    });
  }

  String _formatTime(int seconds) {
    final hours = seconds ~/ 3600;
    final minutes = (seconds % 3600) ~/ 60;
    final remainingSeconds = seconds % 60;
    return '${hours.toString().padLeft(2, '0')}:${minutes.toString().padLeft(2, '0')}:${remainingSeconds.toString().padLeft(2, '0')}';
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    
    return Card(
      margin: const EdgeInsets.all(16),
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(
              'Workout Timer',
              style: theme.textTheme.titleLarge,
            ),
            const SizedBox(height: 16),
            Text(
              _formatTime(_seconds),
              style: theme.textTheme.displayMedium?.copyWith(
                color: theme.colorScheme.primary,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 16),
            Text(
              'Calories Burned: ${_caloriesBurned.toStringAsFixed(1)} kcal',
              style: theme.textTheme.titleMedium,
            ),
            const SizedBox(height: 24),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                ElevatedButton.icon(
                  onPressed: _isRunning ? null : _startTimer,
                  icon: const Icon(Icons.play_arrow),
                  label: const Text('Start'),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: theme.colorScheme.primary,
                    foregroundColor: theme.colorScheme.onPrimary,
                  ),
                ),
                ElevatedButton.icon(
                  onPressed: _isRunning ? _stopTimer : null,
                  icon: const Icon(Icons.stop),
                  label: const Text('Stop'),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: theme.colorScheme.error,
                    foregroundColor: theme.colorScheme.onError,
                  ),
                ),
                ElevatedButton.icon(
                  onPressed: _resetTimer,
                  icon: const Icon(Icons.refresh),
                  label: const Text('Reset'),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: theme.colorScheme.secondary,
                    foregroundColor: theme.colorScheme.onSecondary,
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
} 