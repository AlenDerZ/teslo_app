import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:teslo_app/features/products/domain/domain.dart';

import 'product_repository_provider.dart';

final productProvider = StateProvider.autoDispose.family<ProductNotifier, String>(
  (ref, productId) {

    final productRepository = ref.watch(productRepositoryProvider);

  return ProductNotifier(
    productsRepository: productRepository, 
    productId: productId
  );
});

class ProductNotifier extends StateNotifier<ProductState> {

  final ProductsRepository productsRepository;

  ProductNotifier({
    required this.productsRepository,
    required String productId
  }): super( ProductState(id: productId));

  Future<void> loadProduct() async{
    
  }
}

class ProductState {

  final String id; 
  final Products? product;
  final bool isLoading;
  final bool isSaving;

  ProductState({
    required this.id, 
    this.product, 
    this.isLoading = true, 
    this.isSaving = false
  });

  ProductState copyWith({
    String? id,
    Products? product,
    bool? isLoading,
    bool? isSaving
  }) => ProductState(
    id: id ?? this.id,
    product: product ?? this.product,
    isLoading: isLoading ?? this.isLoading,
    isSaving: isSaving ?? this.isSaving
  );

}