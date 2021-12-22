import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:vncitizens_authentication/src/controllers/authentication_controller.dart';
import 'package:vncitizens_authentication/vncitizens_authentication.dart';

class SignIn extends GetView<AuthenticationController> {
  final usernameController = TextEditingController();
  final passwordController = TextEditingController();

  SignIn({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          flexibleSpace: const Image(
            image: NetworkImage(
                'https://raw.githubusercontent.com/huuln9/images/main/banner_2.png'),
            fit: BoxFit.cover,
          ),
          leading: IconButton(
            icon: const Icon(
              Icons.arrow_back_ios,
              color: Colors.white,
            ),
            onPressed: () => Navigator.of(context).pop(),
          ),
          title: const Align(
            alignment: Alignment.centerLeft,
            child: Text(
              "Đăng nhập",
              style: TextStyle(fontSize: 20, color: Colors.white),
            ),
          ),
        ),
        body: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              TextField(
                controller: usernameController,
                decoration: const InputDecoration(
                  labelText: 'Tài khoản',
                  hintText: 'Nhập tài khoản đăng ký',
                ),
              ),
              const Padding(padding: EdgeInsets.all(10)),
              _PasswordInput(controller: passwordController),
              const Padding(padding: EdgeInsets.all(15)),
              Obx(() {
                switch (controller.process.value) {
                  case AuthenticationProcess.loading:
                    return const CircularProgressIndicator();
                  case AuthenticationProcess.failure:
                    return const Text(
                      "Tài khoản hoặc mật khẩu không chính xác!",
                      style: TextStyle(fontSize: 18, color: Colors.red),
                    );
                  default:
                    return Container();
                }
              }),
              const Spacer(),
              ElevatedButton(
                onPressed: () => controller.signInWithPassword(
                  username: usernameController.text,
                  password: passwordController.text,
                ),
                child: const Padding(
                  padding: EdgeInsets.all(10.0),
                  child: Text(
                    "Đăng Nhập",
                    style: TextStyle(fontSize: 18),
                  ),
                ),
                style: ElevatedButton.styleFrom(fixedSize: const Size(250, 50)),
              ),
              const Padding(padding: EdgeInsets.all(10)),
              ElevatedButton(
                onPressed: () => {},
                child: const Padding(
                  padding: EdgeInsets.all(10.0),
                  child: Text(
                    "Đăng Ký Tài Khoản",
                    style: TextStyle(color: Colors.black, fontSize: 18),
                  ),
                ),
                style: ElevatedButton.styleFrom(
                  primary: Colors.white,
                  side: const BorderSide(color: Colors.blue),
                  fixedSize: const Size(250, 50),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _PasswordInput extends StatefulWidget {
  final TextEditingController controller;

  const _PasswordInput({Key? key, required this.controller}) : super(key: key);

  @override
  _PasswordInputState createState() => _PasswordInputState();
}

class _PasswordInputState extends State<_PasswordInput> {
  bool _showPassword = false;

  @override
  Widget build(BuildContext context) {
    return TextField(
      controller: widget.controller,
      obscureText: !_showPassword,
      decoration: InputDecoration(
        labelText: 'Mật khẩu',
        hintText: 'Nhập mật khẩu',
        suffixIcon: IconButton(
            icon: Icon(
              _showPassword ? Icons.visibility : Icons.visibility_off,
              color: Theme.of(context).primaryColorDark,
            ),
            onPressed: () {
              setState(() {
                _showPassword = !_showPassword;
              });
            }),
      ),
    );
  }
}
