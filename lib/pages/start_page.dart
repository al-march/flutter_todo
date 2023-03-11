import 'package:flutter/material.dart';
import 'package:todo_app/pages/todo_page.dart';

class StartPage extends StatelessWidget {
  const StartPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Welcome!'),
      ),
      body: Center(
        child: Container(
          padding: const EdgeInsets.all(15.0),
          constraints: const BoxConstraints(minWidth: 300, maxWidth: 500),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Image(image: AssetImage('assets/images/sofa-man.png')),
              const Text(
                "Get things done with TODo",
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 30,
                  fontWeight: FontWeight.w600,
                ),
              ),
              const SizedBox(height: 40),
              Container(
                constraints: const BoxConstraints(maxWidth: 400),
                child: const Text(
                  "Lorem ipsum dolor sit amet, consectetur adipisicing. Maxime, tempore! Animi nemo aut atque,  deleniti nihil dolorem repellendus.",
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: 15,
                    fontWeight: FontWeight.w300,
                  ),
                ),
              ),
              const SizedBox(height: 20),
              ElevatedButton(
                onPressed: () => {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => const TodoPage(),
                      ))
                },
                child: const Padding(
                  padding: EdgeInsets.all(12.0),
                  child: Text("Get started"),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
