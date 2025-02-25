class AuthService {
  AuthService._privateConstructor();
  static final AuthService _instance = AuthService._privateConstructor();
  static AuthService get instance => _instance;
  final Map<String, Map<String, String>> _users = {};
  void register(String email, String password, String nickname) {
    _users[email] = {
      'password': password,
      'nickname': nickname,
    };
  }

  bool login(String email, String password) {
    if (_users.containsKey(email) && _users[email]!['password'] == password) {
      return true; 
    }
    return false; 
  }

  Map<String, String>? getUserData(String email) {
    return _users[email];
  }
}