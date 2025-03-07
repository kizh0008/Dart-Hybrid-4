import 'package:http/http.dart' as http;
import 'dart:convert';

void main() {
  fetchUsers();
}


class User {
  final int id;
  final String firstName;
  final String lastName;

  User({
    required this.id,
    required this.firstName,
    required this.lastName,
  });

  
  factory User.fromJson(Map<String, dynamic> json) {
    return User(
      id: json['id'] as int,
      firstName: json['first_name'] as String,
      lastName: json['last_name'] as String,
    );
  }

  
  void printDetails() {
    print('ID: $id, First Name: $firstName, Last Name: $lastName');
  }
}

Future<void> fetchUsers() async {
  const String url = 'https://random-data-api.com/api/users/random_user?size=10';

  try {
    final response = await http.get(Uri.parse(url));
    if (response.statusCode == 200) {
      List<dynamic> userListJson = jsonDecode(response.body);
      List<User> users = userListJson.map((json) => User.fromJson(json)).toList();
      for (var user in users) {
        user.printDetails();
      }
    } else {
      print('Failed to fetch users. Status code: ${response.statusCode}');
    }
  } catch (e) {
    print('An error occurred: $e');
  }
}