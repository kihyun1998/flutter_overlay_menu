# 최종 결정 사항 ✅

> **상태**: 모든 결정 완료 - 구현 즉시 시작 가능!  
> **날짜**: 2025-12-04

---

## ✅ 확정된 결정 사항

### 1. 애니메이션
- ✅ **커스터마이징 가능**
- ✅ Phase 1: Scale + Fade (기본)
- ✅ Duration, Curve 파라미터로 조정 가능
- ⏳ Phase 2+: 다양한 애니메이션 프리셋 추가

```dart
showOverlayMenu(
  transitionDuration: Duration(milliseconds: 200),  // 커스텀 가능
  transitionCurve: Curves.easeOutCubic,            // 커스텀 가능
  ...
)
```

### 2. 위치 계산
- ✅ **좌/중앙/우 정렬 모두 지원**
- ✅ Phase 1: 위/아래 + 3가지 정렬
- ⏳ Phase 2: 좌/우 포지셔닝 추가

```dart
enum PositionPreference {
  auto,   // 위/아래 자동
  below,  // 항상 아래
  above,  // 항상 위
}

enum MenuAlignment {
  start,   // 좌측 정렬
  center,  // 중앙 정렬
  end,     // 우측 정렬
}
```

### 3. 메뉴 크기
- ✅ **완전 커스터마이징 가능**
- ✅ width, minWidth, maxWidth 모두 제공
- ✅ 기본값: 앵커 위젯 너비
- ✅ flutter_dropdown_button 방식 채택

```dart
OverlayMenuStyle(
  width: 250,        // 고정 너비 (선택)
  minWidth: 200,     // 최소 너비 (선택)
  maxWidth: 400,     // 최대 너비 (선택)
  maxHeight: 300,    // 최대 높이 (기본값)
)

// 크기 계산 로직:
// 1. width 있으면 → width 사용
// 2. 없으면 → 앵커 너비 사용
// 3. minWidth/maxWidth로 제약 적용
```

**높이 계산** (flutter_dropdown_button 방식):
```dart
// 아이템 개수 × 아이템 높이 = 총 높이
totalHeight = items.length × 48.0 (기본 아이템 높이)

// maxHeight 초과시 스크롤
if (totalHeight > maxHeight) {
  메뉴 높이 = maxHeight
  스크롤바 표시
}
```

### 4. 아이템 선택 처리
- ✅ **onTap과 value 둘 다 지원**

```dart
// 옵션 A: onTap 사용 (수동 닫기)
OverlayMenuItem(
  child: Text('Edit'),
  onTap: () {
    handleEdit();
    Navigator.pop(context);  // 수동으로 닫기
  },
)

// 옵션 B: value 사용 (자동 닫기)
OverlayMenuItem(
  value: 'edit',
  child: Text('Edit'),
)
// showOverlayMenu가 'edit' 반환 후 자동 닫기

// 우선순위: onTap이 있으면 onTap 실행, 없으면 value 반환
```

### 5. 외부 클릭 처리
- ✅ **투명 배리어 유지**
- ✅ barrierColor 기본값: `Colors.transparent`
- ✅ 사용자가 원하면 어둡게 가능

```dart
showOverlayMenu(
  barrierDismissible: true,  // 기본값
  barrierColor: Colors.transparent,  // 기본값 (투명)
  // 원하면 어둡게:
  // barrierColor: Colors.black12,
  ...
)
```

### 6. 스크롤바
- ✅ **커스터마이징 가능**
- ✅ Phase 1: 기본 Scrollbar
- ⏳ Phase 2+: ScrollbarTheme 지원

```dart
OverlayMenuStyle(
  scrollbarTheme: ScrollbarThemeData(  // Phase 2+
    thumbColor: MaterialStateProperty.all(Colors.blue),
    thickness: MaterialStateProperty.all(6.0),
  ),
)
```

---

## 🔧 기술적 결정

### 1. 메뉴 크기 측정
- ✅ **flutter_dropdown_button 방식 채택**
- ✅ 예상 크기 계산 방식

```dart
// 아이템 개수로 예상
estimatedHeight = items.length × itemHeight + padding

// 장점: 간단하고 빠름
// 단점: 커스텀 높이 아이템은 부정확할 수 있음
// → Phase 1에서는 이 방식, 나중에 필요하면 개선
```

### 2. AnimationController vsync
- ✅ **내부 StatefulWidget 사용**
- ✅ OverlayEntry 내부에 `_AnimatedOverlayMenu` 생성

```dart
class _AnimatedOverlayMenu extends StatefulWidget {
  // SingleTickerProviderStateMixin 사용
  // vsync 제공
}

// showOverlayMenu() 함수에서:
overlayEntry = OverlayEntry(
  builder: (context) => _AnimatedOverlayMenu(
    child: menuWidget,
    // ...
  ),
);
```

### 3. Focus 관리
- ✅ **Phase 1에서는 제외**
- ⏳ Phase 4에서 키보드 네비게이션과 함께 구현

---

## 📦 패키지 정보

### 메타데이터
```yaml
name: flutter_overlay_menu
description: >
  A highly customizable overlay menu package for Flutter.
  Provides showOverlayMenu() function to display animated menus
  with smart positioning and Material Design styling.
version: 0.1.0
homepage: https://github.com/kihyun1998/flutter_overlay_menu

environment:
  sdk: '>=3.0.0 <4.0.0'
  flutter: '>=3.0.0'

dependencies:
  flutter:
    sdk: flutter

dev_dependencies:
  flutter_test:
    sdk: flutter
  flutter_lints: ^6.0.0
```

