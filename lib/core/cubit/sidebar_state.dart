part of 'sidebar_cubit.dart';

class SidebarState {
  bool isHovered;

  SidebarState({required this.isHovered});

  SidebarState copyWith({bool? newIsHovered}){
    return SidebarState(isHovered: newIsHovered ?? isHovered);
  }
}