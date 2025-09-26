import 'package:flutter/material.dart';
import 'video_call_screen.dart';
import 'user_list_screen.dart';

class LoginScreen extends StatefulWidget {
  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final _emailController = TextEditingController();
  final _passController = TextEditingController();
  final _formKey = GlobalKey<FormState>();

  void _login() {
    if (_formKey.currentState!.validate()) {
      Navigator.pushReplacement(context, MaterialPageRoute(builder: (_) => HomeScreen()));
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Login")),
      body: Padding(
        padding: EdgeInsets.all(16),
        child: Form(
          key: _formKey,
          child: Column(
            children: [
              TextFormField(
                controller: _emailController,
                decoration: InputDecoration(labelText: "Email"),
                validator: (v) => v!.isEmpty || !v.contains('@') ? "Enter valid email" : null,
              ),
              TextFormField(
                controller: _passController,
                decoration: InputDecoration(labelText: "Password"),
                obscureText: true,
                validator: (v) => v!.isEmpty ? "Enter password" : null,
              ),
              SizedBox(height: 20),
              ElevatedButton(onPressed: _login, child: Text("Login"))
            ],
          ),
        ),
      ),
    );
  }
}

class HomeScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Home")),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            ElevatedButton(
              child: Text("Video Call"),
              onPressed: () => Navigator.push(context, MaterialPageRoute(builder: (_) => VideoCallScreen())),
            ),
            ElevatedButton(
              child: Text("User List"),
              onPressed: () => Navigator.push(context, MaterialPageRoute(builder: (_) => UserListScreen())),
            )
          ],
        ),
      ),
    );
  }
}
