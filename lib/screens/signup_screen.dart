import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import '../routes.dart';
import '../widgets/custom_button.dart';
import 'user_session.dart';

class SignUpScreen extends StatefulWidget {
  const SignUpScreen({super.key});

  @override
  State<SignUpScreen> createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {
  final _formKey = GlobalKey<FormState>();

  final TextEditingController _fullNameController = TextEditingController();
  final TextEditingController _contactController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _confirmPasswordController =
      TextEditingController();
  final TextEditingController _lastDonationController = TextEditingController();

  bool isChecked = false;
  bool _passwordVisible = false;
  bool _confirmPasswordVisible = false;

  String? _selectedBloodGroup;
  String? _selectedLocation;
  static const List<String> _bloodGroups = [
    'A+',
    'A-',
    'B+',
    'B-',
    'AB+',
    'AB-',
    'O+',
    'O-',
  ];

  static const List<String> _locations = [
    'Barguna',
    'Barisal',
    'Bhola',
    'Bogra',
    'Bramanbaria',
    'Chandpur',
    'Chittagong',
    'Chuadanga',
    'Comilla',
    "Cox's Bazar",
    'Dhaka',
    'Dinajpur',
    'Feni',
    'Gazipur',
    'Habiganj',
    'Jessore',
    'Jhalokati',
    'Jhenaidah',
    'Khulna',
    'Kurigram',
    'Kushtia',
    'Lalmonirhat',
    'Magura',
    'Meherpur',
    'Moulvibazar',
    'Mymensingh',
    'Narail',
    'Narayanganj',
    'Nilphamari',
    'Noakhali',
    'Pabna',
    'Panchagarh',
    'Pirojpur',
    'Rajshahi',
    'Rangpur',
    'Satkhira',
    'Sunamganj',
    'Sylhet',
    'Tangail',
    'Thakurgaon',
  ];

  static final RegExp _emailRegex = RegExp(
    r'^[a-zA-Z0-9._%+\-]+@[a-zA-Z0-9.\-]+\.[a-zA-Z]{2,}$',
  );
  static final RegExp _phoneRegex = RegExp(r'^01[3-9]\d{8}$');
  static final RegExp _passwordRegex = RegExp(
    r'^(?=.*[a-z])(?=.*[A-Z])(?=.*\d)(?=.*[@$!%*?&_#^()\-])[A-Za-z\d@$!%*?&_#^()\-]{8,}$',
  );
  static final RegExp _dateRegex = RegExp(
    r'^(0[1-9]|[12]\d|3[01])\/(0[1-9]|1[0-2])\/(19|20)\d{2}$',
  );

  String? _validateFullName(String? value) {
    if (value == null || value.trim().isEmpty) return 'Full name is required';
    if (value.trim().length < 3) return 'Name must be at least 3 characters';
    return null;
  }

  String? _validatePhone(String? value) {
    if (value == null || value.trim().isEmpty)
      return 'Contact number is required';
    if (!_phoneRegex.hasMatch(value.trim())) {
      return 'Enter a valid BD number (e.g. 01712345678)';
    }
    return null;
  }

  String? _validateEmail(String? value) {
    if (value == null || value.trim().isEmpty) return 'Email is required';
    if (!_emailRegex.hasMatch(value.trim())) {
      return 'Enter a valid email address (e.g. user@example.com)';
    }
    return null;
  }

  String? _validatePassword(String? value) {
    if (value == null || value.isEmpty) return 'Password is required';
    if (value.length < 8) return 'Password must be at least 8 characters';
    if (!_passwordRegex.hasMatch(value)) {
      return 'Must include uppercase, lowercase, number & special character';
    }
    return null;
  }

  String? _validateConfirmPassword(String? value) {
    if (value == null || value.isEmpty) return 'Please confirm your password';
    if (value != _passwordController.text) return 'Passwords do not match';
    return null;
  }

  String? _validateBloodGroup(String? value) {
    if (value == null || value.isEmpty) return 'Please select a blood group';
    return null;
  }

  String? _validateLocation(String? value) {
    if (value == null || value.isEmpty) return 'Please select a location';
    return null;
  }

  String? _validateLastDonationDate(String? value) {
    if (value == null || value.trim().isEmpty) {
      return 'Last donation date is required';
    }
    if (!_dateRegex.hasMatch(value.trim())) {
      return 'Enter a valid date in DD/MM/YYYY format (e.g. 15/03/2024)';
    }
    try {
      final parts = value.trim().split('/');
      final date = DateTime(
        int.parse(parts[2]),
        int.parse(parts[1]),
        int.parse(parts[0]),
      );
      if (date.isAfter(DateTime.now())) {
        return 'Donation date cannot be in the future';
      }
    } catch (_) {
      return 'Enter a valid date in DD/MM/YYYY format';
    }
    return null;
  }

  OutlineInputBorder get _borderStyle => OutlineInputBorder(
    borderRadius: BorderRadius.circular(30),
    borderSide: const BorderSide(color: Colors.white70),
  );

  OutlineInputBorder get _errorBorderStyle => OutlineInputBorder(
    borderRadius: BorderRadius.circular(30),
    borderSide: const BorderSide(color: Color(0xFFFF6B6B), width: 1.5),
  );

  OutlineInputBorder get _focusedBorderStyle => OutlineInputBorder(
    borderRadius: BorderRadius.circular(30),
    borderSide: const BorderSide(color: Colors.white, width: 1.5),
  );

  InputDecoration _fieldDecoration(
    String hint, {
    Widget? suffixIcon,
    String? helperText,
  }) {
    return InputDecoration(
      hintText: hint,
      hintStyle: const TextStyle(color: Colors.white54),
      helperText: helperText,
      helperStyle: const TextStyle(color: Colors.white38, fontSize: 11),
      helperMaxLines: 2,
      border: _borderStyle,
      enabledBorder: _borderStyle,
      focusedBorder: _focusedBorderStyle,
      errorBorder: _errorBorderStyle,
      focusedErrorBorder: _errorBorderStyle,
      errorStyle: const TextStyle(color: Color(0xFFFF6B6B), fontSize: 11),
      contentPadding: const EdgeInsets.symmetric(horizontal: 20, vertical: 16),
      suffixIcon: suffixIcon,
    );
  }

  InputDecoration _dropdownDecoration(String hint, {String? helperText}) {
    return InputDecoration(
      hintText: hint,
      hintStyle: const TextStyle(color: Colors.white54),
      helperText: helperText,
      helperStyle: const TextStyle(color: Colors.white38, fontSize: 11),
      helperMaxLines: 2,
      border: _borderStyle,
      enabledBorder: _borderStyle,
      focusedBorder: _focusedBorderStyle,
      errorBorder: _errorBorderStyle,
      focusedErrorBorder: _errorBorderStyle,
      errorStyle: const TextStyle(color: Color(0xFFFF6B6B), fontSize: 11),
      contentPadding: const EdgeInsets.symmetric(horizontal: 20, vertical: 5),
    );
  }

  void _onSignUp() {
    if (_formKey.currentState!.validate()) {
      UserSession.instance.fullName = _fullNameController.text.trim();
      UserSession.instance.email = _emailController.text.trim();
      UserSession.instance.contact = _contactController.text.trim();

      Navigator.pushReplacementNamed(context, AppRoutes.home);
    }
  }

  Future<void> _pickDate() async {
    final now = DateTime.now();
    final picked = await showDatePicker(
      context: context,
      initialDate: now,
      firstDate: DateTime(1900),
      lastDate: now,
      builder: (context, child) {
        return Theme(
          data: Theme.of(context).copyWith(
            colorScheme: const ColorScheme.dark(
              primary: Color(0xFF8B0000),
              onPrimary: Colors.white,
              surface: Color(0xFF2B0000),
              onSurface: Colors.white,
            ),
            dialogBackgroundColor: const Color(0xFF1A0000),
          ),
          child: child!,
        );
      },
    );
    if (picked != null) {
      final day = picked.day.toString().padLeft(2, '0');
      final month = picked.month.toString().padLeft(2, '0');
      final year = picked.year.toString();
      _lastDonationController.text = '$day/$month/$year';
    }
  }

  @override
  void dispose() {
    _fullNameController.dispose();
    _contactController.dispose();
    _emailController.dispose();
    _passwordController.dispose();
    _confirmPasswordController.dispose();
    _lastDonationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        height: MediaQuery.of(context).size.height,
        width: double.infinity,
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            colors: [
              Color.fromARGB(255, 80, 2, 2),
              Color.fromARGB(255, 52, 3, 3),
              Color.fromARGB(255, 30, 3, 3),
            ],
          ),
        ),
        child: SafeArea(
          child: SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.all(30),
              child: Form(
                key: _formKey,
                child: Column(
                  children: [
                    const SizedBox(height: 20),

                    const Text(
                      'Sign Up Form',
                      style: TextStyle(
                        color: Color.fromRGBO(255, 232, 200, 0.903),
                        fontSize: 32,
                        fontWeight: FontWeight.w900,
                        letterSpacing: 1.5,
                      ),
                    ),

                    const SizedBox(height: 30),

                    TextFormField(
                      controller: _fullNameController,
                      style: const TextStyle(
                        color: Color.fromARGB(255, 232, 200, 154),
                        fontSize: 16,
                        fontWeight: FontWeight.w500,
                      ),
                      textCapitalization: TextCapitalization.words,
                      decoration: _fieldDecoration(
                        'Full Name',
                        helperText:
                            'e.g. Rahim Uddin Ahmed (min. 3 characters)',
                      ),
                      validator: _validateFullName,
                    ),

                    const SizedBox(height: 15),

                    TextFormField(
                      controller: _contactController,
                      keyboardType: TextInputType.phone,
                      style: const TextStyle(color: Colors.white),
                      inputFormatters: [
                        FilteringTextInputFormatter.digitsOnly,
                        LengthLimitingTextInputFormatter(11),
                      ],
                      decoration: _fieldDecoration(
                        'Contact Number',
                        helperText:
                            'e.g. 01712345678 (GP, BL, Robi, Airtel, Teletalk)',
                      ),
                      validator: _validatePhone,
                    ),

                    const SizedBox(height: 15),

                    TextFormField(
                      controller: _emailController,
                      keyboardType: TextInputType.emailAddress,
                      style: const TextStyle(color: Colors.white),
                      decoration: _fieldDecoration(
                        'Email Address',
                        helperText: 'e.g. rahim@gmail.com',
                      ),
                      validator: _validateEmail,
                    ),

                    const SizedBox(height: 15),
                    TextFormField(
                      controller: _passwordController,
                      obscureText: !_passwordVisible,
                      style: const TextStyle(color: Colors.white),
                      decoration: _fieldDecoration(
                        'Password',
                        helperText:
                            'Min 8 chars · Uppercase · Lowercase · Number · Symbol (e.g. @, #, !)',
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
                      validator: _validatePassword,
                      onChanged: (_) {
                        if (_confirmPasswordController.text.isNotEmpty) {
                          _formKey.currentState?.validate();
                        }
                      },
                    ),

                    const SizedBox(height: 15),

                    TextFormField(
                      controller: _confirmPasswordController,
                      obscureText: !_confirmPasswordVisible,
                      style: const TextStyle(color: Colors.white),
                      decoration: _fieldDecoration(
                        'Confirm Password',
                        helperText: 'Re-enter your password to confirm',
                        suffixIcon: IconButton(
                          icon: Icon(
                            _confirmPasswordVisible
                                ? Icons.visibility
                                : Icons.visibility_off,
                            color: Colors.white70,
                          ),
                          onPressed: () => setState(
                            () => _confirmPasswordVisible =
                                !_confirmPasswordVisible,
                          ),
                        ),
                      ),
                      validator: _validateConfirmPassword,
                    ),

                    const SizedBox(height: 20),

                    Row(
                      children: [
                        Checkbox(
                          value: isChecked,
                          activeColor: Colors.white,
                          checkColor: const Color(0xFF8B0000),
                          side: const BorderSide(color: Colors.white70),
                          onChanged: (val) => setState(() => isChecked = val!),
                        ),
                        const Text(
                          'Want to donate?',
                          style: TextStyle(color: Colors.white70),
                        ),
                      ],
                    ),

                    if (isChecked) ...[
                      const SizedBox(height: 10),
                      DropdownButtonFormField<String>(
                        value: _selectedBloodGroup,
                        dropdownColor: const Color(0xFF2B0000),
                        style: const TextStyle(
                          color: Colors.white,
                          fontSize: 16,
                        ),
                        iconEnabledColor: Colors.white70,
                        decoration: _dropdownDecoration(
                          'Blood Group',
                          helperText: 'Select your blood group',
                        ),
                        hint: const Text(
                          'Blood Group',
                          style: TextStyle(color: Colors.white54),
                        ),
                        items: _bloodGroups
                            .map(
                              (group) => DropdownMenuItem(
                                value: group,
                                child: Text(
                                  group,
                                  style: const TextStyle(color: Colors.white),
                                ),
                              ),
                            )
                            .toList(),
                        onChanged: (val) =>
                            setState(() => _selectedBloodGroup = val),
                        validator: _validateBloodGroup,
                      ),

                      const SizedBox(height: 10),

                      DropdownButtonFormField<String>(
                        value: _selectedLocation,
                        dropdownColor: const Color(0xFF2B0000),
                        style: const TextStyle(
                          color: Colors.white,
                          fontSize: 16,
                        ),
                        iconEnabledColor: Colors.white70,
                        isExpanded: true,
                        menuMaxHeight: 300,
                        decoration: _dropdownDecoration(
                          'Location',
                          helperText: 'Select your district',
                        ),
                        hint: const Text(
                          'Location',
                          style: TextStyle(color: Colors.white54),
                        ),
                        items: _locations
                            .map(
                              (loc) => DropdownMenuItem(
                                value: loc,
                                child: Text(
                                  loc,
                                  style: const TextStyle(color: Colors.white),
                                ),
                              ),
                            )
                            .toList(),
                        onChanged: (val) =>
                            setState(() => _selectedLocation = val),
                        validator: _validateLocation,
                      ),

                      const SizedBox(height: 10),

                      TextFormField(
                        controller: _lastDonationController,
                        style: const TextStyle(color: Colors.white),
                        readOnly: true,
                        decoration: _fieldDecoration(
                          'Last Donation Date',
                          helperText: 'DD/MM/YYYY (tap calendar to pick)',
                          suffixIcon: IconButton(
                            icon: const Icon(
                              Icons.calendar_today,
                              color: Colors.white70,
                              size: 20,
                            ),
                            onPressed: _pickDate,
                          ),
                        ),
                        onTap: _pickDate,
                        validator: _validateLastDonationDate,
                      ),
                    ],

                    const SizedBox(height: 20),
                    CustomButton(text: 'Sign Up', onTap: _onSignUp),

                    const SizedBox(height: 20),
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
