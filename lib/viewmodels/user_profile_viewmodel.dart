import 'package:flutter/foundation.dart';
import '../models/user_profile.dart';

class UserProfileViewModel extends ChangeNotifier {
  UserProfile? _userProfile;

  UserProfile? get userProfile => _userProfile;

  void updateProfile(UserProfile profile) {
    _userProfile = profile;
    notifyListeners();
  }
} 