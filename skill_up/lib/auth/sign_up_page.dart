import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'package:skill_up/auth/login_page.dart';
import 'package:skill_up/model/user.dart';
import 'package:skill_up/providers/user_provider.dart';
import 'package:skill_up/widgets/image_picker.dart';

class SignUpPage extends StatefulWidget {
  const SignUpPage({super.key});

  @override
  State<SignUpPage> createState() => _SignUpPageState();
}

class _SignUpPageState extends State<SignUpPage> {
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _confirmPasswordController =
      TextEditingController();
  final TextEditingController _ageController = TextEditingController();
  final TextEditingController _contactNumberController =
      TextEditingController();

  bool _isPasswordVisible = false;
  final _formKey = GlobalKey<FormState>();

  void _handleSignUp() async {
    if (_formKey.currentState!.validate()) {
      print('Name: ${_nameController.text}');
      print('Age: ${_ageController.text}');
      print('Contact Number: ${_contactNumberController.text}');
      print('Email: ${_emailController.text}');
      print('Password: ${_passwordController.text}');

      final userProvider = context.read<UserProvider>();
      if (userProvider.profileImage == null) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text(
              'Please select a profile image',
              textAlign: TextAlign.center,
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
            backgroundColor: const Color.fromARGB(255, 52, 76, 183),
          ),
        );
        return;
      }

