import 'package:flutter/foundation.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'dart:convert';
import '../models/workout.dart';

/// ViewModel class responsible for managing workout data and business logic
/// Uses ChangeNotifier to notify listeners of state changes
class WorkoutViewModel extends ChangeNotifier {
  // SharedPreferences instance for local storage
  final SharedPreferences? _prefs;
  // List to store workout data
  List<Workout> _workouts = [];
  // Loading state indicator
  bool _isLoading = true;
  // Initialization state indicator
  bool _isInitialized = false;
  // Error message for error handling
  String? _errorMessage;

  /// Constructor that takes SharedPreferences instance and initializes the ViewModel
  WorkoutViewModel(this._prefs) {
    _init();
  }

  // Getters for accessing private fields
  List<Workout> get workouts => List.unmodifiable(_workouts);
  bool get isLoading => _isLoading;
  bool get isInitialized => _isInitialized;
  String? get errorMessage => _errorMessage;

  /// Initializes the ViewModel by loading workout data from storage
  Future<void> _init() async {
    if (_prefs == null) {
      _isLoading = false;
      _isInitialized = true;
      notifyListeners();
      return;
    }

    try {
      await _loadWorkouts();
    } catch (e) {
      debugPrint('Error initializing WorkoutViewModel: $e');
      _errorMessage = 'Failed to initialize workouts';
    } finally {
      _isLoading = false;
      _isInitialized = true;
      notifyListeners();
    }
  }

  /// Loads workout data from SharedPreferences
  Future<void> _loadWorkouts() async {
    if (_prefs == null) return;

    try {
      final workoutsJson = _prefs!.getString('workouts');
      if (workoutsJson != null && workoutsJson.isNotEmpty) {
        final List<dynamic> decoded = jsonDecode(workoutsJson);
        if (decoded.isNotEmpty) {
          _workouts = decoded
              .map((json) => Workout.fromJson(json as Map<String, dynamic>))
              .where((workout) => workout.name.isNotEmpty)
              .toList();
          notifyListeners();
        }
      }
    } catch (e) {
      debugPrint('Error loading workouts: $e');
      _errorMessage = 'Failed to load workouts';
      _workouts = [];
      // Clear invalid data
      await _prefs!.remove('workouts');
    }
  }

  /// Saves workout data to SharedPreferences
  Future<void> _saveWorkouts() async {
    if (_prefs == null) return;

    try {
      if (_workouts.isEmpty) {
        final success = await _prefs!.remove('workouts');
        if (!success) {
          _errorMessage = 'Failed to clear workouts';
          notifyListeners();
        }
        return;
      }
      
      final workoutsJson = jsonEncode(_workouts.map((w) => w.toJson()).toList());
      if (workoutsJson.isNotEmpty) {
        final success = await _prefs!.setString('workouts', workoutsJson);
        if (!success) {
          _errorMessage = 'Failed to save workouts';
          notifyListeners();
        }
      }
    } catch (e) {
      debugPrint('Error saving workouts: $e');
      _errorMessage = 'Failed to save workouts';
      notifyListeners();
    }
  }

  /// Adds a new workout to the list and saves to storage
  Future<void> addWorkout(Workout workout) async {
    if (_prefs == null || workout.name.isEmpty) return;
    
    try {
      _workouts.add(workout);
      await _saveWorkouts();
      notifyListeners();
    } catch (e) {
      debugPrint('Error adding workout: $e');
      _errorMessage = 'Failed to add workout';
      _workouts.removeLast();
      notifyListeners();
    }
  }

  /// Updates an existing workout at the specified index
  Future<void> updateWorkout(int index, Workout workout) async {
    if (_prefs == null || index < 0 || index >= _workouts.length || workout.name.isEmpty) return;
    
    try {
      _workouts[index] = workout;
      await _saveWorkouts();
      notifyListeners();
    } catch (e) {
      debugPrint('Error updating workout: $e');
      _errorMessage = 'Failed to update workout';
      await _loadWorkouts();
      notifyListeners();
    }
  }

  /// Deletes a workout at the specified index
  Future<void> deleteWorkout(int index) async {
    if (_prefs == null || index < 0 || index >= _workouts.length) return;
    
    try {
      _workouts.removeAt(index);
      await _saveWorkouts();
      notifyListeners();
    } catch (e) {
      debugPrint('Error deleting workout: $e');
      _errorMessage = 'Failed to delete workout';
      await _loadWorkouts();
      notifyListeners();
    }
  }

  /// Calculates the total calories burned across all workouts
  double getTotalCaloriesBurned() {
    return _workouts.fold(0, (sum, workout) => sum + workout.caloriesBurned);
  }

  /// Calculates the total duration of all workouts in minutes
  int getTotalWorkoutTime() {
    return _workouts.fold(0, (sum, workout) => sum + workout.duration);
  }

  /// Generates a distribution of workout types and their counts
  Map<String, int> getWorkoutTypeDistribution() {
    Map<String, int> distribution = {};
    for (var workout in _workouts) {
      distribution[workout.type] = (distribution[workout.type] ?? 0) + 1;
    }
    return distribution;
  }
} 