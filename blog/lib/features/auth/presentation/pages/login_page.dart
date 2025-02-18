import 'package:blog/core/theme/app_pallete.dart';
import 'package:blog/features/auth/presentation/pages/signup_page.dart';
import 'package:blog/features/auth/presentation/widgets/auth_field.dart';
import 'package:blog/features/auth/presentation/widgets/auth_gradient_button.dart';
import 'package:flutter/material.dart';

class LoginPagePage extends StatefulWidget {
  static route() => MaterialPageRoute(
        builder: (context) => LoginPagePage(),
      );

  const LoginPagePage({super.key});

  @override
  State<LoginPagePage> createState() {
    return _LoginPagePageState();
  }
}

class _LoginPagePageState extends State<LoginPagePage> {
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();

  final formKey = GlobalKey<FormState>();

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(15.0),
        child: Form(
          key: formKey,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                'Sign In.',
                style: TextStyle(
                  fontSize: 50,
                  fontWeight: FontWeight.bold,
                ),
              ),
              SizedBox(height: 35),
              AuthField(hintText: 'Email', controller: _emailController),
              SizedBox(height: 15),
              AuthField(
                hintText: 'Password',
                controller: _passwordController,
                isPassword: true,
              ),
              SizedBox(height: 25),
              AuthGradientButton(),
              SizedBox(height: 30),
              GestureDetector(
                onTap: () {
                  Navigator.push(context, SignUpPage.route());
                },
                child: RichText(
                  text: TextSpan(
                    text: 'Don\'t have an account? ',
                    style: Theme.of(context).textTheme.titleMedium,
                    children: [
                      TextSpan(
                        text: 'Sign Up',
                        style:
                            Theme.of(context).textTheme.titleMedium?.copyWith(
                                  color: AppPallete.gradient2,
                                  fontWeight: FontWeight.w600,
                                ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
