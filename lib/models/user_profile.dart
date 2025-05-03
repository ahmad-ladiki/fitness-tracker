/// Represents a user's profile information in the fitness tracking application.
/// This model contains essential user data that is displayed in the profile view
/// and used throughout the application for personalization.
class UserProfile {
  /// The user's full name
  final String name;
  
  /// The user's age in years
  final int age;
  
  /// The user's gender (e.g., 'Male', 'Female')
  final String gender;
  
  /// Optional path to the user's profile image
  /// This can be null if the user hasn't uploaded a profile picture
  final String? profileImage;

  /// Creates a new UserProfile instance with the specified properties
  UserProfile({
    required this.name,
    required this.age,
    required this.gender,
    this.profileImage,
  });

  /// Creates a copy of this UserProfile with the given fields replaced with the new values.
  /// This is useful for updating specific fields while keeping others unchanged.
  UserProfile copyWith({
    String? name,
    int? age,
    String? gender,
    String? profileImage,
  }) {
    return UserProfile(
      name: name ?? this.name,
      age: age ?? this.age,
      gender: gender ?? this.gender,
      profileImage: profileImage ?? this.profileImage,
    );
  }
} 