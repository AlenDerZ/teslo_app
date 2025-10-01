
import 'package:image_picker/image_picker.dart';

import 'camera_gallery_service.dart';

class CameraGalleryServiceImpl extends CameraGalleryService {

  final ImagePicker _picker = ImagePicker();

  @override
  Future<String?> selectPhoto() async {

    final XFile? photo = await _picker.pickImage(
      source: ImageSource.gallery,
      imageQuality: 80,
      preferredCameraDevice: CameraDevice.rear,
    );

    if(photo == null) return null;
    
    return photo.path;
  }

  @override
  Future<List<String>> selectedMultiplePhotos() async {
    
    final List<XFile> images = await _picker.pickMultiImage();

    if(images.isEmpty) return [];

    // print('Tenemos unas imagenes ${images.map((e) => e.path)}');

    return images.map((e) => e.path).toList();

  }

  @override
  Future<String?> takePhoto() async {
    
    final XFile? photo = await _picker.pickImage(
      source: ImageSource.camera,
      imageQuality: 80,
      preferredCameraDevice: CameraDevice.rear,
    );

    if(photo == null) return null;

    return photo.path;

  }

}