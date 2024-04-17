import 'package:flutter/material.dart';
import 'package:login_list_products/core/exceptions/base_exception.dart';
import 'package:login_list_products/models/user_entity.dart';
import 'package:login_list_products/services/auth_services.dart';
import 'package:login_list_products/services/objectbox_services.dart';
import 'package:login_list_products/view/pages/product_page.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'auth_controller.g.dart';

@riverpod
class AuthController extends _$AuthController {
  @override
  void build() {}

  Future<void> loginUser(BuildContext context,
      {required String userName, required String password}) async {
    try {
      final userDetails =
          await AuthServices.loginWithUserNameAndPassowrd(userName, password);

      ObjectBox.instance.user.put(
        UserEntity(
          username: userDetails.username,
          email: userDetails.email,
          firstName: userDetails.firstName,
          lastName: userDetails.lastName,
          gender: userDetails.gender,
          image: userDetails.image,
          token: userDetails.token,
        ),
      );

      Future.sync(() {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text(
              "Authentication Successfull",
              style: Theme.of(context)
                  .textTheme
                  .titleMedium
                  ?.copyWith(color: Colors.white),
            ),
            backgroundColor: Colors.green,
          ),
        );
        Navigator.pushAndRemoveUntil(
            context,
            MaterialPageRoute(
              builder: (context) => const ProductScreen(),
            ),
            (route) => false);
      });
    } on BaseException catch (e) {
      Future.sync(() => ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text(
                e.toString(),
                style: Theme.of(context)
                    .textTheme
                    .titleMedium
                    ?.copyWith(color: Theme.of(context).colorScheme.onError),
              ),
              backgroundColor: Theme.of(context).colorScheme.error,
            ),
          ));
    }
  }
}
