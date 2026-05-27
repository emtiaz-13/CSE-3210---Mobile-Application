import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import '../routes.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController _identifierController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  bool _passwordVisible = false;

  static final RegExp _emailRegex = RegExp(
    r'^[a-zA-Z0-9._%+\-]+@[a-zA-Z0-9.\-]+\.[a-zA-Z]{2,}$',
  );

  static final RegExp _phoneRegex = RegExp(r'^01[3-9]\d{8}$');

  bool get _isPhoneInput {
    final val = _identifierController.text.trim();
    return RegExp(r'^\d').hasMatch(val);
  }

  String? _validateIdentifier(String? value) {
    if (value == null || value.trim().isEmpty) {
      return 'Please enter your email or phone number';
    }
    final val = value.trim();

    if (RegExp(r'^\d').hasMatch(val)) {
      if (!_phoneRegex.hasMatch(val)) {
        return 'Enter a valid BD number (e.g. 01712345678)';
      }
    } else {
      if (!_emailRegex.hasMatch(val)) {
        return 'Enter a valid email (e.g. user@example.com)';
      }
    }
    return null;
  }

  String? _validatePassword(String? value) {
    if (value == null || value.isEmpty) {
      return 'Please enter your password';
    }
    return null;
  }

  OutlineInputBorder get _borderStyle => OutlineInputBorder(
    borderRadius: BorderRadius.circular(30),
    borderSide: const BorderSide(color: Colors.white60),
  );

  OutlineInputBorder get _focusedBorderStyle => OutlineInputBorder(
    borderRadius: BorderRadius.circular(30),
    borderSide: const BorderSide(color: Colors.white),
  );

  @override
  void dispose() {
    _identifierController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [
              Color(0xFF2B0000),
              Color.fromARGB(255, 96, 2, 2),
              Color(0xFF2B0000),
            ],
          ),
        ),
        child: SafeArea(
          child: Center(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 40),
              child: Form(
                key: _formKey,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    const SizedBox(height: 80),
                    Image.asset(
                      'assets/images/logo.png',
                      height: 150,
                      width: 150,
                    ),

                    const SizedBox(height: 40),

                    StatefulBuilder(
                      builder: (context, setFieldState) {
                        return TextFormField(
                          controller: _identifierController,
                          keyboardType: _isPhoneInput
                              ? TextInputType.phone
                              : TextInputType.emailAddress,
                          textInputAction: TextInputAction.next,
                          autovalidateMode: AutovalidateMode.onUserInteraction,
                          validator: _validateIdentifier,
                          inputFormatters: [_SmartLoginFormatter()],
                          onChanged: (_) {
                            setFieldState(() {});
                            _formKey.currentState?.validate();
                          },
                          style: const TextStyle(color: Colors.white),
                          decoration: InputDecoration(
                            hintText: 'Email or Phone Number',
                            hintStyle: const TextStyle(color: Colors.white70),
                            filled: true,
                            fillColor: Colors.transparent,
                            border: _borderStyle,
                            enabledBorder: _borderStyle,
                            focusedBorder: _focusedBorderStyle,
                            errorBorder: _borderStyle,
                            focusedErrorBorder: _borderStyle,
                            errorStyle: const TextStyle(
                              color: Color(0xFFFF6B6B),
                              fontSize: 12,
                            ),
                            contentPadding: const EdgeInsets.symmetric(
                              horizontal: 24,
                              vertical: 16,
                            ),
                            prefixIcon: Icon(
                              _isPhoneInput
                                  ? Icons.phone_outlined
                                  : Icons.email_outlined,
                              color: Colors.white54,
                              size: 20,
                            ),
                          ),
                        );
                      },
                    ),

                    const SizedBox(height: 16),
                    TextFormField(
                      controller: _passwordController,
                      obscureText: !_passwordVisible,
                      textInputAction: TextInputAction.done,
                      autovalidateMode: AutovalidateMode.onUserInteraction,
                      validator: _validatePassword,
                      onChanged: (_) => _formKey.currentState?.validate(),
                      style: const TextStyle(color: Colors.white),
                      decoration: InputDecoration(
                        hintText: 'Password',
                        hintStyle: const TextStyle(color: Colors.white70),
                        filled: true,
                        fillColor: Colors.transparent,
                        border: _borderStyle,
                        enabledBorder: _borderStyle,
                        focusedBorder: _focusedBorderStyle,
                        errorBorder: _borderStyle,
                        focusedErrorBorder: _borderStyle,
                        errorStyle: const TextStyle(
                          color: Color(0xFFFF6B6B),
                          fontSize: 11,
                        ),
                        contentPadding: const EdgeInsets.symmetric(
                          horizontal: 24,
                          vertical: 16,
                        ),
                        suffixIcon: IconButton(
                          icon: Icon(
                            _passwordVisible
                                ? Icons.visibility
                                : Icons.visibility_off,
                            color: Colors.white70,
                          ),
                          onPressed: () => setState(
                            () => _passwordVisible = !_passwordVisible,
                          ),
                        ),
                      ),
                    ),

                    const SizedBox(height: 30),

                    SizedBox(
                      width: double.infinity,
                      child: ElevatedButton(
                        onPressed: () {
                          if (_formKey.currentState?.validate() != true) return;
                          Navigator.pushReplacementNamed(
                            context,
                            AppRoutes.home,
                          );
                        },
                        style: ElevatedButton.styleFrom(
                          backgroundColor: const Color(0xFFD4A0A0),
                          foregroundColor: const Color(0xFF6B0000),
                          padding: const EdgeInsets.symmetric(vertical: 16),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(30),
                          ),
                          elevation: 4,
                        ),
                        child: const Text(
                          'LOGIN',
                          style: TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                            letterSpacing: 2,
                          ),
                        ),
                      ),
                    ),

                    const SizedBox(height: 20),

                    TextButton(
                      onPressed: () {},
                      child: const Text(
                        'Forgot Password ?',
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 18,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ),

                    const Spacer(),
                    Padding(
                      padding: const EdgeInsets.only(bottom: 20),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          const Text(
                            "Don't have an account ? ",
                            style: TextStyle(
                              color: Colors.white70,
                              fontSize: 18,
                            ),
                          ),
                          GestureDetector(
                            onTap: () {
                              Navigator.pushNamed(context, AppRoutes.signup);
                            },
                            child: const Text(
                              'Sign up',
                              style: TextStyle(
                                color: Color(0xFFFF3333),
                                fontSize: 18,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
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

class _SmartLoginFormatter extends TextInputFormatter {
  @override
  TextEditingValue formatEditUpdate(
    TextEditingValue oldValue,
    TextEditingValue newValue,
  ) {
    final text = newValue.text;
    if (text.isEmpty || RegExp(r'^[a-zA-Z]').hasMatch(text)) {
      return newValue;
    }

    final digitsOnly = text.replaceAll(RegExp(r'\D'), '');
    final limited = digitsOnly.length > 11
        ? digitsOnly.substring(0, 11)
        : digitsOnly;

    return newValue.copyWith(
      text: limited,
      selection: TextSelection.collapsed(offset: limited.length),
    );
  }
}
