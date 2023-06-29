part of 'image_grid_cubit.dart';

abstract class ImageGridState {}

class ImageGridInitial extends ImageGridState {}

class ImageGridLoaded extends ImageGridState {
  List<String> profileImageUrl;
  ImageGridLoaded({required this.profileImageUrl});
}

class ImageGridError extends ImageGridState {}
