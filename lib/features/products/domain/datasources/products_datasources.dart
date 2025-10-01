import 'package:teslo_app/features/products/domain/entities/product.dart';

abstract class ProductsDatasource {

  Future<List<Products>> getProductsByPage({int limit = 10, int offset = 0});
  Future<Products> getProductsById(String id);

  Future<List<Products>> searchProductsByTerm(String term); 

  Future<Products> createUpdateProduct(Map<String,dynamic> productLike);
}