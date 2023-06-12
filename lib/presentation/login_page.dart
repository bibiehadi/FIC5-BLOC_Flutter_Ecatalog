import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_ecatalog/bloc/login/login_bloc.dart';
import 'package:flutter_ecatalog/data/datasources/local_datasource.dart';
import 'package:flutter_ecatalog/data/model/request/login_request_model.dart';
import 'package:flutter_ecatalog/presentation/home_page.dart';
import 'package:flutter_ecatalog/presentation/register_page.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  TextEditingController emailController = TextEditingController();

  TextEditingController passwordController = TextEditingController();

  bool isObsecured = true;

  @override
  void initState() {
    checkAuth();
    super.initState();
  }

  void checkAuth() async {
    final token = await LocalDatasource().getToken();
    if (token.isNotEmpty) {
      Navigator.of(context).pushReplacement(
        MaterialPageRoute(
          builder: (context) => const HomePage(),
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Login Page'),
      ),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Center(
                child: Text('Login User'),
              ),
              const SizedBox(
                height: 16,
              ),
              TextField(
                decoration: const InputDecoration(labelText: 'Email'),
                controller: emailController,
              ),
              const SizedBox(
                height: 8,
              ),
              TextField(
                decoration: InputDecoration(
                  labelText: 'Password',
                  suffixIcon: IconButton(
                    onPressed: () {
                      setState(() {
                        isObsecured = !isObsecured;
                      });
                    },
                    icon: isObsecured
                        ? const Icon(Icons.visibility)
                        : const Icon(Icons.visibility_off),
                  ),
                ),
                controller: passwordController,
                obscureText: isObsecured,
              ),
              const SizedBox(
                height: 8,
              ),
              BlocConsumer<LoginBloc, LoginState>(
                listener: (context, state) {
                  if (state is LoginStateError) {
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(
                        content: Text(state.message),
                        backgroundColor: Colors.red,
                      ),
                    );
                  }
                  if (state is LoginStateSuccess) {
                    LocalDatasource()
                        .saveToken(state.responseModel.accessToken!);
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(
                        content: Text('Login Success'),
                        backgroundColor: Colors.blue,
                      ),
                    );
                    Navigator.of(context).push(MaterialPageRoute(
                      builder: (context) => const HomePage(),
                    ));
                  }
                },
                builder: (context, state) {
                  if (state is LoginStateLoading) {
                    return const CircularProgressIndicator();
                  }

                  return ElevatedButton(
                    onPressed: () {
                      var request = LoginRequestModel(
                          email: emailController.text,
                          password: passwordController.text);
                      context.read<LoginBloc>().add(
                            DoLoginEvent(requestModel: request),
                          );
                    },
                    child: const Text('Login'),
                  );
                },
              ),
              InkWell(
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) {
                        return const RegisterPage();
                      },
                    ),
                  );
                },
                child: const Text('Register here..'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
