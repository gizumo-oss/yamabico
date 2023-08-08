import 'package:amplify_auth_cognito/amplify_auth_cognito.dart';
import 'package:amplify_flutter/amplify_flutter.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:flutter/material.dart';
import 'package:yamabico/feature/auth/presentation/login_screen.dart';
import 'package:yamabico/guest_top_screen.dart';
import 'package:yamabico/feature/posts/presentation/index_screen.dart';

import 'feature/auth/infra/amplifyconfiguration.dart';

// INFO: ディレクトリ構成参考https://qiita.com/MLLB/items/95617322a7d984b7e402

void main() async {
  await dotenv.load(fileName: '.env');

  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  bool _isAuth = false;

  @override
  void initState() {
    super.initState();
    _configureAmplify().then((value) => {
      _isAuthenticated().then((result) => _isAuth = result)
    });
  }

  Future<void> _configureAmplify() async {
    try {
      await Amplify.addPlugin(AmplifyAuthCognito());
      await Amplify.configure(amplifyconfig);
      safePrint('Successfully configured');
    } on Exception catch (e) {
      safePrint('Error configuring Amplify: $e');
    }
  }

  Future<bool> _isAuthenticated() async {
    final authState = await Amplify.Auth.fetchAuthSession();
    return authState.isSignedIn;
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      initialRoute: _isAuth ? '/posts' : '/',
      routes: {
        '/': (context) => const GuestTopScreen(),
        '/login': (context) => const LoginScreen(),
        '/posts': (context) => const IndexScreen(),
      },
    );
  }
}
