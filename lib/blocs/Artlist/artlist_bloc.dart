import 'package:arty_app/blocs/Artlist/artlist_event.dart';
import 'package:arty_app/blocs/Artlist/artlist_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ArtlistBloc extends Bloc<ArtlistEvent, ArtlistState> {
  ArtlistBloc() : super(ArtlistState([])) {
    on<AddToArtlist>(
      (event, emit) {
        final updatedArtlist = state.items;
        updatedArtlist.add(event.item);
        emit(ArtlistState(updatedArtlist));
      },
    );

    on<RemoveFromArtlist>(
      (event, emit) {
        final updatedArtlist = state.items;
        updatedArtlist.remove(event.item);
        emit(ArtlistState(updatedArtlist));
      },
    );
  }
}
