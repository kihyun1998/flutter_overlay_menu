# Flutter Overlay Menu - 최종 기획서 v3.0

> **핵심**: 함수 기반 범용 오버레이 메뉴 시스템  
> **영감**: `showDialog` + `flutter_dropdown_button`의 스마트 포지셔닝  
> **상태**: ✅ 모든 결정 완료 - 구현 준비됨

---

## 📋 목차

1. [패키지 개요](#패키지-개요)
2. [핵심 아키텍처](#핵심-아키텍처)
3. [Phase 1 구현 범위](#phase-1-구현-범위)
4. [API 명세](#api-명세)
5. [구현 상세](#구현-상세)
6. [예제 코드](#예제-코드)

---

## 패키지 개요

### 🎯 핵심 가치

**Flutter Overlay Menu**는 함수 기반의 범용 오버레이 메뉴 시스템입니다.

```dart
// 한 줄로 완성!
showOverlayMenu(
  context: context,
  anchorKey: buttonKey,
  builder: (context) => OverlayMenu(items: [...]),
)
```

### ✨ 주요 특징

- 📱 **Flutter 표준 패턴**: `showDialog()`와 동일한 함수 기반 API
- 🎨 **풍부한 애니메이션**: 커스터마이징 가능한 애니메이션
- 📍 **스마트 포지셔닝**: 화면 공간 자동 감지 및 최적 배치
- 🎯 **완전한 커스터마이징**: 크기, 스타일, 애니메이션 모두 제어 가능
- 🔧 **간단한 사용**: GlobalKey만 제공하면 끝

---

## 핵심 아키텍처

### 📐 구조

```
사용자 코드
  ↓
showOverlayMenu() 함수 (로직)
  - 위치 계산 (MenuPositioner)
  - OverlayEntry 생성
  - 애니메이션 설정
  - 외부 클릭 감지
  ↓
OverlayMenu 위젯 (UI)
  - 메뉴 렌더링
  - 스크롤 처리
  - 스타일링
  ↓
OverlayMenuItem 위젯 (UI)
  - 아이템 렌더링
  - 상호작용 처리
```

### 🔑 핵심 원칙

1. **함수는 로직, 위젯은 UI**
2. **Flutter 표준 패턴 준수**
3. **유연성 최우선**

---

## Phase 1 구현 범위

### ✅ 포함 사항

#### 1. 핵심 함수
- `showOverlayMenu()` - 앵커 기준 메뉴 표시
  - GlobalKey로 위치 자동 계산
  - 위/아래 자동 선택
  - 좌/중앙/우 정렬 지원
  - 커스터마이징 가능한 애니메이션
  - Future<T?> 반환

#### 2. 필수 위젯
- `OverlayMenu` - 메뉴 컨테이너
- `OverlayMenuItem` - 메뉴 아이템
- `OverlayMenuDivider` - 구분선

#### 3. 포지셔닝
- **방향**: auto (위/아래 자동), below, above
- **정렬**: start, center, end
- **화면 경계 체크**: 자동 조정

#### 4. 애니메이션
- **기본**: Scale + Fade
- **커스터마이징**: Duration, Curve 조정 가능
- **프리셋**: 추후 추가 (Phase 2)

#### 5. 스타일
- `OverlayMenuStyle` - 메뉴 스타일
  - 크기: width, minWidth, maxWidth, maxHeight
  - 외형: backgroundColor, elevation, shape
  - 패딩: padding
  - 스크롤바: scrollbarTheme (Theme 지원 예정)

### ❌ 제외 사항 (나중에)

- `showOverlayMenuAt()` - 절대 위치 (Phase 2)
- leftOf, rightOf 포지셔닝 (Phase 2)
- 다양한 애니메이션 타입 (Phase 2)
- 편의 위젯 (OverlayMenuButton 등) (Phase 3)
- 키보드 네비게이션 (Phase 4)
- 서브메뉴 (Phase 5+)

---

## API 명세

### 📌 핵심 함수

#### `showOverlayMenu<T>()`

```dart
/// 앵커 위젯 기준으로 오버레이 메뉴를 표시합니다.
/// 
/// [anchorKey]로 지정된 위젯의 위치를 기준으로 메뉴를 배치합니다.
/// 화면 공간에 따라 자동으로 위/아래를 선택합니다.
/// 
/// Returns: 선택된 값 또는 null (취소/외부 클릭)
Future<T?> showOverlayMenu<T>({
  required BuildContext context,
  required GlobalKey anchorKey,
  required WidgetBuilder builder,
  
  // 포지셔닝
  PositionPreference positionPreference = PositionPreference.auto,
  MenuAlignment alignment = MenuAlignment.start,
  Offset offset = Offset.zero,
  double buttonGap = 4.0,
  double screenMargin = 8.0,
  
  // 애니메이션
  Duration transitionDuration = const Duration(milliseconds: 200),
  Curve transitionCurve = Curves.easeOutCubic,
  
  // 스타일
  OverlayMenuStyle? style,
  
  // 동작
  bool barrierDismissible = true,
  Color barrierColor = Colors.transparent,
  
  // 콜백
  VoidCallback? onOpen,
  VoidCallback? onClose,
})
```

**사용 예제**:
```dart
final key = GlobalKey();

ElevatedButton(
  key: key,
  onPressed: () async {
    final result = await showOverlayMenu<String>(
      context: context,
      anchorKey: key,
      builder: (context) => OverlayMenu(
        items: [
          OverlayMenuItem(value: 'edit', child: Text('Edit')),
          OverlayMenuItem(value: 'delete', child: Text('Delete')),
        ],
      ),
    );
    
    if (result == 'edit') handleEdit();
  },
  child: Text('Options'),
)
```

### 📦 위젯

#### `OverlayMenu`

```dart
class OverlayMenu<T> extends StatelessWidget {
  const OverlayMenu({
    Key? key,
    required this.items,
    this.onItemSelected,
    this.style,
  }) : super(key: key);

  final List<OverlayMenuEntry> items;
  final void Function(T value)? onItemSelected;
  final OverlayMenuStyle? style;
}
```

#### `OverlayMenuItem`

```dart
class OverlayMenuItem<T> extends OverlayMenuEntry {
  const OverlayMenuItem({
    Key? key,
    this.value,
    required this.child,
    this.leading,
    this.trailing,
    this.onTap,
    this.enabled = true,
  }) : super(key: key);

  final T? value;
  final Widget child;
  final Widget? leading;
  final Widget? trailing;
  final VoidCallback? onTap;
  final bool enabled;
}
```

**동작 규칙**:
- `onTap`이 있으면: onTap 실행 (메뉴는 자동으로 닫히지 않음, 수동 닫기 필요)
- `onTap`이 없으면: value 반환 후 자동으로 메뉴 닫기

#### `OverlayMenuDivider`

```dart
class OverlayMenuDivider extends OverlayMenuEntry {
  const OverlayMenuDivider({
    Key? key,
    this.height = 1.0,
    this.thickness = 1.0,
    this.color,
  }) : super(key: key);

  final double height;
  final double thickness;
  final Color? color;
}
```

### 🎨 스타일 클래스

#### `OverlayMenuStyle`

```dart
class OverlayMenuStyle {
  const OverlayMenuStyle({
    // 크기
    this.width,
    this.minWidth,
    this.maxWidth,
    this.maxHeight = 300.0,
    
    // 외형
    this.backgroundColor,
    this.elevation = 8.0,
    this.shadowColor,
    this.shape,  // ShapeBorder (borderRadius 포함)
    
    // 패딩
    this.padding,
    
    // 스크롤바 (Phase 2+)
    this.scrollbarTheme,
  });

  final double? width;
  final double? minWidth;
  final double? maxWidth;
  final double? maxHeight;
  
  final Color? backgroundColor;
  final double elevation;
  final Color? shadowColor;
  final ShapeBorder? shape;
  
  final EdgeInsetsGeometry? padding;
  final ScrollbarThemeData? scrollbarTheme;
}
```

**크기 계산 로직**:
```dart
// 1. width 지정되었으면 width 사용
// 2. 없으면 앵커 위젯 너비 사용
// 3. minWidth/maxWidth로 제약 적용

double menuWidth;
if (style?.width != null) {
  menuWidth = style!.width!;
} else {
  menuWidth = anchorWidth;
}

if (style?.minWidth != null && menuWidth < style!.minWidth!) {
  menuWidth = style.minWidth!;
}
if (style?.maxWidth != null && menuWidth > style!.maxWidth!) {
  menuWidth = style.maxWidth!;
}
```

### 🎭 Enums

```dart
enum PositionPreference {
  auto,   // 공간에 따라 위/아래 자동 선택
  below,  // 항상 아래
  above,  // 항상 위
}

enum MenuAlignment {
  start,   // 시작점 정렬 (왼쪽)
  center,  // 중앙 정렬
  end,     // 끝점 정렬 (오른쪽)
}
```

---

## 구현 상세

### 🔧 1. MenuPositioner - 위치 계산

**참고**: `flutter_dropdown_button`의 방식 채택

```dart
class MenuPositioner {
  static MenuPosition calculatePosition({
    required BuildContext context,
    required RenderBox anchorBox,
    required Size menuSize,
    required PositionPreference preference,
    required MenuAlignment alignment,
    required double buttonGap,
    required double screenMargin,
    Offset additionalOffset = Offset.zero,
  }) {
    final screenSize = MediaQuery.of(context).size;
    final anchorOffset = anchorBox.localToGlobal(Offset.zero);
    final anchorSize = anchorBox.size;
    
    // 1. 사용 가능한 공간 계산
    final spaceAbove = anchorOffset.dy - screenMargin;
    final spaceBelow = screenSize.height - 
        (anchorOffset.dy + anchorSize.height) - screenMargin;
    
    // 2. 방향 결정
    final direction = _determineDirection(
      preference: preference,
      spaceAbove: spaceAbove,
      spaceBelow: spaceBelow,
      menuHeight: menuSize.height,
    );
    
    // 3. 수평 위치 계산 (정렬 적용)
    final left = _calculateHorizontalPosition(
      anchorOffset.dx,
      anchorSize.width,
      menuSize.width,
      alignment,
      screenSize.width,
      screenMargin,
    );
    
    // 4. 수직 위치 계산
    final top = direction == MenuDirection.below
        ? anchorOffset.dy + anchorSize.height + buttonGap
        : anchorOffset.dy - menuSize.height - buttonGap;
    
    // 5. 추가 오프셋 적용
    final finalPosition = Offset(left, top) + additionalOffset;
    
    return MenuPosition(
      offset: finalPosition,
      direction: direction,
      transformOrigin: direction == MenuDirection.below 
          ? Alignment.topCenter 
          : Alignment.bottomCenter,
    );
  }
  
  static MenuDirection _determineDirection({
    required PositionPreference preference,
    required double spaceAbove,
    required double spaceBelow,
    required double menuHeight,
  }) {
    switch (preference) {
      case PositionPreference.below:
        return MenuDirection.below;
      case PositionPreference.above:
        return MenuDirection.above;
      case PositionPreference.auto:
        // 충분한 공간이 있는 쪽 선택
        if (spaceBelow >= menuHeight) {
          return MenuDirection.below;
        } else if (spaceAbove >= menuHeight) {
          return MenuDirection.above;
        } else {
          // 둘 다 부족하면 더 넓은 쪽
          return spaceBelow > spaceAbove 
              ? MenuDirection.below 
              : MenuDirection.above;
        }
    }
  }
  
  static double _calculateHorizontalPosition(
    double anchorX,
    double anchorWidth,
    double menuWidth,
    MenuAlignment alignment,
    double screenWidth,
    double screenMargin,
  ) {
    // 정렬 적용
    double left;
    switch (alignment) {
      case MenuAlignment.start:
        left = anchorX;
        break;
      case MenuAlignment.center:
        left = anchorX + (anchorWidth - menuWidth) / 2;
        break;
      case MenuAlignment.end:
        left = anchorX + anchorWidth - menuWidth;
        break;
    }
    
    // 화면 경계 체크 및 조정
    if (left < screenMargin) {
      left = screenMargin;
    } else if (left + menuWidth > screenWidth - screenMargin) {
      left = screenWidth - screenMargin - menuWidth;
    }
    
    return left;
  }
}

class MenuPosition {
  const MenuPosition({
    required this.offset,
    required this.direction,
    required this.transformOrigin,
  });
  
  final Offset offset;
  final MenuDirection direction;
  final Alignment transformOrigin;
}

enum MenuDirection { above, below }
```

### 🎬 2. 애니메이션

**Phase 1**: Scale + Fade만 구현

```dart
class _AnimatedOverlayMenu extends StatefulWidget {
  const _AnimatedOverlayMenu({
    required this.child,
    required this.transformOrigin,
    required this.duration,
    required this.curve,
    required this.onAnimationComplete,
  });

  final Widget child;
  final Alignment transformOrigin;
  final Duration duration;
  final Curve curve;
  final VoidCallback onAnimationComplete;

  @override
  State<_AnimatedOverlayMenu> createState() => _AnimatedOverlayMenuState();
}

class _AnimatedOverlayMenuState extends State<_AnimatedOverlayMenu>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _scaleAnimation;
  late Animation<double> _fadeAnimation;

  @override
  void initState() {
    super.initState();
    
    _controller = AnimationController(
      duration: widget.duration,
      vsync: this,
    );

    final curvedAnimation = CurvedAnimation(
      parent: _controller,
      curve: widget.curve,
    );

    _scaleAnimation = Tween<double>(
      begin: 0.8,
      end: 1.0,
    ).animate(curvedAnimation);

    _fadeAnimation = Tween<double>(
      begin: 0.0,
      end: 1.0,
    ).animate(curvedAnimation);

    _controller.forward().then((_) {
      widget.onAnimationComplete();
    });
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  Future<void> close() async {
    await _controller.reverse();
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: _controller,
      child: widget.child,
      builder: (context, child) {
        return Transform.scale(
          scale: _scaleAnimation.value,
          alignment: widget.transformOrigin,
          child: Opacity(
            opacity: _fadeAnimation.value,
            child: child,
          ),
        );
      },
    );
  }
}
```

### 📏 3. 메뉴 크기 측정

**`flutter_dropdown_button` 방식 채택**: 예상 크기 계산

```dart
class MenuSizeCalculator {
  /// 메뉴의 예상 크기를 계산합니다.
  static Size estimateSize({
    required List<OverlayMenuEntry> items,
    required double anchorWidth,
    required OverlayMenuStyle? style,
  }) {
    // 너비 계산
    double width;
    if (style?.width != null) {
      width = style!.width!;
    } else {
      width = anchorWidth;
    }
    
    // min/max 제약 적용
    if (style?.minWidth != null && width < style!.minWidth!) {
      width = style.minWidth!;
    }
    if (style?.maxWidth != null && width > style!.maxWidth!) {
      width = style.maxWidth!;
    }
    
    // 높이 계산 (아이템 개수 × 아이템 높이)
    const double itemHeight = 48.0;  // 기본 아이템 높이
    const double dividerHeight = 1.0;
    
    double totalHeight = 0.0;
    for (final item in items) {
      if (item is OverlayMenuItem) {
        totalHeight += itemHeight;
      } else if (item is OverlayMenuDivider) {
        totalHeight += item.height;
      }
    }
    
    // 패딩 추가
    final padding = style?.padding;
    if (padding != null) {
      totalHeight += padding.vertical;
    }
    
    // maxHeight 제약 적용
    final maxHeight = style?.maxHeight ?? 300.0;
    if (totalHeight > maxHeight) {
      totalHeight = maxHeight;
    }
    
    return Size(width, totalHeight);
  }
}
```

### 🔄 4. showOverlayMenu() 구현

```dart
Future<T?> showOverlayMenu<T>({
  required BuildContext context,
  required GlobalKey anchorKey,
  required WidgetBuilder builder,
  
  PositionPreference positionPreference = PositionPreference.auto,
  MenuAlignment alignment = MenuAlignment.start,
  Offset offset = Offset.zero,
  double buttonGap = 4.0,
  double screenMargin = 8.0,
  
  Duration transitionDuration = const Duration(milliseconds: 200),
  Curve transitionCurve = Curves.easeOutCubic,
  
  OverlayMenuStyle? style,
  
  bool barrierDismissible = true,
  Color barrierColor = Colors.transparent,
  
  VoidCallback? onOpen,
  VoidCallback? onClose,
}) {
  // 1. RenderBox 가져오기
  final renderBox = anchorKey.currentContext?.findRenderObject() as RenderBox?;
  if (renderBox == null) {
    throw FlutterError(
      'anchorKey must be attached to a widget in the tree.\n'
      'Make sure the widget with anchorKey has been built before calling showOverlayMenu.',
    );
  }
  
  // 2. Completer로 반환값 관리
  final completer = Completer<T?>();
  
  // 3. OverlayEntry 생성
  late final OverlayEntry overlayEntry;
  late final GlobalKey<_AnimatedOverlayMenuState> animationKey;
  
  void closeMenu([T? value]) async {
    if (!completer.isCompleted) {
      // 애니메이션 reverse
      await animationKey.currentState?.close();
      
      // OverlayEntry 제거
      overlayEntry.remove();
      
      // 콜백
      onClose?.call();
      
      // 값 반환
      completer.complete(value);
    }
  }
  
  animationKey = GlobalKey<_AnimatedOverlayMenuState>();
  
  overlayEntry = OverlayEntry(
    builder: (context) {
      // 메뉴 위젯 빌드
      final menuWidget = builder(context);
      
      // 메뉴 크기 예상 (menuWidget이 OverlayMenu인 경우만)
      Size menuSize;
      if (menuWidget is OverlayMenu) {
        menuSize = MenuSizeCalculator.estimateSize(
          items: menuWidget.items,
          anchorWidth: renderBox.size.width,
          style: style ?? menuWidget.style,
        );
      } else {
        // 커스텀 위젯이면 기본 크기 사용
        menuSize = Size(
          style?.width ?? renderBox.size.width,
          style?.maxHeight ?? 300.0,
        );
      }
      
      // 위치 계산
      final position = MenuPositioner.calculatePosition(
        context: context,
        anchorBox: renderBox,
        menuSize: menuSize,
        preference: positionPreference,
        alignment: alignment,
        buttonGap: buttonGap,
        screenMargin: screenMargin,
        additionalOffset: offset,
      );
      
      return GestureDetector(
        onTap: barrierDismissible ? () => closeMenu() : null,
        behavior: HitTestBehavior.translucent,
        child: Container(
          color: barrierColor,
          child: Stack(
            children: [
              Positioned(
                left: position.offset.dx,
                top: position.offset.dy,
                child: GestureDetector(
                  onTap: () {}, // 메뉴 내부 클릭 무시
                  child: _AnimatedOverlayMenu(
                    key: animationKey,
                    transformOrigin: position.transformOrigin,
                    duration: transitionDuration,
                    curve: transitionCurve,
                    onAnimationComplete: () {
                      onOpen?.call();
                    },
                    child: Material(
                      color: Colors.transparent,
                      elevation: style?.elevation ?? 8.0,
                      shadowColor: style?.shadowColor,
                      shape: style?.shape ?? RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(8.0),
                      ),
                      child: menuWidget,
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      );
    },
  );
  
  // 4. Overlay에 삽입
  Overlay.of(context).insert(overlayEntry);
  
  // 5. Future 반환
  return completer.future;
}
```

---

## 예제 코드

### 예제 1: 기본 드롭다운

```dart
class BasicDropdownExample extends StatefulWidget {
  @override
  State<BasicDropdownExample> createState() => _BasicDropdownExampleState();
}

class _BasicDropdownExampleState extends State<BasicDropdownExample> {
  final _buttonKey = GlobalKey();
  String? _selected;

  @override
  Widget build(BuildContext context) {
    return TextButton(
      key: _buttonKey,
      onPressed: () async {
        final result = await showOverlayMenu<String>(
          context: context,
          anchorKey: _buttonKey,
          builder: (context) => OverlayMenu(
            items: [
              OverlayMenuItem(value: 'apple', child: Text('Apple')),
              OverlayMenuItem(value: 'banana', child: Text('Banana')),
              OverlayMenuItem(value: 'orange', child: Text('Orange')),
            ],
          ),
        );
        
        if (result != null) {
          setState(() => _selected = result);
        }
      },
      child: Text(_selected ?? 'Select a fruit'),
    );
  }
}
```

### 예제 2: 아이콘 포함 메뉴

```dart
final key = GlobalKey();

IconButton(
  key: key,
  icon: Icon(Icons.more_vert),
  onPressed: () {
    showOverlayMenu(
      context: context,
      anchorKey: key,
      alignment: MenuAlignment.end,  // 오른쪽 정렬
      builder: (context) => OverlayMenu(
        items: [
          OverlayMenuItem(
            leading: Icon(Icons.edit, size: 20),
            child: Text('Edit'),
            onTap: () {
              handleEdit();
              Navigator.pop(context);
            },
          ),
          OverlayMenuItem(
            leading: Icon(Icons.share, size: 20),
            child: Text('Share'),
            onTap: () {
              handleShare();
              Navigator.pop(context);
            },
          ),
          OverlayMenuDivider(),
          OverlayMenuItem(
            leading: Icon(Icons.delete, size: 20, color: Colors.red),
            child: Text('Delete', style: TextStyle(color: Colors.red)),
            onTap: () {
              handleDelete();
              Navigator.pop(context);
            },
          ),
        ],
      ),
    );
  },
)
```

### 예제 3: 커스텀 스타일

```dart
showOverlayMenu(
  context: context,
  anchorKey: buttonKey,
  transitionDuration: Duration(milliseconds: 300),
  transitionCurve: Curves.elasticOut,
  builder: (context) => OverlayMenu(
    style: OverlayMenuStyle(
      minWidth: 200,
      maxWidth: 300,
      backgroundColor: Colors.grey.shade900,
      elevation: 12,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(16),
      ),
      padding: EdgeInsets.symmetric(vertical: 8),
    ),
    items: [
      OverlayMenuItem(
        child: Text('Item 1', style: TextStyle(color: Colors.white)),
      ),
      OverlayMenuItem(
        child: Text('Item 2', style: TextStyle(color: Colors.white)),
      ),
    ],
  ),
)
```

### 예제 4: 항상 위에 표시

```dart
showOverlayMenu(
  context: context,
  anchorKey: buttonKey,
  positionPreference: PositionPreference.above,  // 항상 위
  alignment: MenuAlignment.center,  // 중앙 정렬
  builder: (context) => OverlayMenu(
    items: [...],
  ),
)
```

---

## 📁 파일 구조

```
lib/
├── flutter_overlay_menu.dart           # 메인 export
└── src/
    ├── functions/
    │   └── show_overlay_menu.dart      # showOverlayMenu() 함수
    ├── widgets/
    │   ├── overlay_menu.dart           # OverlayMenu 위젯
    │   ├── overlay_menu_item.dart      # OverlayMenuItem 위젯
    │   ├── overlay_menu_divider.dart   # OverlayMenuDivider 위젯
    │   └── overlay_menu_entry.dart     # 추상 베이스 클래스
    ├── core/
    │   ├── menu_positioner.dart        # 위치 계산 로직
    │   ├── menu_size_calculator.dart   # 크기 계산 로직
    │   └── animated_overlay_menu.dart  # 애니메이션 위젯
    └── models/
        ├── menu_style.dart             # OverlayMenuStyle
        ├── menu_position.dart          # MenuPosition
        └── enums.dart                  # Enums
```

---

## ✅ 구현 체크리스트

### Day 1: 핵심 로직
- [ ] 파일 구조 생성
- [ ] `MenuPositioner` 구현
  - [ ] 위/아래 자동 선택
  - [ ] 좌/중앙/우 정렬
  - [ ] 화면 경계 체크
- [ ] `MenuSizeCalculator` 구현
  - [ ] 아이템 개수로 크기 예상
  - [ ] min/max 제약 적용
- [ ] `_AnimatedOverlayMenu` 구현
  - [ ] Scale + Fade 애니메이션
  - [ ] Duration, Curve 커스터마이징

### Day 2: 함수 및 위젯
- [ ] `showOverlayMenu()` 함수 구현
  - [ ] OverlayEntry 생성 및 삽입
  - [ ] 외부 클릭 감지
  - [ ] Future 반환
- [ ] `OverlayMenu` 위젯 구현
  - [ ] 아이템 리스트 렌더링
  - [ ] 스크롤 처리
  - [ ] 기본 스타일 적용
- [ ] `OverlayMenuItem` 위젯 구현
  - [ ] onTap/value 모두 지원
  - [ ] enabled 상태
  - [ ] leading/trailing
- [ ] `OverlayMenuDivider` 위젯 구현

### Day 3: 테스트 및 문서
- [ ] 예제 앱 작성
  - [ ] 기본 드롭다운
  - [ ] 아이콘 메뉴
  - [ ] 커스텀 스타일
  - [ ] 다양한 정렬
- [ ] README.md 작성
- [ ] API 문서 (dartdoc)
- [ ] CHANGELOG.md

---

## 🎯 완료 기준

Phase 1이 성공적으로 완료되려면:

1. ✅ 기본 예제가 정상 작동
2. ✅ 위/아래 자동 포지셔닝 정확함
3. ✅ 좌/중앙/우 정렬 정확함
4. ✅ 애니메이션이 부드러움
5. ✅ 외부 클릭으로 닫힘
6. ✅ onTap과 value 모두 작동
7. ✅ 커스텀 스타일 적용됨
8. ✅ 스크롤이 필요할 때 작동함
9. ✅ README에 명확한 사용법

---

**작성일**: 2025-12-04  
**버전**: 3.0.0 (최종)  
**상태**: ✅ **모든 결정 완료 - 구현 시작 가능!**
