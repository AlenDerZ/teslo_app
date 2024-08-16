import 'package:teslo_app/features/products/domain/domain.dart';

class ProductsDatasourcesImpl extends ProductsDatasource {
  @override
  Future<Products> createUpdateProduct(Map<String, dynamic> productLike) {
    // TODO: implement createUpdateProduct
    throw UnimplementedError();
  }

  @override
  Future<Products> getProductsById(String id) {
    // TODO: implement getProductsById
    throw UnimplementedError();
  }

  @override
  Future<List<Products>> getProductsByPage({int limit = 10, int offset = 0}) {
    // TODO: implement getProductsByPage
    throw UnimplementedError();
  }

  @override
  Future<List<Products>> searchProductsByTerm(String term) {
    // TODO: implement searchProductsByTerm
    throw UnimplementedError();
  }

}