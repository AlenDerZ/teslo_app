import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:formz/formz.dart';
import 'package:teslo_app/config/config.dart';
import 'package:teslo_app/features/products/domain/domain.dart';
import 'package:teslo_app/features/products/presentation/providers/product_repository_provider.dart';
import 'package:teslo_app/features/shared/shared.dart';


final productFormProvider = StateNotifierProvider.autoDispose.family<productFormNotifier, ProductFormState, Products>(
  (ref, product) {

    final createUpdateCallback = ref.watch(productRepositoryProvider).createUpdateProduct;

    return productFormNotifier(
      product: product,
      onSubmitCallback: createUpdateCallback
    );
  }
);

class productFormNotifier extends StateNotifier<ProductFormState> {

  final Future<Products> Function(Map<String, dynamic> productLike)? onSubmitCallback;

  productFormNotifier({
    this.onSubmitCallback,
    required Products product
  }): super(ProductFormState(
    id: product.id,
    title: Tittle.dirty(product.title),
    slug: Slug.dirty(product.slug),
    price: Price.dirty(product.price),
    inStock: Stock.dirty(product.stock),
    sizes: product.sizes,
    gender: product.gender,
    description: product.description,
    tags: product.tags.join(','),
    images: product.images
  ));

  void onTitleChanged(String value) {
    state = state.copyWith(
      title: Tittle.dirty(value),
      isFormValid: Formz.validate([
        Tittle.dirty(value),
        Slug.dirty(state.slug.value),
        Price.dirty(state.price.value),
        Stock.dirty(state.inStock.value),
      ])
    );
  }

  void onSlugChanged(String value) {
    state = state.copyWith(
      slug: Slug.dirty(value),
      isFormValid: Formz.validate([
        Tittle.dirty(state.title.value),
        Slug.dirty(value),
        Price.dirty(state.price.value),
        Stock.dirty(state.inStock.value),
      ])
    );
  }

  void onPriceChanged(double value) {
    state = state.copyWith(
      price: Price.dirty(value),
      isFormValid: Formz.validate([
        Tittle.dirty(state.title.value),
        Slug.dirty(state.slug.value),
        Price.dirty(value),
        Stock.dirty(state.inStock.value),
      ])
    );
  }

  void onStockChanged(int value) {
    state = state.copyWith(
      inStock: Stock.dirty(value),
      isFormValid: Formz.validate([
        Tittle.dirty(state.title.value),
        Slug.dirty(state.slug.value),
        Price.dirty(state.price.value),
        Stock.dirty(value),
      ])
    );
  }

  void onSizeChanged(List<String> sizes) {
    state = state.copyWith(
      sizes: sizes
    );
  }

  void onGenderChanged(String gender) {
    state = state.copyWith(
      gender: gender
    );
  }

  void onDescriptionChanged(String description) {
    state = state.copyWith(
      description: description
    );
  }

  void onTagsChanged(String tags) {
    state = state.copyWith(
      tags: tags
    );
  }

  void _touchedEverthing(){
    state = state.copyWith(
      isFormValid: Formz.validate([
        Tittle.dirty(state.title.value),
        Slug.dirty(state.slug.value),
        Price.dirty(state.price.value),
        Stock.dirty(state.inStock.value),
      ])
    );
  }

  Future<bool> onFormSubmit() async {
    _touchedEverthing();
    if(!state.isFormValid) return false;

    if(onSubmitCallback == null)  return false;

    final productLike = {
      "id": state.id,
      "title": state.title.value,
      "price": state.price.value,
      "description": state.description,
      "slug": state.slug.value,
      "stock": state.inStock.value,
      "sizes": state.sizes,
      "gender": state.gender,
      "tags": state.tags.split(','),
      "images": state.images.map(
        (image) => image.replaceAll('${Environment.apiUrl}/files/product/', '')
      ).toList()
    };

    try{

      await onSubmitCallback!(productLike);
      return true;
      
    } catch (e) {
      return false;
    }

  }
}

class ProductFormState {

  final bool isFormValid;
  final String? id;
  final Tittle title;
  final Slug slug;
  final Price price;
  final Stock inStock;
  final List<String> sizes;
  final String gender;
  final String description;
  final String tags;
  final List<String> images;

  ProductFormState({
    this.isFormValid = false,
    this.id,
  this.title = const Tittle.dirty(''),
    this.slug = const Slug.dirty(''), 
    this.price = const Price.dirty(0),
    this.inStock = const Stock.dirty(0),
    this.sizes = const [],
    this.gender = 'unisex',
    this.description = '',
    this.tags = '',
    this.images = const [],
  });

  ProductFormState copyWith({
    bool? isFormValid,
    String? id,
    Tittle? title,
    Slug? slug,
    Price? price,
    Stock? inStock,
    List<String>? sizes,
    String? gender,
    String? description,
    String? tags,
    List<String>? images
  }) => ProductFormState(
    isFormValid: isFormValid ?? this.isFormValid,
    id: id ?? this.id,
    title: title ?? this.title,
    slug: slug ?? this.slug,
    price: price ?? this.price,
    inStock: inStock ?? this.inStock,
    sizes: sizes ?? this.sizes,
    gender: gender ?? this.gender,
    description: description ?? this.description,
    tags: tags ?? this.tags,
    images: images ?? this.images
  );
}