### 라이센스
- ✅ **MIT License**

---

## 📋 Phase 1 구현 체크리스트

### 핵심 기능
- [ ] `showOverlayMenu()` 함수
- [ ] `OverlayMenu` 위젯
- [ ] `OverlayMenuItem` 위젯
- [ ] `OverlayMenuDivider` 위젯

### 포지셔닝
- [ ] auto (위/아래 자동 선택)
- [ ] below (항상 아래)
- [ ] above (항상 위)
- [ ] start/center/end 정렬
- [ ] 화면 경계 체크

### 애니메이션
- [ ] Scale (0.8 → 1.0)
- [ ] Fade (0.0 → 1.0)
- [ ] Duration 커스터마이징
- [ ] Curve 커스터마이징

### 스타일
- [ ] width, minWidth, maxWidth
- [ ] maxHeight (기본 300)
- [ ] backgroundColor
- [ ] elevation
- [ ] shape (borderRadius)
- [ ] padding

### 동작
- [ ] 외부 클릭 감지
- [ ] barrierDismissible
- [ ] onTap 실행
- [ ] value 반환
- [ ] Future<T?> 반환

### 크기 계산
- [ ] 아이템 개수 × 높이
- [ ] min/max 제약 적용
- [ ] 스크롤 처리 (maxHeight 초과시)

---

## 📁 파일 구조

```
lib/
├── flutter_overlay_menu.dart
└── src/
    ├── functions/
    │   └── show_overlay_menu.dart
    ├── widgets/
    │   ├── overlay_menu.dart
    │   ├── overlay_menu_item.dart
    │   ├── overlay_menu_divider.dart
    │   └── overlay_menu_entry.dart
    ├── core/
    │   ├── menu_positioner.dart
    │   ├── menu_size_calculator.dart
    │   └── animated_overlay_menu.dart
    └── models/
        ├── menu_style.dart
        ├── menu_position.dart
        └── enums.dart

example/
└── lib/
    └── main.dart  # 예제 앱

test/
└── flutter_overlay_menu_test.dart
```

---

## 📝 예제 시나리오

### 예제 1: 기본 드롭다운
```dart
final key = GlobalKey();

TextButton(
  key: key,
  onPressed: () async {
    final result = await showOverlayMenu<String>(
      context: context,
      anchorKey: key,
      builder: (context) => OverlayMenu(
        items: [
          OverlayMenuItem(value: 'apple', child: Text('Apple')),
          OverlayMenuItem(value: 'banana', child: Text('Banana')),
        ],
      ),
    );
    print('Selected: $result');
  },
  child: Text('Select'),
)
```

### 예제 2: 아이콘 메뉴
```dart
IconButton(
  key: iconKey,
  icon: Icon(Icons.more_vert),
  onPressed: () {
    showOverlayMenu(
      context: context,
      anchorKey: iconKey,
      alignment: MenuAlignment.end,
      builder: (context) => OverlayMenu(
        items: [
          OverlayMenuItem(
            leading: Icon(Icons.edit),
            child: Text('Edit'),
            onTap: () {
              handleEdit();
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
  anchorKey: key,
  transitionDuration: Duration(milliseconds: 300),
  transitionCurve: Curves.elasticOut,
  builder: (context) => OverlayMenu(
    style: OverlayMenuStyle(
      minWidth: 200,
      backgroundColor: Colors.grey.shade900,
      elevation: 12,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(16),
      ),
    ),
    items: [...],
  ),
)
```

### 예제 4: 다양한 정렬
```dart
// 좌측 정렬 (기본)
showOverlayMenu(
  alignment: MenuAlignment.start,
  ...
)

// 중앙 정렬
showOverlayMenu(
  alignment: MenuAlignment.center,
  ...
)

// 우측 정렬
showOverlayMenu(
  alignment: MenuAlignment.end,
  ...
)
```

---

## ⏱️ 예상 일정

### Day 1: 핵심 로직 (6-8시간)
- ✅ 파일 구조 생성
- ✅ MenuPositioner 구현
- ✅ MenuSizeCalculator 구현
- ✅ _AnimatedOverlayMenu 구현

### Day 2: 함수 및 위젯 (6-8시간)
- ✅ showOverlayMenu() 함수
- ✅ OverlayMenu 위젯
- ✅ OverlayMenuItem 위젯
- ✅ OverlayMenuDivider 위젯

### Day 3: 테스트 및 문서 (4-6시간)
- ✅ 예제 앱 4개
- ✅ README.md
- ✅ API 문서 (dartdoc 주석)
- ✅ 기본 테스트

**총 예상**: 2-3일 (16-22시간)

---

## ✅ 완료 기준

Phase 1 완료 조건:

1. ✅ 4가지 예제가 모두 작동
2. ✅ 위/아래 자동 선택 정확
3. ✅ 좌/중앙/우 정렬 정확
4. ✅ 애니메이션 부드러움
5. ✅ 외부 클릭으로 닫힘
6. ✅ onTap 실행됨
7. ✅ value 반환됨
8. ✅ 스타일 적용됨
9. ✅ 스크롤 작동
10. ✅ README에 사용법 명확

---

## 🚀 다음 단계

### 즉시 시작 가능!

1. **pubspec.yaml 설정**
2. **파일 구조 생성**
3. **Day 1 구현 시작**

모든 결정이 완료되었습니다. 바로 구현을 시작하세요! 💪

---

**최종 확인일**: 2025-12-04  
**승인**: ✅ 구현 시작 승인됨
