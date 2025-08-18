import 'package:flutter/material.dart';
import 'package:flutter/foundation.dart';
import '../core/app_export.dart';
import '../widgets/custom_image_view.dart';
import '../widgets/custom_submit_button.dart';
import '../widgets/custom_text_field.dart';

/// Sign up screen for iBorrow application
/// Allows new users to create accounts
class SignupScreen extends StatefulWidget {
  const SignupScreen({super.key});

  @override
  State<SignupScreen> createState() => _SignupScreenState();
}

class _SignupScreenState extends State<SignupScreen> {
  final _formKey = GlobalKey<FormState>();
  final _usernameController = TextEditingController();
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  final _confirmPasswordController = TextEditingController();
  bool _isTermsAccepted = false;
  bool _isLoading = false;
  bool _obscurePassword = true;
  bool _obscureConfirmPassword = true;

  @override
  void dispose() {
    _usernameController.dispose();
    _emailController.dispose();
    _passwordController.dispose();
    _confirmPasswordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: appTheme.colorFFFFF2,
        body: SizedBox(
          width: double.maxFinite,
          child: SingleChildScrollView(
            child: Column(
              children: [_buildHeaderSection(), _buildSignUpForm()],
            ),
          ),
        ),
      ),
    );
  }

  /// Header section with background image and title
  Widget _buildHeaderSection() {
    return SizedBox(
      height: 454.h,
      width: double.maxFinite,
      child: Stack(
        alignment: Alignment.center,
        children: [
          CustomImageView(
            imagePath: ImageConstant.imgRectangle7Yellow900,
            height: 398.h,
            width: double.maxFinite,
            alignment: Alignment.topCenter,
            fit: BoxFit.cover,
          ),
          CustomImageView(
            imagePath: ImageConstant.imgImage2422x412,
            height: 422.h,
            width: double.maxFinite,
            alignment: Alignment.topCenter,
            fit: BoxFit.cover,
          ),
          Align(
            alignment: Alignment.bottomLeft,
            child: Padding(
              padding: EdgeInsets.only(left: 35.h, bottom: 52.h),
              child: Text(
                'iBorrow\nSign-Up',
                style: TextStyleHelper.instance.display36Regular.copyWith(
                  height: 1.22,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  /// Main sign up form
  Widget _buildSignUpForm() {
    return Container(
      width: double.maxFinite,
      padding: EdgeInsets.symmetric(horizontal: 35.h),
      child: Form(
        key: _formKey,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(height: 6.h),
            Container(width: 70.h, height: 2.h, color: appTheme.colorFFFC85),
            SizedBox(height: 38.h),
            _buildUsernameField(),
            SizedBox(height: 24.h),
            _buildEmailField(),
            SizedBox(height: 24.h),
            _buildPasswordField(),
            SizedBox(height: 24.h),
            _buildConfirmPasswordField(),
            SizedBox(height: 15.h),
            _buildTermsCheckbox(),
            SizedBox(height: 27.h),
            _buildSignUpButton(),
            SizedBox(height: 7.h),
            _buildSignInLink(),
            SizedBox(height: 40.h),
          ],
        ),
      ),
    );
  }

  /// Username input field
  Widget _buildUsernameField() {
    return CustomTextField(
      controller: _usernameController,
      labelText: 'Username',
      hintText: 'Enter your username',
      validator: (value) {
        if (value == null || value.isEmpty) {
          return 'Please enter your username';
        }
        if (value.length < 3) {
          return 'Username must be at least 3 characters';
        }
        return null;
      },
    );
  }

  /// Email input field
  Widget _buildEmailField() {
    return CustomTextField(
      controller: _emailController,
      labelText: 'Email',
      hintText: 'Enter your email',
      keyboardType: TextInputType.emailAddress,
      validator: (value) {
        if (value == null || value.isEmpty) {
          return 'Please enter your email';
        }
        if (!RegExp(r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$').hasMatch(value)) {
          return 'Please enter a valid email';
        }
        return null;
      },
    );
  }

  /// Password input field
  Widget _buildPasswordField() {
    return CustomTextField(
      controller: _passwordController,
      labelText: 'Password',
      hintText: 'Enter your password',
      obscureText: _obscurePassword,
      suffixIcon: IconButton(
        icon: Icon(
          _obscurePassword ? Icons.visibility_off : Icons.visibility,
          color: appTheme.colorFFBA5A,
        ),
        onPressed: () {
          setState(() {
            _obscurePassword = !_obscurePassword;
          });
        },
      ),
      validator: (value) {
        if (value == null || value.isEmpty) {
          return 'Please enter your password';
        }
        if (value.length < 6) {
          return 'Password must be at least 6 characters';
        }
        // Check for at least one uppercase, one lowercase, and one number
        if (!RegExp(r'^(?=.*[a-z])(?=.*[A-Z])(?=.*\d).+$').hasMatch(value)) {
          return 'Password must contain uppercase, lowercase, and number';
        }
        return null;
      },
    );
  }

  /// Confirm password input field
  Widget _buildConfirmPasswordField() {
    return CustomTextField(
      controller: _confirmPasswordController,
      labelText: 'Confirm Password',
      hintText: 'Confirm your password',
      obscureText: _obscureConfirmPassword,
      suffixIcon: IconButton(
        icon: Icon(
          _obscureConfirmPassword ? Icons.visibility_off : Icons.visibility,
          color: appTheme.colorFFBA5A,
        ),
        onPressed: () {
          setState(() {
            _obscureConfirmPassword = !_obscureConfirmPassword;
          });
        },
      ),
      validator: (value) {
        if (value == null || value.isEmpty) {
          return 'Please confirm your password';
        }
        if (value != _passwordController.text) {
          return 'Passwords do not match';
        }
        return null;
      },
    );
  }

  /// Terms and conditions checkbox
  Widget _buildTermsCheckbox() {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        GestureDetector(
          onTap: () {
            setState(() {
              _isTermsAccepted = !_isTermsAccepted;
            });
          },
          child: Container(
            width: 15.h,
            height: 15.h,
            decoration: BoxDecoration(
              color: appTheme.colorFFFFF2,
              border: Border.all(color: appTheme.colorFFBA5A, width: 1.h),
              borderRadius: BorderRadius.circular(2.h),
            ),
            child: Center(
              child: Opacity(
                opacity: _isTermsAccepted ? 1.0 : 0.0,
                child: Container(
                  width: 10.h,
                  height: 10.h,
                  decoration: BoxDecoration(
                    color: appTheme.colorFFBA5A,
                    borderRadius: BorderRadius.circular(2.h),
                  ),
                ),
              ),
            ),
          ),
        ),
        SizedBox(width: 7.h),
        Expanded(
          child: GestureDetector(
            onTap: () {
              setState(() {
                _isTermsAccepted = !_isTermsAccepted;
              });
            },
            child: Text(
              'I Agree to the Terms and Conditions',
              style: TextStyleHelper.instance.label10Regular.copyWith(
                height: 1.3,
              ),
            ),
          ),
        ),
      ],
    );
  }

  /// Sign up button
  Widget _buildSignUpButton() {
    return CustomSubmitButton(
      text: 'Sign Up',
      isLoading: _isLoading,
      isEnabled: _isTermsAccepted,
      onPressed: _onTapSignUp,
    );
  }

  /// Sign in link
  Widget _buildSignInLink() {
    return Center(
      child: RichText(
        text: TextSpan(
          children: [
            TextSpan(
              text: 'Already have an account? ',
              style: TextStyleHelper.instance.label10Regular.copyWith(
                height: 1.3,
              ),
            ),
            WidgetSpan(
              child: GestureDetector(
                onTap: _onTapSignIn,
                child: Text(
                  'Sign in',
                  style: TextStyleHelper.instance.label10Bold.copyWith(
                    height: 1.3,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  /// Handle sign up
  void _onTapSignUp() async {
    if (!_isTermsAccepted) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Please accept the Terms and Conditions')),
      );
      return;
    }

    if (_formKey.currentState!.validate()) {
      setState(() {
        _isLoading = true;
      });

      try {
        final email = _emailController.text.trim();
        final password = _passwordController.text.trim();
        final username = _usernameController.text.trim();

        await _signUp(email, password, username);

        setState(() {
          _isLoading = false;
        });

        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('Account created successfully! Please log in.'),
            backgroundColor: Colors.green,
          ),
        );

        // Navigate back to login
        NavigatorService.goBack();
      } on AuthException catch (e) {
        if (!mounted) return;
        setState(() => _isLoading = false);
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text(e.message)),
        );
      } on PostgrestException catch (e) {
        if (!mounted) return;
        setState(() => _isLoading = false);
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text(e.message)),
        );
      } catch (e) {
        if (!mounted) return;
        setState(() => _isLoading = false);
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Something went wrong. Please try again.')),
        );
      }
    }
  }

  Future<void> _signUp(String email, String password, String username) async {
    try {
      // On web, always use the fixed origin that is allowed in Supabase Auth URLs
      // Tip: you can make this configurable with a --dart-define later.
      final redirectUrl = kIsWeb ? 'http://localhost:5173' : null;

      final res = await Supabase.instance.client.auth.signUp(
        email: email,
        password: password,
        data: {'username': username},
        emailRedirectTo: redirectUrl,
      );

      final user = res.user;
      if (user == null) {
        throw const AuthException('Sign up failed. Check the email and password.');
      }

      // Only attempt profile write when there is a session (i.e., email confirmation OFF)
      if (res.session != null) {
        try {
          await Supabase.instance.client.from('profiles').upsert({
            'id': user.id,          // required by RLS (id == auth.uid())
            'username': username,
            'email': email,
            'role': 'user',
          });
        } catch (e) {
          debugPrint('profiles upsert error: $e');
        }
      } else {
        debugPrint('No session yet (email confirmation likely enabled).');
      }
    } on AuthException catch (e) {
      debugPrint('Auth signup error: ${e.message}');
      rethrow;
    } catch (e) {
      debugPrint('Unexpected signup error: $e');
      rethrow;
    }
  }

  /// Navigate back to sign in
  void _onTapSignIn() {
    NavigatorService.goBack();
  }
}
