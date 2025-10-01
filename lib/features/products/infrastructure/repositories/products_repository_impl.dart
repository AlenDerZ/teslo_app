import 'package:teslo_app/features/products/domain/domain.dart';

class ProductsRepositoryImpl extends ProductsRepository{

  final ProductsDatasource datasource;

  ProductsRepositoryImpl(this.datasource);

  @override
  Future<Products> createUpdateProduct(Map<String, dynamic> productLike) {
    return datasource.createUpdateProduct(productLike);
  }

  @override
  Future<Products> getProductsById(String id) {
    return datasource.getProductsById(id);
  }

  @override
  Future<List<Products>> getProductsByPage({int limit = 10, int offset = 0}) {
    return datasource.getProductsByPage(limit: limit, offset: offset);
  }

  @override
  Future<List<Products>> searchProductsByTerm(String term) {
    return datasource.searchProductsByTerm(term);
  }

}