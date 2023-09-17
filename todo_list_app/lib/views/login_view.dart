import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:todo_list_app/views/task_list_view.dart';
import '../services/auth_service.dart';

class LoginView extends StatelessWidget {
  final AuthService _authService = AuthService();

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: _authService.getCurrentUser(),
      builder: (context, AsyncSnapshot<User?> snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return CircularProgressIndicator(); // show loader while checking
        }
        if (snapshot.hasData && snapshot.data != null) {
          // Navigate to TaskListView if user is already authenticated
          WidgetsBinding.instance?.addPostFrameCallback((_) {
            Navigator.pushReplacement(
              context,
              MaterialPageRoute(builder: (context) => TaskListView()),
            );
          });
          return SizedBox.shrink(); // returning an empty widget
        }
        return buildLoginUI(context);
      },
    );
  }

  Widget buildLoginUI(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Todo List App'),
        centerTitle: true,
      ),
      body: Center(
        child: Column(
          children: [
            SizedBox(height: 150.0),
            Image.asset('assets/logo.png', height: 150.0),
            SizedBox(height: 30.0),
            ElevatedButton.icon(
              icon: Image.asset('assets/google.png', height: 24.0),
              label: Text("Sign in with Google"),
              style: ElevatedButton.styleFrom(
                primary: Colors.white,
                onPrimary: Colors.black54,
                side: BorderSide(color: Colors.black54),
                elevation: 1.0,
              ),
              onPressed: () async {
                final user = await _authService.signInWithGoogle();
                if (user != null) {
                  Navigator.pushReplacement(
                    context,
                    MaterialPageRoute(builder: (context) => TaskListView()),
                  );
                } else {
                  // Error occurred during sign-in
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(content: Text('Error occurred during sign-in')),
                  );
                }
              },
            ),
          ],
        ),
      ),
    );
  }
}
