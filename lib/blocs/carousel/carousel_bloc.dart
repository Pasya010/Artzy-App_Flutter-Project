import 'package:arty_app/blocs/carousel/carousel_event.dart';
import 'package:arty_app/blocs/carousel/carousel_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class CarouselBloc extends Bloc<CarouselEvent, CarouselState> {
  CarouselBloc() : super(CarouselInitial()) {
    on<LoadCarouselItems>(
      (event, emit) async {
        emit(CarouselLoading());
        await Future.delayed(Duration(milliseconds: 300));
        final items = [
          {'title': 'Ichi', 'images': 'assets/images/1.jpg'},
          {'title': 'Nii', 'images': 'assets/images/2.jpg'},
          {'title': 'Sann', 'images': 'assets/images/3.jpg'},
        ];
        emit(CarouselLoaded(items));
      },
    );
  }
}
