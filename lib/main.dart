import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

void main() {
  runApp(const MainApp());
}

class MainApp extends StatefulWidget {
  const MainApp({super.key});

  @override
  State<MainApp> createState() => _MainAppState();
}

class _MainAppState extends State<MainApp> {
  bool isDarkMode = false;

  void toggleDarkMode() {
    setState(() {
      isDarkMode = !isDarkMode;
    });
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: "CSB 2025 Course 4",
      initialRoute: '/',
      routes: {
        '/': (context) => WelcomeScreen(
          isDarkMode: isDarkMode,
          toggleDarkMode: toggleDarkMode,
          title: "Welcome screen",
        ),
        '/login': (context) => LoginScreen(
          isDarkMode: isDarkMode,
          toggleDarkMode: toggleDarkMode,
          title: "Login screen",
        ),
        '/home': (context) => HomeScreen(
          isDarkMode: isDarkMode,
          toggleDarkMode: toggleDarkMode,
          title: "Home screen",
        ),
      },
      themeMode: isDarkMode ? ThemeMode.dark : ThemeMode.light,
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(
          seedColor: Colors.blue,
          brightness: Brightness.light,
        ),
        textTheme: GoogleFonts.robotoTextTheme().apply(
          bodyColor: Colors.black,
          displayColor: Colors.black,
        ),
        scaffoldBackgroundColor: Colors.blue[100],
        appBarTheme: AppBarTheme(backgroundColor: Colors.blue[200]),
      ),
      darkTheme: ThemeData(
        colorScheme: ColorScheme.fromSeed(
          seedColor: Colors.blue,
          brightness: Brightness.dark,
        ),
        textTheme: GoogleFonts.robotoTextTheme().apply(
          bodyColor: Colors.white,
          displayColor: Colors.white,
        ),
        scaffoldBackgroundColor: Colors.blue[900],
        appBarTheme: AppBarTheme(backgroundColor: Colors.blue[600]),
      ),
    );
  }
}

class AppBarWithThemeToggle extends StatelessWidget
    implements PreferredSizeWidget {
  final bool isDarkMode;
  final void Function() toggleDarkMode;
  final String title;

  const AppBarWithThemeToggle({
    super.key,
    required this.isDarkMode,
    required this.toggleDarkMode,
    required this.title,
  });

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);

  @override
  Widget build(BuildContext context) {
    return AppBar(
      title: Text(title),
      actions: [
        IconButton(
          onPressed: toggleDarkMode,
          icon: Icon(isDarkMode ? Icons.light_mode : Icons.dark_mode),
        ),
      ],
    );
  }
}

class WelcomeScreen extends StatelessWidget {
  final bool isDarkMode;
  final String title;
  final void Function() toggleDarkMode;

  const WelcomeScreen({
    super.key,
    required this.isDarkMode,
    required this.toggleDarkMode,
    required this.title,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBarWithThemeToggle(
        isDarkMode: isDarkMode,
        toggleDarkMode: toggleDarkMode,
        title: title,
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            Text("Hello", style: Theme.of(context).textTheme.headlineLarge),
            // SizedBox(height: 16.0),
            Image.network(
              "https://images.unsplash.com/photo-1765220066469-54d4efe41ca5?q=80&w=768&auto=format&fit=crop&ixlib=rb-4.1.0&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D",
              loadingBuilder:
                  (
                    BuildContext context,
                    Widget child,
                    ImageChunkEvent? loadingProgress,
                  ) {
                    if (loadingProgress == null) return child;

                    return Center(
                      child: CircularProgressIndicator(
                        value: loadingProgress.expectedTotalBytes != null
                            ? loadingProgress.cumulativeBytesLoaded /
                                  loadingProgress.expectedTotalBytes!
                            : null,
                      ),
                    );
                  },
              errorBuilder: (context, error, stackTrace) {
                return Center(
                  child: Text("Sorry, there was an error loading the image"),
                );
              },
            ),
            // SizedBox(height: 16.0),
            ElevatedButton(
              onPressed: () {
                Navigator.pushNamed(context, '/login');
              },
              child: const Text("login"),
            ),
          ],
        ),
      ),
    );
  }
}

class LoginScreen extends StatefulWidget {
  final bool isDarkMode;
  final String title;
  final void Function() toggleDarkMode;

  const LoginScreen({
    super.key,
    required this.isDarkMode,
    required this.toggleDarkMode,
    required this.title,
  });

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final _formKey = GlobalKey<FormState>();
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();

  bool isPasswordVisible = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBarWithThemeToggle(
        isDarkMode: widget.isDarkMode,
        toggleDarkMode: widget.toggleDarkMode,
        title: widget.title,
      ),
      body: Padding(
        padding: const EdgeInsetsGeometry.all(16.0),
        child: Form(
          key: _formKey,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              TextFormField(
                controller: _emailController,
                validator: (value) =>
                    value == null || value.isEmpty ? "Email is required" : null,
                decoration: InputDecoration(
                  labelText: "Email",
                  hintText: "Eneter your email here",
                ),
              ),
              SizedBox(height: 16.0),
              TextFormField(
                obscureText: !isPasswordVisible,
                controller: _passwordController,
                validator: (value) => value == null || value.isEmpty
                    ? "Password is required"
                    : null,
                decoration: InputDecoration(
                  labelText: "Password",
                  hintText: "Eneter your password here",
                  suffixIcon: IconButton(
                    icon: Icon(
                      isPasswordVisible
                          ? Icons.visibility
                          : Icons.visibility_off,
                    ),
                    onPressed: () {
                      setState(() {
                        isPasswordVisible = !isPasswordVisible;
                      });
                    },
                  ),
                ),
              ),
              SizedBox(height: 16.0),
              ElevatedButton(
                onPressed: () {
                  String email = _emailController.text;
                  String password = _passwordController.text;

                  if (_formKey.currentState!.validate()) {
                    if (email == "user@test.test" && password == "pass") {
                      Navigator.pushNamed(context, '/home');
                    } else {
                      // showDialog(
                      //   context: context,
                      //   barrierDismissible: false,
                      //   builder: (context) => AlertDialog(
                      //     title: Text("Invalid credentials"),
                      //     content: Text("Your credentials are invalid!"),
                      //     actions: [
                      //       ElevatedButton(
                      //         onPressed: () {
                      //           Navigator.pop(context);
                      //         },
                      //         child: Text("OK"),
                      //       ),
                      //     ],
                      //   ),
                      // );
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(
                          content: Text("Invalid credentials"),
                          duration: Duration(seconds: 3),
                        ),
                      );
                    }
                  }
                },
                child: const Text("Login"),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class HomeScreen extends StatelessWidget {
  final bool isDarkMode;
  final String title;
  final void Function() toggleDarkMode;

  const HomeScreen({
    super.key,
    required this.isDarkMode,
    required this.toggleDarkMode,
    required this.title,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBarWithThemeToggle(
        isDarkMode: isDarkMode,
        toggleDarkMode: toggleDarkMode,
        title: title,
      ),
      body: Center(child: Text("You are logged in!")),
    );
  }
}
