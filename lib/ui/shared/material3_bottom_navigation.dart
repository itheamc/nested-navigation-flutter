import 'package:flutter/material.dart';
import 'package:multi_nested_navigation/utils/extension_functions.dart';

class Material3BottomNavigation extends StatefulWidget {
  final List<Material3NavigationItem> items;
  final void Function(int)? onTap;
  final int currentIndex;
  final double? elevation;
  final Color? backgroundColor;
  final double iconSize = 20.0;
  final Color? iconColor;
  final Color? activeIconColor;

  const Material3BottomNavigation({
    Key? key,
    required this.items,
    this.currentIndex = 0,
    this.onTap,
    this.elevation,
    this.backgroundColor,
    this.iconColor,
    this.activeIconColor,
  }) : super(key: key);

  @override
  State<Material3BottomNavigation> createState() =>
      _Material3BottomNavigationState();
}

class _Material3BottomNavigationState extends State<Material3BottomNavigation> {
  @override
  Widget build(BuildContext context) {
    return Material(
      color: widget.backgroundColor,
      elevation: widget.elevation ?? 5.0,
      shadowColor: context.theme.dividerColor.withOpacity(0.35),
      child: SizedBox(
        height: 80.0,
        width: double.maxFinite,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            ...List.generate(widget.items.length, (i) {
              final item = widget.items[i];

              final selected = widget.currentIndex == i;

              return Expanded(
                child: InkWell(
                  onTap: () => widget.onTap?.call(i),
                  highlightColor: Colors.transparent,
                  hoverColor: Colors.transparent,
                  focusColor: Colors.transparent,
                  splashColor: Colors.transparent,
                  child: Ink(
                    padding: const EdgeInsets.all(8.0),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        AnimatedContainer(
                          duration: const Duration(
                            milliseconds: 375,
                          ),
                          padding: const EdgeInsets.symmetric(
                            vertical: 4.0,
                          ),
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(50.0),
                            color: selected
                                ? Colors.orange.withOpacity(0.1)
                                : widget.backgroundColor,
                          ),
                          constraints: const BoxConstraints(
                            maxWidth: 55,
                          ),
                          child: Center(
                            child: Icon(
                              selected
                                  ? item.activeIcon ?? item.icon
                                  : item.icon,
                              size: widget.iconSize,
                              color: selected
                                  ? widget.activeIconColor
                                  : widget.iconColor,
                            ),
                          ),
                        ),
                        const SizedBox(
                          height: 4.0,
                        ),
                        Text(
                          item.label,
                          style: context.theme.textTheme.labelSmall?.copyWith(
                            fontWeight:
                                selected ? FontWeight.w700 : FontWeight.normal,
                          ),
                        )
                      ],
                    ),
                  ),
                ),
              );
            }),
          ],
        ),
      ),
    );
  }
}

class Material3NavigationItem {
  final Key? key;
  final String label;
  final IconData icon;
  final IconData? activeIcon;

  Material3NavigationItem({
    this.key,
    required this.label,
    required this.icon,
    this.activeIcon,
  });
}
