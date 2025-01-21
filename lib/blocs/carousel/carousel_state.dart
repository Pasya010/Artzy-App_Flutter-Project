abstract class CarouselState {}

class CarouselInitial extends CarouselState {}

class CarouselLoading extends CarouselState {}

class CarouselLoaded extends CarouselState {
  final List<Map<String, dynamic>> items;

  CarouselLoaded(this.items);
}

class CarouselError extends CarouselState {
  final String message;

  CarouselError(this.message);
}
