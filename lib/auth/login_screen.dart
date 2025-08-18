import 'package:flutter/material.dart';
import '../core/app_export.dart';
import '../widgets/custom_image_view.dart';
import '../widgets/custom_submit_button.dart';
import '../widgets/custom_text_field.dart';

/// Login screen for iBorrow application
/// Supports both user and admin authentication
class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final _formKey = GlobalKey<FormState>();
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  bool _isRememberMe = false;
  bool _isLoading = false;
  bool _obscurePassword = true;

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: appTheme.colorFFFFF2,
        body: SizedBox(
          width: double.maxFinite,
          height: MediaQuery.of(context).size.height,
          child: SingleChildScrollView(
            child: Column(
              children: [
                _buildHeaderSection(),
                _buildOrangeUnderline(),
                _buildLoginForm(),
              ],
            ),
          ),
        ),
      ),
    );
  }

    /// Header section with background image and title
  Widget _buildHeaderSection() {
    return SizedBox(
      height: 527.v,
      width: double.infinity,
      child: Stack(
        alignment: Alignment.topLeft,
        children: [
          CustomImageView(
            imagePath: ImageConstant.imgRectangle7,
            height: 472.v,
            width: double.infinity,
            alignment: Alignment.topLeft,
            fit: BoxFit.cover,
          ),
          CustomImageView(
            imagePath: ImageConstant.imgImage2,
            height: 496.v,
            width: double.infinity,
            alignment: Alignment.topLeft,
            fit: BoxFit.cover,
          ),
          Positioned(
            top: 475.v,
            left: 35.h,
            child: SizedBox(
              width: 150.h,
              height: 52.h,
              child: Text(
                'iBorrow\nLog In',
                style: TextStyleHelper.instance.display36RegularInter.copyWith(
                  height: 1.22,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  /// Orange underline below title
  Widget _buildOrangeUnderline() {
    return Container(
      margin: EdgeInsets.only(left: 35.h, top: 5.h),
      width: 70.h,
      height: 2.h,
      color: appTheme.colorFFFC85,
    );
  }

  /// Main login form
  Widget _buildLoginForm() {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 35.h),
      margin: EdgeInsets.only(top: 31.h),
      child: Form(
        key: _formKey,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _buildEmailField(),
            SizedBox(height: 24.h),
            _buildPasswordField(),
            SizedBox(height: 10.h),
            _buildRememberAndForgotSection(),
            SizedBox(height: 24.h),
            _buildLoginButton(),
            SizedBox(height: 23.h),
            _buildSignUpLink(),
            SizedBox(height: 40.h),
          ],
        ),
      ),
    );
  }

  /// Email input field
  Widget _buildEmailField() {
    return CustomTextField(
      controller: _emailController,
      labelText: 'Email',
      hintText: 'Enter your email',
      keyboardType: TextInputType.emailAddress,
      prefixIcon: Padding(
        padding: EdgeInsets.all(12.h),
        child: CustomImageView(
          imagePath: ImageConstant.imgMaterialsymbolslightmailoutline,
          height: 24.h,
          width: 24.h,
        ),
      ),
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
        return null;
      },
    );
  }

  /// Remember me and forgot password section
  Widget _buildRememberAndForgotSection() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Row(
          children: [
            GestureDetector(
              onTap: () {
                setState(() {
                  _isRememberMe = !_isRememberMe;
                });
              },
              child: Container(
                width: 15.h,
                height: 15.h,
                decoration: BoxDecoration(
                  color: appTheme.colorFFFFF2,
                  border: Border.all(color: appTheme.colorFFBA5A),
                  borderRadius: BorderRadius.circular(2.h),
                ),
                child: _isRememberMe
                    ? Container(
                        margin: EdgeInsets.all(3.h),
                        decoration: BoxDecoration(
                          color: appTheme.colorFFBA5A,
                          borderRadius: BorderRadius.circular(2.h),
                        ),
                      )
                    : null,
              ),
            ),
            SizedBox(width: 8.h),
            GestureDetector(
              onTap: () {
                setState(() {
                  _isRememberMe = !_isRememberMe;
                });
              },
              child: Text(
                'Remember me',
                style: TextStyleHelper.instance.label10RegularInter.copyWith(
                  height: 1.30,
                ),
              ),
            ),
          ],
        ),
        GestureDetector(
          onTap: _onTapForgotPassword,
          child: Text(
            'Forgot your password?',
            style: TextStyleHelper.instance.label10BoldInter.copyWith(
              height: 1.30,
            ),
          ),
        ),
      ],
    );
  }

  /// Login button
  Widget _buildLoginButton() {
    return CustomSubmitButton(
      text: 'Login',
      isLoading: _isLoading,
      onPressed: _onTapLogin,
    );
  }

  /// Sign up link
  Widget _buildSignUpLink() {
    return Center(
      child: RichText(
        text: TextSpan(
          children: [
            TextSpan(
              text: "Don't have an Account? ",
              style: TextStyleHelper.instance.label10RegularInter.copyWith(
                height: 1.30,
              ),
            ),
            WidgetSpan(
              child: GestureDetector(
                onTap: _onTapSignUp,
                child: Text(
                  'Sign Up',
                  style: TextStyleHelper.instance.label10BoldInter.copyWith(
                    height: 1.30,
                  ),
                ),
              ),
            ),
          ],
        ),
        textAlign: TextAlign.center,
      ),
    );
  }

  /// Handle forgot password
  void _onTapForgotPassword() {
    // TODO: Implement forgot password functionality
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text('Forgot password functionality coming soon!')),
    );
  }

  /// Handle login
  void _onTapLogin() async {
    if (_formKey.currentState!.validate()) {
      setState(() {
        _isLoading = true;
      });

      try {
        final email = _emailController.text.trim();
        final password = _passwordController.text.trim();

        await Supabase.instance.client.auth.signInWithPassword(
          email: email,
          password: password,
        );

        if (!mounted) return;

        setState(() {
          _isLoading = false;
        });

        // Simple admin heuristic (replace with role from profile if needed)
        if (email.toLowerCase().contains('admin')) {
          NavigatorService.pushReplacementNamed(AppRoutes.adminDashboard);
        } else {
          NavigatorService.pushReplacementNamed(AppRoutes.userDashboard);
        }
      } on AuthException catch (e) {
        if (!mounted) return;
        setState(() => _isLoading = false);
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text(e.message)),
        );
      } catch (e) {
        if (!mounted) return;
        setState(() => _isLoading = false);
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Login failed. Please try again.')),
        );
      }
    }
  }

  /// Navigate to sign up
  void _onTapSignUp() {
    NavigatorService.pushNamed(AppRoutes.signupScreen);
  }
}
