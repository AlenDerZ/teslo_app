import 'package:dio/dio.dart';
import 'package:teslo_app/config/config.dart';
import 'package:teslo_app/features/products/domain/domain.dart';
import 'package:teslo_app/features/products/infrastructure/errors/product_errors.dart';
import 'package:teslo_app/features/products/infrastructure/mappers/product_mapper.dart';

class ProductsDatasourcesImpl extends ProductsDatasource {

  late final Dio dio;
  final String accesTocken;

  ProductsDatasourcesImpl({
    required this.accesTocken
  }) : dio = Dio(BaseOptions(
    baseUrl: Environment.apiUrl,
    headers: {
      'Authorization': 'Bearer $accesTocken'
    }
  ));

  @override
  Future<Products> createUpdateProduct(Map<String, dynamic> productLike) {
    // TODO: implement createUpdateProduct
    throw UnimplementedError();
  }

  @override
  Future<Products> getProductsById(String id) async {
    try{
      final response = await dio.get('/products/$id');
      final product = ProductMapper.jsonToEntity(response.data);
      return product;

    } on DioException catch (i) {

      if(i.response?.statusCode == 404) throw ProductNotFound();
      throw Exception();
      
    }catch (e){
      throw Exception();
    }
  }

  @override
  Future<List<Products>> getProductsByPage({int limit = 10, int offset = 0}) async {
    final response = await dio.get<List>('/products?limit=$limit&offset=$offset');
    final List<Products> products = [];

    for (var product in response.data ?? []) {
      products.add(ProductMapper.jsonToEntity(product));
    }

    return products;
  }

  @override
  Future<List<Products>> searchProductsByTerm(String term) {
    // TODO: implement searchProductsByTerm
    throw UnimplementedError();
  }

}