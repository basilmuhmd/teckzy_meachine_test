import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:login_list_products/controller/auth_controller.dart';
import 'package:login_list_products/view/widgets/auth_form_field_widget.dart';

class AuthenticationPage extends HookConsumerWidget {
  AuthenticationPage({super.key});

  final formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final userNameController = useTextEditingController(text: 'kminchelle');
    final passwordController = useTextEditingController(text: '0lelplR');
    final loading = useState(false);

    return Scaffold(
      backgroundColor: Colors.black,
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20),
        child: Form(
          key: formKey,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                "Login To See\nProducts",
                style: Theme.of(context).textTheme.displaySmall,
              ),
              const SizedBox(height: 24),
              AuthFormFieldWidget(
                controller: userNameController,
                hintText: "User Name",
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Username must be provided';
                  } else {
                    return null;
                  }
                },
              ),
              const SizedBox(
                height: 20,
              ),
              AuthFormFieldWidget(
                controller: passwordController,
                hintText: 'Password',
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Password must be provided';
                  } else {
                    return null;
                  }
                },
              ),
              const SizedBox(
                height: 48,
              ),
              ElevatedButton(
                onPressed: () async {
                  if (formKey.currentState!.validate()) {
                    FocusScope.of(context).unfocus();
                    loading.value = true;
                    await ref.read(authControllerProvider.notifier).loginUser(
                        context,
                        userName: userNameController.text,
                        password: passwordController.text);
                    loading.value = false;
                  }
                },
                style: ElevatedButton.styleFrom(
                  minimumSize: const Size(double.infinity, 48),
                ),
                child: loading.value
                    ? const SizedBox(
                        width: 24,
                        height: 24,
                        child: CircularProgressIndicator(
                          strokeWidth: 3,
                        ),
                      )
                    : const Text("Login"),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
