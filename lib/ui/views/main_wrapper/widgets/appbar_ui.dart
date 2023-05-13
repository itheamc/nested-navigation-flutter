import 'package:flutter/material.dart';
import 'package:multi_nested_navigation/utils/extension_functions.dart';

class AppbarUi extends StatelessWidget implements PreferredSizeWidget {
  const AppbarUi({
    super.key,
    this.show = true,
    this.backgroundColor,
    this.onDropdownClick,
    this.onInfoClick,
    this.onProfileIconClick,
  });

  final bool show;
  final Color? backgroundColor;
  final VoidCallback? onDropdownClick;
  final VoidCallback? onInfoClick;
  final VoidCallback? onProfileIconClick;

  @override
  Widget build(BuildContext context) {
    return AnimatedSize(
      duration: const Duration(milliseconds: 50),
      child: Material(
        color: backgroundColor ?? context.theme.appBarTheme.backgroundColor,
        elevation: show ? 1 : 0,
        shadowColor: context.theme.dividerColor.withOpacity(0.15),
        child: Container(
          height: preferredSize.height,
          padding: const EdgeInsets.symmetric(horizontal: 16.0),
          child: Column(
            children: [
              const SizedBox(
                height: 25.0,
              ),
              Flexible(
                child: Row(
                  children: [
                    Expanded(
                      child: GestureDetector(
                        onTap: onDropdownClick,
                        child: Row(
                          children: [
                            Container(
                              width: 40.0,
                              height: 40.0,
                              decoration: BoxDecoration(
                                color: Colors.green,
                                border: Border.all(
                                    color: context.theme.dividerColor,
                                    width: 1.0),
                                shape: BoxShape.circle,
                              ),
                            ),
                            const SizedBox(
                              width: 12.0,
                            ),
                            Expanded(
                              child: Text(
                                "Construction Demolition",
                                style: context.theme.textTheme.titleLarge,
                                maxLines: 1,
                                overflow: TextOverflow.ellipsis,
                              ),
                            ),
                            Icon(
                              Icons.keyboard_arrow_down_outlined,
                              size: show ? 24.0 : 0,
                            )
                          ],
                        ),
                      ),
                    ),
                    IconButton(
                      onPressed: onInfoClick,
                      icon: Icon(
                        Icons.info_outline,
                        size: show ? 24.0 : 0,
                      ),
                    ),
                    InkWell(
                      borderRadius: BorderRadius.circular(40.0),
                      onTap: onProfileIconClick,
                      child: Ink(
                        width: 40.0,
                        height: 40.0,
                        decoration: const BoxDecoration(
                          color: Colors.green,
                          shape: BoxShape.circle,
                        ),
                        child: ClipRRect(
                          borderRadius: BorderRadius.circular(40.0),
                          child: Image.network(
                              "https://unsplash.com/photos/iEEBWgY_6lA/download?ixid=M3wxMjA3fDB8MXxhbGx8fHx8fHx8fHwxNjgzODAwOTk2fA&force=true&w=640"),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  @override
  Size get preferredSize => Size(double.maxFinite, show ? 80 : 25);
}
