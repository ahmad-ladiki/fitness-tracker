import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:intl/intl.dart';
import '../viewmodels/workout_viewmodel.dart';
import 'add_workout_view.dart';
import '../widgets/background_container.dart';

class WorkoutListView extends StatelessWidget {
  const WorkoutListView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('My Workouts'),
        actions: [
          IconButton(
            icon: const Icon(Icons.add),
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => const AddWorkoutView(),
                ),
              );
            },
          ),
        ],
      ),
      body: BackgroundContainer(
        child: Consumer<WorkoutViewModel>(
          builder: (context, viewModel, child) {
            final workouts = viewModel.workouts;
            
            if (workouts.isEmpty) {
              return const Center(
                child: Text(
                  'No workouts yet. Add your first workout!',
                  style: TextStyle(color: Colors.white),
                ),
              );
            }

            return ListView.builder(
              itemCount: workouts.length,
              itemBuilder: (context, index) {
                final workout = workouts[index];
                return Dismissible(
                  key: Key('$index'),
                  direction: DismissDirection.endToStart,
                  background: Container(
                    color: Colors.red,
                    alignment: Alignment.centerRight,
                    padding: const EdgeInsets.only(right: 16),
                    child: const Icon(
                      Icons.delete,
                      color: Colors.white,
                    ),
                  ),
                  onDismissed: (direction) {
                    viewModel.deleteWorkout(index);
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(content: Text('Workout deleted')),
                    );
                  },
                  child: Card(
                    margin: const EdgeInsets.symmetric(
                      horizontal: 16,
                      vertical: 8,
                    ),
                    color: Colors.black54,
                    child: ListTile(
                      title: Text(
                        workout.name,
                        style: const TextStyle(color: Colors.white),
                      ),
                      subtitle: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            workout.description,
                            style: const TextStyle(color: Colors.white70),
                          ),
                          const SizedBox(height: 4),
                          Text(
                            'Date: ${DateFormat('MMM dd, yyyy').format(workout.date)}',
                            style: const TextStyle(color: Colors.white70),
                          ),
                          Text(
                            'Duration: ${workout.duration} minutes',
                            style: const TextStyle(color: Colors.white70),
                          ),
                          Text(
                            'Calories: ${workout.caloriesBurned.toStringAsFixed(1)}',
                            style: const TextStyle(color: Colors.white70),
                          ),
                          Text(
                            'Type: ${workout.type}',
                            style: const TextStyle(color: Colors.white70),
                          ),
                        ],
                      ),
                      trailing: IconButton(
                        icon: const Icon(Icons.edit, color: Colors.white),
                        onPressed: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => AddWorkoutView(
                                workout: workout,
                                index: index,
                              ),
                            ),
                          );
                        },
                      ),
                    ),
                  ),
                );
              },
            );
          },
        ),
      ),
    );
  }
} 