      try {
        User user = User(
          uid: "",
          username: _nameController.text,
          email: _emailController.text,
          contactNumber: _contactNumberController.text,
          profilePictureURL: "",
          age: int.parse(_ageController.text),
        );

        await context.read<UserProvider>().registerUser(
          user,
          _passwordController.text,
        );

        Navigator.of(context).pop();
      } catch (error) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Registration failed: ${error.toString()}')),
        );
      }
    }
  }

  @override
  void dispose() {
    _nameController.dispose();
    _emailController.dispose();
    _passwordController.dispose();
    _confirmPasswordController.dispose();
    _ageController.dispose();
    _contactNumberController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.symmetric(horizontal: 25),
          child: Column(
            spacing: 16,
            children: [
              SizedBox(),
              Column(
                children: [
                  Text(
                    "Create Account",
                    style: GoogleFonts.spaceGrotesk(
                      fontSize: 32,
                      color: const Color.fromARGB(255, 52, 76, 183),
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                  Text(
                    "Sign up to join the skill community",
                    style: GoogleFonts.spaceGrotesk(
                      fontSize: 16,
                      color: const Color.fromARGB(255, 52, 76, 183),
                      fontWeight: FontWeight.w400,
                    ),
                  ),
                ],
              ),
              SizedBox(),
              Form(
                key: _formKey,
                child: Column(
                  spacing: 12,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    UserImagePicker(onPickedImage: (pickedImage) {}),
                    SizedBox(),
                    TextFormField(
                      controller: _nameController,
                      keyboardType: TextInputType.name,
                      style: GoogleFonts.spaceGrotesk(color: Colors.black),
                      decoration: InputDecoration(
                        hoverColor: const Color.fromARGB(255, 52, 76, 183),
                        labelText: 'Full Name',
                        labelStyle: GoogleFonts.spaceGrotesk(
                          color: Colors.black,
                          fontSize: 16,
                          fontWeight: FontWeight.normal,
                        ),
                        prefixIcon: const Icon(Icons.person_2),
                        prefixIconColor: const Color.fromARGB(255, 52, 76, 183),
                        border: const OutlineInputBorder(
                          borderSide: BorderSide(color: Colors.black, width: 1),
                        ),
                        enabledBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(8),
                          borderSide: const BorderSide(
                            color: const Color.fromARGB(255, 52, 76, 183),
                            width: 2,
                          ),
                        ),
                        focusedBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(8),
                          borderSide: const BorderSide(
                            color: const Color.fromARGB(255, 52, 76, 183),
                            width: 2,
                          ),
                        ),
                      ),
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Please enter your name';
                        }
                        if (value.length < 3) {
                          return 'Name must be at least 3 characters';
                        }
                        return null;
                      },
                    ),
                    TextFormField(
                      controller: _ageController,
                      keyboardType: TextInputType.number,
                      style: GoogleFonts.spaceGrotesk(color: Colors.black),
                      decoration: InputDecoration(
                        hoverColor: const Color.fromARGB(255, 52, 76, 183),
                        labelText: 'Age',
                        labelStyle: GoogleFonts.spaceGrotesk(
                          color: Colors.black,
                          fontSize: 16,
                          fontWeight: FontWeight.normal,
                        ),
                        prefixIcon: const Icon(Icons.calendar_today),
                        prefixIconColor: const Color.fromARGB(255, 52, 76, 183),
                        border: const OutlineInputBorder(
                          borderSide: BorderSide(color: Colors.black, width: 1),
                        ),
                        enabledBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(8),
                          borderSide: const BorderSide(
                            color: const Color.fromARGB(255, 52, 76, 183),
                            width: 2,
                          ),
                        ),
                        focusedBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(8),
                          borderSide: const BorderSide(
                            color: const Color.fromARGB(255, 52, 76, 183),
                            width: 2,
                          ),
                        ),
                      ),
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Please enter your age';
                        }
                        final age = int.tryParse(value);
                        if (age == null) {
                          return 'Please enter a valid number';
                        }
                        if (age < 13 || age > 120) {
                          return 'Age must be between 13 and 120';
                        }
                        return null;
                      },
                    ),
                    TextFormField(
                      controller: _contactNumberController,
                      keyboardType: TextInputType.phone,
                      style: GoogleFonts.spaceGrotesk(color: Colors.black),
                      decoration: InputDecoration(
                        hoverColor: const Color.fromARGB(255, 52, 76, 183),
                        labelText: 'Contact Number',
                        labelStyle: GoogleFonts.spaceGrotesk(
                          color: Colors.black,
                          fontSize: 16,
                          fontWeight: FontWeight.normal,
                        ),
                        prefixIcon: const Icon(Icons.phone),
                        prefixIconColor: const Color.fromARGB(255, 52, 76, 183),
                        border: const OutlineInputBorder(
                          borderSide: BorderSide(color: Colors.black, width: 1),
                        ),
                        enabledBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(8),
                          borderSide: const BorderSide(
                            color: const Color.fromARGB(255, 52, 76, 183),
                            width: 2,
                          ),
                        ),
                        focusedBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(8),
                          borderSide: const BorderSide(
                            color: const Color.fromARGB(255, 52, 76, 183),
                            width: 2,
                          ),
                        ),
                      ),
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Please enter your contact number';
                        }
                        if (!RegExp(r'^\+?[\d\s-]{10,}$').hasMatch(value)) {
                          return 'Please enter a valid contact number';
                        }
                        return null;
                      },
                    ),
                    TextFormField(
                      controller: _emailController,
                      keyboardType: TextInputType.emailAddress,
                      style: GoogleFonts.spaceGrotesk(color: Colors.black),
                      decoration: InputDecoration(
                        hoverColor: const Color.fromARGB(255, 52, 76, 183),
                        labelText: 'Email',
                        labelStyle: GoogleFonts.spaceGrotesk(
                          color: Colors.black,
                          fontSize: 16,
                          fontWeight: FontWeight.normal,
                        ),
                        prefixIcon: const Icon(Icons.email),
                        prefixIconColor: const Color.fromARGB(255, 52, 76, 183),
                        border: const OutlineInputBorder(
                          borderSide: BorderSide(color: Colors.black, width: 1),
                        ),
                        enabledBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(8),
                          borderSide: const BorderSide(
                            color: const Color.fromARGB(255, 52, 76, 183),
                            width: 2,
                          ),
                        ),
                        focusedBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(8),
                          borderSide: const BorderSide(
                            color: const Color.fromARGB(255, 52, 76, 183),
                            width: 2,
                          ),
                        ),
                      ),
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Please enter your email';
                        }
                        if (!RegExp(
                          r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$',
                        ).hasMatch(value)) {
                          return 'Please enter a valid email';
                        }
                        return null;
                      },
                    ),
                    TextFormField(
                      controller: _passwordController,
                      obscureText: !_isPasswordVisible,
                      style: GoogleFonts.spaceGrotesk(color: Colors.black),
                      decoration: InputDecoration(
                        hoverColor: const Color.fromARGB(255, 52, 76, 183),
                        labelText: 'Password',
                        suffixIcon: IconButton(
                          icon: Icon(
                            _isPasswordVisible
                                ? Icons.visibility
                                : Icons.visibility_off,
                          ),
                          onPressed: () {
                            setState(() {
                              _isPasswordVisible = !_isPasswordVisible;
                            });
                          },
                        ),
                        suffixIconColor: const Color.fromARGB(255, 52, 76, 183),
                        labelStyle: GoogleFonts.spaceGrotesk(
                          color: Colors.black,
                          fontSize: 16,
                          fontWeight: FontWeight.normal,
                        ),
                        prefixIcon: const Icon(Icons.lock),
                        prefixIconColor: const Color.fromARGB(255, 52, 76, 183),
                        border: const OutlineInputBorder(
                          borderSide: BorderSide(color: Colors.black, width: 1),
                        ),
                        enabledBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(8),
                          borderSide: const BorderSide(
                            color: const Color.fromARGB(255, 52, 76, 183),
                            width: 2,
                          ),
                        ),
                        focusedBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(8),
                          borderSide: const BorderSide(
                            color: const Color.fromARGB(255, 52, 76, 183),
                            width: 2,
                          ),
                        ),
                      ),
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Please enter a password';
                        }
                        if (value.length < 6) {
                          return 'Password must be at least 6 characters';
                        }

                        return null;
                      },
                    ),
                  ],
                ),
              ),
              SizedBox(),
              SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  onPressed: _handleSignUp,
                  style: ElevatedButton.styleFrom(
                    backgroundColor:
                        context.watch<UserProvider>().isLoading
                            ? Colors.grey
                            : const Color.fromARGB(255, 52, 76, 183),
                    foregroundColor: Colors.white,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8),
                    ),
                    padding: EdgeInsets.all(16),
                  ),
                  child:
                      context.watch<UserProvider>().isLoading
                          ? SizedBox(
                            width: 20,
                            height: 20,
                            child: CircularProgressIndicator(
                              color: Colors.white,
                              strokeWidth: 2,
                            ),
                          )
                          : Text(
                            "SIGN UP",
                            style: GoogleFonts.spaceGrotesk(
                              fontSize: 18,
                              color: Colors.white,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                ),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    'Already have an account?',
                    style: GoogleFonts.spaceGrotesk(
                      fontSize: 16,
                      color: Colors.black,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                  TextButton(
                    onPressed: () {
                      Navigator.of(context).pushReplacement(
                        MaterialPageRoute(
                          builder: (context) => const LoginPage(),
                        ),
                      );
                    },
                    child: Text(
                      'Login',
                      style: GoogleFonts.spaceGrotesk(
                        fontSize: 18,
                        color: const Color.fromARGB(255, 52, 76, 183),
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
