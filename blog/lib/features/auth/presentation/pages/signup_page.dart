import 'package:blog/core/theme/app_pallete.dart';
import 'package:blog/features/auth/presentation/pages/login_page.dart';
import 'package:blog/features/auth/presentation/widgets/auth_field.dart';
import 'package:blog/features/auth/presentation/widgets/auth_gradient_button.dart';
import 'package:flutter/material.dart';

class SignUpPage extends StatefulWidget {
  static route() => MaterialPageRoute(
        builder: (context) => SignUpPage(),
      );

  const SignUpPage({super.key});

  @override
  State<SignUpPage> createState() {
    return _SignUpPageState();
  }
}

class _SignUpPageState extends State<SignUpPage> {
  final _nameController = TextEditingController();
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();

  final formKey = GlobalKey<FormState>();

  @override
  void dispose() {
    _nameController.dispose();
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(15.0),
        child: Form(
          key: formKey,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                'Sign Up.',
                style: TextStyle(
                  fontSize: 50,
                  fontWeight: FontWeight.bold,
                ),
              ),
              SizedBox(height: 35),
              AuthField(hintText: 'Name', controller: _nameController),
              SizedBox(height: 15),
              AuthField(hintText: 'Email', controller: _emailController),
              SizedBox(height: 15),
              AuthField(
                hintText: 'Password',
                controller: _passwordController,
                isPassword: true,
              ),
              SizedBox(height: 25),
              AuthGradientButton(
                text: 'Sign Up',
              ),
              SizedBox(height: 30),
              GestureDetector(
                onTap: () {
                  Navigator.of(context).push(
                    LoginPagePage.route(),
                  );
                },
                child: RichText(
                  text: TextSpan(
                    text: 'Already have an account? ',
                    style: Theme.of(context).textTheme.titleMedium,
                    children: [
                      TextSpan(
                        text: 'Sign In',
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
