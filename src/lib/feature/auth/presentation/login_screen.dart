import 'package:amplify_authenticator/amplify_authenticator.dart';
import 'package:flutter/material.dart';
import 'package:yamabico/feature/auth/presentation/amplify_cognito_resolver.dart';

class LoginScreen extends StatelessWidget {
  const LoginScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Authenticator(
      stringResolver: stringResolver,
      authenticatorBuilder: (BuildContext context, AuthenticatorState state) {
        switch (state.currentStep) {
          case AuthenticatorStep.signIn:
            return CustomScaffold(
              state: state,
              body: SignInForm(),
            );
          case AuthenticatorStep.resetPassword:
            return CustomScaffold(
              state: state,
              body: ResetPasswordForm(),
            );
          case AuthenticatorStep.confirmResetPassword:
            return CustomScaffold(
              state: state,
              body: const ConfirmResetPasswordForm(),
            );
          default:
            return null;
        }
      },
      child: MaterialApp(
        builder: Authenticator.builder(),
        home: Scaffold(
          appBar: AppBar(title: const Text('ホーム')),
          body: const Center(
            child: Text('ログイン成功！', style: TextStyle(fontSize: 32.0)),
          ),
        ),
      ),
    );
  }
}

final class CustomScaffold extends StatelessWidget {
  const CustomScaffold({
    super.key,
    required this.state,
    required this.body,
    this.footer,
  });

  final AuthenticatorState state;
  final Widget body;
  final Widget? footer;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.fromLTRB(16.0, 150.0, 16.0, 150.0),
        child: SingleChildScrollView(
          child: Column(
            children: [
              // App logo
              const Padding(
                padding: EdgeInsets.only(top: 32),
                child: Center(child: FlutterLogo(size: 100)),
              ),
              Container(
                constraints: const BoxConstraints(maxWidth: 600),
                child: body,
              ),
            ],
          ),
        ),
      ),
      persistentFooterButtons: footer != null ? [footer!] : null,
    );
  }
}
