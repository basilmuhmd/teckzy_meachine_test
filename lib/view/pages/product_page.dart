import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:login_list_products/controller/product_controller.dart';
import 'package:login_list_products/models/product_model.dart';
import 'package:login_list_products/services/objectbox_services.dart';
import 'package:login_list_products/view/pages/authentication_page.dart';

class ProductPage extends ConsumerWidget {
  const ProductPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final userDetails = ObjectBox.instance.user.getAll().firstOrNull;
    return Scaffold(
      appBar: AppBar(
        title: ListTile(
          leading: CircleAvatar(
            backgroundImage:
                userDetails == null ? null : NetworkImage(userDetails.image),
          ),
          title: Text("${userDetails?.firstName} ${userDetails?.lastName}"),
          subtitle: Text("${userDetails?.email}"),
        ),
        actions: [
          ElevatedButton.icon(
            onPressed: () {
              ObjectBox.instance.user.removeAll();
              Navigator.pushAndRemoveUntil(
                  context,
                  MaterialPageRoute(
                    builder: (context) => AuthenticationPage(),
                  ),
                  (route) => false);
            },
            icon: const Icon(Icons.logout),
            label: const Text("Logout"),
          ),
        ],
      ),
      body: SafeArea(
        child: ref.watch(getProductsProvider).isLoading
            ? const Center(child: CircularProgressIndicator())
            : ref.watch(getProductsProvider).when(
                  data: (data) => ListView.builder(
                    itemCount: data.length,
                    shrinkWrap: true,
                    itemBuilder: (context, index) => ListTile(
                      onTap: () {
                        showDialog(
                          context: context,
                          builder: (context) => ProductDetailsDialog(
                            product: data[index],
                          ),
                        );
                      },
                      leading: SizedBox(
                        width: 100,
                        height: 56,
                        child: Image.network(
                          data[index].thumbnail,
                          fit: BoxFit.cover,
                        ),
                      ),
                      title: Text(data[index].title),
                      subtitle: Text(data[index].price.toString()),
                    ),
                  ),
                  error: (error, stackTrace) => Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(error.toString()),
                      IconButton(
                        onPressed: () {
                          ref.invalidate(getProductsProvider);
                        },
                        icon: const Icon(Icons.refresh),
                      ),
                    ],
                  ),
                  loading: () =>
                      const Center(child: CircularProgressIndicator()),
                ),
      ),
    );
  }
}

class ProductDetailsDialog extends StatelessWidget {
  final ProductModel product;

  const ProductDetailsDialog({
    super.key,
    required this.product,
  });

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisSize: MainAxisSize.min,
        children: [
          Text(product.title),
          Text(
            product.category,
            style: Theme.of(context).textTheme.bodyLarge,
          ),
        ],
      ),
      content: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisSize: MainAxisSize.min,
        children: [
          SizedBox(
            width: double.infinity,
            height: MediaQuery.sizeOf(context).height * 0.3,
            child: Image.network(
              product.thumbnail,
              fit: BoxFit.fill,
            ),
          ),
          const SizedBox(height: 16),
          Text(product.brand),
          Text(product.description),
        ],
      ),
      actions: [
        ElevatedButton(
          onPressed: () => Navigator.pop(context),
          child: const Text("Close"),
        ),
      ],
    );
  }
}
