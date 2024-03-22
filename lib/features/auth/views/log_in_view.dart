import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:public_chat_app/constants/spacing.dart';
import 'package:public_chat_app/extension/app_extension.dart';
import 'package:public_chat_app/features/auth/views/sign_up_view.dart';
import 'package:public_chat_app/features/auth/bloc/auth_bloc.dart';
import 'package:public_chat_app/features/chat/view/chat_view.dart';

// ignore: must_be_immutable
class LoginView extends StatelessWidget {
  LoginView({super.key});
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    final bloc = context.read<AuthBloc>();
    return BlocConsumer<AuthBloc, AuthState>(
      listener: (context, state) {
        if (state is LogInErrorState) {
          context.showErrorSnackBar(state.msg);
        }
        if (state is LogInSuccessState) {
          context.pushAndRemove(const ChatView());
        }
      },
      builder: (context, state) {
        return Scaffold(
          resizeToAvoidBottomInset: false,
          backgroundColor: Colors.white,
          body: SafeArea(
            child: Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const CircleAvatar(
                    radius: 60,
                    backgroundColor: Color.fromARGB(255, 79, 158, 143),
                    child: Icon(
                      Icons.person_4_outlined,
                      size: 70,
                      color: Colors.white,
                    ),
                  ),
                  kV16,
                  Container(
                    margin: const EdgeInsets.symmetric(horizontal: 20),
                    padding: const EdgeInsets.symmetric(
                        vertical: 20, horizontal: 15),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: Column(
                      children: [
                        const Text(
                          "Welcome Back!",
                          style: TextStyle(
                            fontSize: 25,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        const Text(
                          "Sign in to continue",
                          style: TextStyle(
                            fontSize: 17,
                          ),
                        ),
                        kV16,
                        TextField(
                          controller: emailController,
                          decoration: const InputDecoration(
                            labelText: "Email",
                            border: OutlineInputBorder(),
                          ),
                        ),
                        kV8,
                        TextField(
                          controller: passwordController,
                          obscureText: true,
                          decoration: const InputDecoration(
                            labelText: "Password",
                            border: OutlineInputBorder(),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.all(5),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              const Text(
                                "Dom't have an account?",
                                style: TextStyle(
                                  fontWeight: FontWeight.w500,
                                ),
                              ),
                              InkWell(
                                onTap: () {
                                  context.pushTo(SignUpView());
                                },
                                child: Text(
                                  "Sign Up",
                                  style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                    fontSize: 17,
                                    color: Colors.red[300],
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                        kV16,
                        InkWell(
                          onTap: () {
                            bloc.add(
                              LoginEvent(
                                emailController.text,
                                passwordController.text,
                              ),
                            );
                          },
                          child: Container(
                            padding: const EdgeInsets.symmetric(
                              horizontal: 15,
                              vertical: 5,
                            ),
                            decoration: BoxDecoration(
                              color: const Color.fromARGB(255, 255, 242, 154),
                              borderRadius: BorderRadius.circular(20),
                            ),
                            child: const Text(
                              "Sign in",
                              style: TextStyle(
                                // color: Colors.white,
                                fontSize: 20,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                        )
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}
