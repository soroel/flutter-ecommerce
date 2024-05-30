class AuthenticationRepository {
  // Singleton instance
  static final AuthenticationRepository instance = AuthenticationRepository._internal();

  // Private constructor
  AuthenticationRepository._internal();

  // Method to access the singleton instance
  static AuthenticationRepository getInstance() {
    return instance;
  }

  // Mock user authentication state (replace with your actual authentication logic)
  bool _isAuthenticated = false;

  // Method to check if the user is authenticated
  bool isAuthenticated() {
    return _isAuthenticated;
  }

  // Method to simulate user login (replace with your actual login logic)
  Future<bool> login({required String username, required String password}) async {
    // Simulate network delay
    await Future.delayed(Duration(seconds: 2));

    // Check if the username and password are valid (replace with your actual login logic)
    if (username == 'example' && password == 'password') {
      _isAuthenticated = true;
      return true; // Login successful
    } else {
      _isAuthenticated = false;
      return false; // Login failed
    }
  }

  // Method to simulate user logout (replace with your actual logout logic)
  Future<void> logout() async {
    // Simulate network delay
    await Future.delayed(Duration(seconds: 1));

    // Clear authentication state (replace with your actual logout logic)
    _isAuthenticated = false;
  }
}
