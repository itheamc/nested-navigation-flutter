// import 'package:flutter/material.dart';
// import 'package:go_router/go_router.dart';
// import 'package:multi_nested_navigation/utils/extension_functions.dart';
//
//
// class ABottomBar extends StatefulWidget {
//   final List<AMenuItem> items;
//   final double height;
//   final double elevation;
//   final Color? bgColor;
//   final Gradient? bgGradient;
//   final BorderRadius? borderRadius;
//   final Color? lineColor;
//   final Gradient? lineGradient;
//   final double lineThickness;
//   final Duration? duration;
//   final Curve? curve;
//
//   /// For Items Controlling & Decoration
//   final Color? selectedColor;
//   final Gradient? selectedGradient;
//   final Color? iconColor;
//   final Gradient? iconGradient;
//   final Color? selectedIconColor;
//   final Gradient? selectedIconGradient;
//   final Function(AMenuItem item)? onSelected;
//
//   const ABottomBar({
//     Key? key,
//     required this.items,
//     this.height = 70,
//     this.elevation = 10.0,
//     this.bgColor,
//     this.bgGradient,
//     this.borderRadius,
//     this.selectedColor,
//     this.selectedGradient,
//     this.iconColor,
//     this.iconGradient,
//     this.selectedIconColor,
//     this.selectedIconGradient,
//     this.lineColor,
//     this.lineGradient,
//     this.lineThickness = 1.5,
//     this.duration,
//     this.curve,
//     this.onSelected,
//   }) : super(key: key);
//
//   @override
//   State<ABottomBar> createState() => _ABottomBarState();
// }
//
// class _ABottomBarState extends State<ABottomBar> {
//   /// Calculating each item width
//   double get _itemWidth => (context.width) / widget.items.length;
//
//   void _onSelected(AMenuItem item) {
//     context.go(item.route);
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     final theme = Theme.of(context);
//     navController.itemWidth = _itemWidth;
//
//     return Material(
//       color: widget.bgColor,
//       elevation: widget.elevation,
//       shadowColor: theme.dividerColor.withOpacity(0.25),
//       borderRadius: widget.borderRadius,
//       child: AnimatedContainer(
//         height: widget.height,
//         duration: const Duration(milliseconds: 275),
//         decoration: BoxDecoration(
//             gradient: widget.bgGradient, borderRadius: widget.borderRadius),
//         child: Stack(
//           children: [
//             Row(
//               children: [
//                 ...widget.items
//                     .map(
//                       (e) => Expanded(
//                     child: ABottomBarItem(
//                       item: e,
//                       selected: e.id == navController.id,
//                       selectedColor: widget.selectedColor,
//                       selectedGradient: widget.selectedGradient,
//                       iconColor: widget.iconColor,
//                       iconGradient: widget.iconGradient,
//                       selectedIconColor: widget.selectedIconColor,
//                       selectedIconGradient: widget.selectedIconGradient,
//                       onSelected: widget.onSelected ?? _onSelected,
//                     ),
//                   ),
//                 )
//                     .toList(),
//               ],
//             ),
//             AnimatedPositioned(
//               top: 0,
//               left: navController.left,
//               duration: widget.duration ?? DashboardTheme.durationSlow * 2,
//               curve: widget.curve ?? Curves.elasticOut,
//               child: Container(
//                 height: widget.lineThickness,
//                 width: _itemWidth,
//                 decoration: BoxDecoration(
//                   color: widget.lineColor ?? theme.colorScheme.primary,
//                   gradient: widget.lineGradient,
//                 ),
//               ),
//             )
//           ],
//         ),
//       ),
//     );
//   }
// }
//
// /// ABottomBar Item
// class ABottomBarItem extends StatelessWidget {
//   final AMenuItem item;
//   final bool selected;
//   final Color? selectedColor;
//   final Gradient? selectedGradient;
//   final Color? iconColor;
//   final Gradient? iconGradient;
//   final Color? selectedIconColor;
//   final Gradient? selectedIconGradient;
//   final Function(AMenuItem item) onSelected;
//   final Function(TapDownDetails)? onTapDown;
//   final Function(TapUpDetails)? onTapUp;
//   final Function()? onTapCancel;
//
//   const ABottomBarItem({
//     Key? key,
//     required this.item,
//     required this.onSelected,
//     this.selected = false,
//     this.selectedColor,
//     this.selectedGradient,
//     this.iconColor,
//     this.iconGradient,
//     this.selectedIconColor,
//     this.selectedIconGradient,
//     this.onTapDown,
//     this.onTapUp,
//     this.onTapCancel,
//   }) : super(key: key);
//
//   @override
//   Widget build(BuildContext context) {
//     final theme = Theme.of(context);
//
//     return InkWell(
//       onTap: () => onSelected(item),
//       onTapDown: onTapDown,
//       onTapUp: onTapUp,
//       onTapCancel: onTapCancel,
//       child: Ink(
//         decoration: BoxDecoration(
//           color: selected && selectedGradient == null
//               ? selectedColor ??
//               (theme.light
//                   ? theme.dividerColor.withOpacity(0.35)
//                   : theme.dividerColor.withOpacity(0.10))
//               : null,
//           gradient: selected ? selectedGradient : null,
//         ),
//         height: double.maxFinite,
//         child: iconGradient != null || selectedIconGradient != null
//             ? GradientMask(
//           colors: selected
//               ? selectedIconGradient?.colors ??
//               [theme.colorScheme.primary, theme.colorScheme.secondary]
//               : iconGradient?.colors,
//           child: Icon(
//             item.icon,
//             size: 20.0,
//           ),
//         )
//             : Icon(
//           item.icon,
//           color: selected ? selectedIconColor : iconColor,
//           size: 20.0,
//         ),
//       ),
//     );
//   }
// }
//
// class AMenuItem {
//   final GlobalKey? key;
//   final int id;
//   final String label;
//   final IconData icon;
//   final IconData? selectedIcon;
//   final String route;
//   final List<Color>? colors;
//
//   AMenuItem({
//     this.key,
//     required this.id,
//     required this.label,
//     required this.icon,
//     this.selectedIcon,
//     required this.route,
//     this.colors,
//   });
// }
