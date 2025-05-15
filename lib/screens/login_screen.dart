import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:vehicle_repair_app/constants/app_colors.dart';
import '../constants/app_text_styles.dart';
import 'home_screen.dart';
import '../widgets/app_text_field.dart';
import '../widgets/app_button.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  final _formKey = GlobalKey<FormState>();
  bool _obscurePassword = true;
  bool _rememberMe = false;
  bool isLoading = false;

  void _togglePasswordVisibility() {
    setState(() {
      _obscurePassword = !_obscurePassword;
    });
  }

  Future<void> _loadSavedCredentials() async {
    final prefs = await SharedPreferences.getInstance();
    final savedEmail = prefs.getString('saved_email');
    final savedPassword = prefs.getString('saved_password');
    final remember = prefs.getBool('remember_me') ?? false;

    if (remember) {
      setState(() {
        _rememberMe = true;
        _emailController.text = savedEmail ?? '';
        _passwordController.text = savedPassword ?? '';
      });
    }
  }

  Future<void> _saveCredentials() async {
    final prefs = await SharedPreferences.getInstance();
    if (_rememberMe) {
      await prefs.setString('saved_email', _emailController.text.trim());
      await prefs.setString('saved_password', _passwordController.text);
    } else {
      await prefs.remove('saved_email');
      await prefs.remove('saved_password');
    }
    await prefs.setBool('remember_me', _rememberMe);
  }

  void _login() async {
    if (_formKey.currentState!.validate()) {
      final email = _emailController.text.trim();
      final password = _passwordController.text;
      setState(() {
        isLoading = true;
      });

      if (email == 'intern@balancee.com' && password == 'Intern123#') {
        await _saveCredentials();
        if (!mounted)
          return; // <- Good practice to avoid setting state on disposed widget
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (_) => const HomeScreen()),
        );
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Invalid credentials')),
        );
        setState(() {
          isLoading = false;
        });
      }
    }
  }

  @override
  void initState() {
    super.initState();
    _loadSavedCredentials();
  }

  @override
  Widget build(BuildContext context) {
    final AppTextStyles textStyles = AppTextStyles();
    final AppColors appColors = AppColors();

    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: SingleChildScrollView(
            physics: const BouncingScrollPhysics(),
            child: Center(
              child: Form(
                key: _formKey,
                child: Column(
                  children: [
                    const SizedBox(height: 50),
                    Image.asset("assets/balancee_logo.PNG"),
                    Text('Welcome to Balanceè 👋',
                        style: textStyles.headingText(context)),
                    const SizedBox(height: 10),
                    Text('Login', style: textStyles.headingText(context)),
                    const SizedBox(height: 40),
                    AppTextField(
                      controller: _emailController,
                      label: 'Email',
                      validator: (val) =>
                          val!.isEmpty ? 'Please enter your email' : null,
                    ),
                    const SizedBox(height: 16),
                    AppTextField(
                      controller: _passwordController,
                      label: 'Password',
                      isPassword: true,
                      obscureText: _obscurePassword,
                      toggleVisibility: _togglePasswordVisibility,
                      validator: (val) =>
                          val!.isEmpty ? 'Please enter your password' : null,
                    ),
                    const SizedBox(height: 10),
                    Row(
                      children: [
                        Checkbox(
                          value: _rememberMe,
                          onChanged: (val) {
                            setState(() {
                              _rememberMe = val!;
                            });
                          },
                          activeColor: appColors.primaryColor,
                        ),
                        const Text("Remember Me"),
                      ],
                    ),
                    const SizedBox(height: 10),
                    AppButton(
                      onPressed: _login,
                      label: !isLoading ? 'L O G I N' : 'Loading...',
                      btnColor: appColors.primaryColor,
                    ),
                    const SizedBox(height: 40),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
