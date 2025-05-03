import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'dart:convert';
import '../models/user.dart';

/// Manages the authentication state and user data for the application.
/// This ViewModel handles user login, signup, and logout operations,
/// and persists user data using SharedPreferences.
class AuthViewModel with ChangeNotifier {
  /// The currently logged-in user, null if no user is logged in
  User? _currentUser;
  
  /// Indicates whether a user is currently logged in
  bool _isLoggedIn = false;
  
  /// Stores any error messages that occur during authentication operations
  String? _errorMessage;
  
  /// SharedPreferences instance for local storage of user data
  final SharedPreferences? _prefs;
  
  /// Indicates whether the ViewModel has completed its initialization
  bool _isInitialized = false;

  /// Creates a new AuthViewModel instance with the provided SharedPreferences
  AuthViewModel(this._prefs) {
    _init();
  }

  /// Getter for the current user
  User? get currentUser => _currentUser;
  
  /// Getter for the login status
  bool get isLoggedIn => _isLoggedIn;
  
  /// Getter for any error messages
  String? get errorMessage => _errorMessage;
  
  /// Getter for the initialization status
  bool get isInitialized => _isInitialized;

  /// Initializes the ViewModel by loading user data from storage
  Future<void> _init() async {
    if (_prefs == null) {
      _isInitialized = true;
      notifyListeners();
      return;
    }

    try {
      await _loadUser();
    } catch (e) {
      debugPrint('Error initializing AuthViewModel: $e');
    } finally {
      _isInitialized = true;
      notifyListeners();
    }
  }

  /// Loads user data from SharedPreferences storage
  Future<void> _loadUser() async {
    if (_prefs == null) return;

    try {
      final userJson = _prefs!.getString('user');
      if (userJson != null && userJson.isNotEmpty) {
        final userData = jsonDecode(userJson) as Map<String, dynamic>;
        _currentUser = User.fromJson(userData);
        _isLoggedIn = true;
        notifyListeners();
      }
    } catch (e) {
      debugPrint('Error loading user: $e');
      // Clear invalid data
      await _prefs!.remove('user');
    }
  }

  /// Registers a new user and stores their data
  Future<void> signUp(User user) async {
    if (_prefs == null) {
      _errorMessage = 'Storage not available';
      notifyListeners();
      return;
    }

    try {
      final userJson = jsonEncode(user.toJson());
      await _prefs!.setString('user', userJson);
      _currentUser = user;
      _isLoggedIn = true;
      notifyListeners();
    } catch (e) {
      _errorMessage = 'Failed to sign up: ${e.toString()}';
      notifyListeners();
    }
  }

  /// Authenticates a user with their email and password
  Future<void> login(String email, String password) async {
    if (_prefs == null) {
      _errorMessage = 'Storage not available';
      notifyListeners();
      return;
    }

    try {
      final userJson = _prefs!.getString('user');
      if (userJson != null && userJson.isNotEmpty) {
        final userData = jsonDecode(userJson) as Map<String, dynamic>;
        final user = User.fromJson(userData);
        if (user.email == email && user.password == password) {
          _currentUser = user;
          _isLoggedIn = true;
          notifyListeners();
        } else {
          _errorMessage = 'Invalid email or password';
          notifyListeners();
        }
      } else {
        _errorMessage = 'No user found';
        notifyListeners();
      }
    } catch (e) {
      _errorMessage = 'Failed to login: ${e.toString()}';
      notifyListeners();
    }
  }

  /// Logs out the current user and clears their data
  Future<void> logout() async {
    if (_prefs == null) {
      _errorMessage = 'Storage not available';
      notifyListeners();
      return;
    }

    try {
      _currentUser = null;
      _isLoggedIn = false;
      notifyListeners();
    } catch (e) {
      _errorMessage = 'Failed to logout: ${e.toString()}';
      notifyListeners();
    }
  }

  /// Displays any error messages in a SnackBar
  void showError(BuildContext context) {
    if (_errorMessage != null) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(_errorMessage!),
          backgroundColor: Colors.red,
          behavior: SnackBarBehavior.floating,
          duration: const Duration(seconds: 3),
        ),
      );
    }
  }
} 