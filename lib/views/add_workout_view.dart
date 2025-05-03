import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../viewmodels/workout_viewmodel.dart';
import '../models/workout.dart';
import '../widgets/background_container.dart';
import '../widgets/workout_timer.dart';

class AddWorkoutView extends StatefulWidget {
  final Workout? workout;
  final int? index;

  const AddWorkoutView({
    super.key,
    this.workout,
    this.index,
  });

  @override
  State<AddWorkoutView> createState() => _AddWorkoutViewState();
}

class _AddWorkoutViewState extends State<AddWorkoutView> {
  final _formKey = GlobalKey<FormState>();
  final _nameController = TextEditingController();
  final _descriptionController = TextEditingController();
  final _weightController = TextEditingController();
  String _selectedType = 'Cardio';
  DateTime _selectedDate = DateTime.now();
  int _duration = 0;
  double _caloriesBurned = 0.0;

  final List<String> _workoutTypes = [
    'Cardio',
    'Strength',
    'Flexibility',
    'Other',
  ];

  @override
  void initState() {
    super.initState();
    if (widget.workout != null) {
      _nameController.text = widget.workout!.name;
      _descriptionController.text = widget.workout!.description;
      _weightController.text = '70'; // Default weight
      _selectedType = widget.workout!.type;
      _selectedDate = widget.workout!.date;
      _duration = widget.workout!.duration;
      _caloriesBurned = widget.workout!.caloriesBurned;
    } else {
      _weightController.text = '70'; // Default weight
    }
  }

  @override
  void dispose() {
    _nameController.dispose();
    _descriptionController.dispose();
    _weightController.dispose();
    super.dispose();
  }

  void _handleWorkoutComplete(int duration, double calories) {
    setState(() {
      _duration = duration;
      _caloriesBurned = calories;
    });
  }

  void _submitForm() {
    if (_formKey.currentState!.validate()) {
      final workout = Workout(
        name: _nameController.text,
        description: _descriptionController.text,
        date: _selectedDate,
        duration: _duration,
        caloriesBurned: _caloriesBurned,
        type: _selectedType,
      );

      final viewModel = context.read<WorkoutViewModel>();
      if (widget.index != null) {
        viewModel.updateWorkout(widget.index!, workout);
      } else {
        viewModel.addWorkout(workout);
      }
      Navigator.pop(context);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.workout == null ? 'Add Workout' : 'Edit Workout'),
      ),
      body: BackgroundContainer(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(16.0),
          child: Form(
            key: _formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                TextFormField(
                  controller: _nameController,
                  style: const TextStyle(color: Colors.white),
                  decoration: InputDecoration(
                    labelText: 'Workout Name',
                    labelStyle: const TextStyle(color: Colors.white70),
                    border: OutlineInputBorder(
                      borderSide: const BorderSide(color: Colors.white),
                      borderRadius: BorderRadius.circular(8),
                    ),
                    enabledBorder: OutlineInputBorder(
                      borderSide: const BorderSide(color: Colors.white70),
                      borderRadius: BorderRadius.circular(8),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderSide: const BorderSide(color: Colors.white),
                      borderRadius: BorderRadius.circular(8),
                    ),
                  ),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter a workout name';
                    }
                    return null;
                  },
                ),
                const SizedBox(height: 16),
                TextFormField(
                  controller: _descriptionController,
                  style: const TextStyle(color: Colors.white),
                  decoration: InputDecoration(
                    labelText: 'Description',
                    labelStyle: const TextStyle(color: Colors.white70),
                    border: OutlineInputBorder(
                      borderSide: const BorderSide(color: Colors.white),
                      borderRadius: BorderRadius.circular(8),
                    ),
                    enabledBorder: OutlineInputBorder(
                      borderSide: const BorderSide(color: Colors.white70),
                      borderRadius: BorderRadius.circular(8),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderSide: const BorderSide(color: Colors.white),
                      borderRadius: BorderRadius.circular(8),
                    ),
                  ),
                  maxLines: 3,
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter a description';
                    }
                    return null;
                  },
                ),
                const SizedBox(height: 16),
                TextFormField(
                  controller: _weightController,
                  style: const TextStyle(color: Colors.white),
                  decoration: InputDecoration(
                    labelText: 'Weight (kg)',
                    labelStyle: const TextStyle(color: Colors.white70),
                    border: OutlineInputBorder(
                      borderSide: const BorderSide(color: Colors.white),
                      borderRadius: BorderRadius.circular(8),
                    ),
                    enabledBorder: OutlineInputBorder(
                      borderSide: const BorderSide(color: Colors.white70),
                      borderRadius: BorderRadius.circular(8),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderSide: const BorderSide(color: Colors.white),
                      borderRadius: BorderRadius.circular(8),
                    ),
                  ),
                  keyboardType: TextInputType.number,
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter your weight';
                    }
                    if (double.tryParse(value) == null) {
                      return 'Please enter a valid number';
                    }
                    return null;
                  },
                ),
                const SizedBox(height: 16),
                ListTile(
                  title: const Text(
                    'Date',
                    style: TextStyle(color: Colors.white),
                  ),
                  subtitle: Text(
                    '${_selectedDate.year}-${_selectedDate.month}-${_selectedDate.day}',
                    style: const TextStyle(color: Colors.white70),
                  ),
                  trailing: const Icon(Icons.calendar_today, color: Colors.white),
                  onTap: () async {
                    final date = await showDatePicker(
                      context: context,
                      initialDate: _selectedDate,
                      firstDate: DateTime(2000),
                      lastDate: DateTime.now(),
                    );
                    if (date != null) {
                      setState(() {
                        _selectedDate = date;
                      });
                    }
                  },
                ),
                const SizedBox(height: 16),
                DropdownButtonFormField<String>(
                  value: _selectedType,
                  style: const TextStyle(color: Colors.white),
                  dropdownColor: Colors.black87,
                  decoration: InputDecoration(
                    labelText: 'Workout Type',
                    labelStyle: const TextStyle(color: Colors.white70),
                    border: OutlineInputBorder(
                      borderSide: const BorderSide(color: Colors.white),
                      borderRadius: BorderRadius.circular(8),
                    ),
                    enabledBorder: OutlineInputBorder(
                      borderSide: const BorderSide(color: Colors.white70),
                      borderRadius: BorderRadius.circular(8),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderSide: const BorderSide(color: Colors.white),
                      borderRadius: BorderRadius.circular(8),
                    ),
                  ),
                  items: _workoutTypes.map((String type) {
                    return DropdownMenuItem<String>(
                      value: type,
                      child: Text(type),
                    );
                  }).toList(),
                  onChanged: (String? newValue) {
                    if (newValue != null) {
                      setState(() {
                        _selectedType = newValue;
                      });
                    }
                  },
                ),
                const SizedBox(height: 24),
                WorkoutTimer(
                  onWorkoutComplete: _handleWorkoutComplete,
                  workoutType: _selectedType,
                  weight: double.tryParse(_weightController.text) ?? 70.0,
                ),
                const SizedBox(height: 24),
                ElevatedButton(
                  onPressed: _submitForm,
                  style: ElevatedButton.styleFrom(
                    padding: const EdgeInsets.symmetric(vertical: 16),
                    backgroundColor: Theme.of(context).colorScheme.primary,
                    foregroundColor: Theme.of(context).colorScheme.onPrimary,
                  ),
                  child: Text(
                    widget.workout == null ? 'Save Workout' : 'Update Workout',
                    style: const TextStyle(fontSize: 16),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
} 