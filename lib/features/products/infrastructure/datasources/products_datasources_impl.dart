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
  }) : dio = Dio(
    BaseOptions(
      baseUrl: Environment.apiUrl,
      headers: {
        'Authorization': 'Bearer $accesTocken'
      }
    )
  );

  Future<String> _uploadFile (String path) async {
    
    try{

      final fileName = path.split('/').last;
      final FormData data = FormData.fromMap({
        'file': MultipartFile.fromFileSync(path, filename: fileName),
      });

      final response = await dio.post('/files/product', data: data);

      return response.data['image'];

    } catch (e) {
      throw Exception();
    }

  }

  Future<List<String>> _uploadPhotos(List<String> photos) async {

    final photosToUpload = photos.where((element) => element.contains('/')).toList();
    final photosToIgnore = photos.where((element) => !element.contains('/')).toList();

    final List<Future<String>> uploadJob = photosToUpload.map(_uploadFile).toList();
    final newImages = await Future.wait(uploadJob);

    return [...photosToIgnore, ...newImages];

  }



  @override
  Future<Products> createUpdateProduct(Map<String, dynamic> productLike) async {
    try{

      final String? productId = productLike['id'];
      final String method = (productId == null) ? 'POST' : 'PATCH';
      final String url = (productId == null) ? '/products' : '/products/$productId';
      productLike.remove('id');
      productLike['images'] = await _uploadPhotos(productLike['images']);

      final response = await dio.request(
        url,
        data: productLike,
        options: Options(
          method: method
        )
      );

      final product = ProductMapper.jsonToEntity(response.data);
      return product;

    } catch (e) {
      throw Exception();
    }
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
    throw UnimplementedError();
  }

}