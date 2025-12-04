# Flutter Overlay Menu - Task List

> **목표**: Phase 1 MVP 완성  
> **예상 시간**: 2-3일 (16-22시간)  
> **진행 방식**: 체크박스를 체크하며 진행

---

## 📋 전체 Task 개요

```
[  ] Day 1: 핵심 로직 및 모델 (6-8시간)
[  ] Day 2: 함수 및 위젯 구현 (6-8시간)
[  ] Day 3: 예제, 테스트, 문서화 (4-6시간)
```

---

## Day 1: 핵심 로직 및 모델

### Task 1.1: 프로젝트 초기 설정 (30분)

- [ ] `pubspec.yaml` 업데이트
  ```yaml
  name: flutter_overlay_menu
  description: A highly customizable overlay menu package
  version: 0.1.0
  
  environment:
    sdk: '>=3.0.0 <4.0.0'
  
  dependencies:
    flutter:
      sdk: flutter
  ```

- [ ] 파일 구조 생성
  ```
  lib/
  ├── flutter_overlay_menu.dart
  └── src/
      ├── functions/
      ├── widgets/
      ├── core/
      └── models/
  ```

- [ ] `.gitignore` 확인
- [ ] `analysis_options.yaml` 확인

### Task 1.2: Enums 및 기본 모델 (1시간)

**파일**: `lib/src/models/enums.dart`

- [ ] `PositionPreference` enum 생성
  ```dart
  enum PositionPreference {
    auto,
    below,
    above,
  }
  ```

- [ ] `MenuAlignment` enum 생성
  ```dart
  enum MenuAlignment {
    start,
    center,
    end,
  }
  ```

- [ ] `MenuDirection` enum 생성
  ```dart
  enum MenuDirection {
    above,
    below,
  }
  ```

**파일**: `lib/src/models/menu_position.dart`

- [ ] `MenuPosition` 클래스 생성
  ```dart
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
  ```

### Task 1.3: OverlayMenuStyle 구현 (1.5시간)

**파일**: `lib/src/models/menu_style.dart`

- [ ] `OverlayMenuStyle` 클래스 생성
- [ ] 모든 필드 정의
  - [ ] width, minWidth, maxWidth
  - [ ] maxHeight (기본값 300)
  - [ ] backgroundColor
  - [ ] elevation (기본값 8)
  - [ ] shadowColor
  - [ ] shape
  - [ ] padding
  - [ ] scrollbarTheme (Phase 2용, 일단 정의만)

- [ ] `copyWith()` 메서드 (선택적)
- [ ] `==` 연산자 오버라이드 (선택적)
- [ ] `hashCode` 오버라이드 (선택적)

### Task 1.4: MenuSizeCalculator 구현 (1.5시간)

**파일**: `lib/src/core/menu_size_calculator.dart`

- [ ] `MenuSizeCalculator` 클래스 생성
- [ ] `estimateSize()` static 메서드 구현
  - [ ] 너비 계산
    - [ ] style.width가 있으면 사용
    - [ ] 없으면 anchorWidth 사용
    - [ ] minWidth/maxWidth 제약 적용
  - [ ] 높이 계산
    - [ ] 아이템 개수 순회
    - [ ] OverlayMenuItem: 48.0
    - [ ] OverlayMenuDivider: divider.height
    - [ ] padding 추가
    - [ ] maxHeight 제약 적용
  - [ ] Size 반환

- [ ] 테스트용 임시 위젯 타입 체크 (나중에 실제 위젯으로 교체)

### Task 1.5: MenuPositioner 구현 (2시간)

**파일**: `lib/src/core/menu_positioner.dart`

- [ ] `MenuPositioner` 클래스 생성

- [ ] `calculatePosition()` static 메서드 구현
  - [ ] 입력 파라미터 정의
  - [ ] 앵커 위치 및 크기 가져오기
  - [ ] 화면 크기 가져오기

- [ ] `_determineDirection()` private 메서드 구현
  - [ ] 사용 가능한 공간 계산 (spaceAbove, spaceBelow)
  - [ ] PositionPreference에 따라 방향 결정
    - [ ] auto: 공간 비교하여 자동 선택
    - [ ] below: 항상 아래
    - [ ] above: 항상 위
  - [ ] MenuDirection 반환

- [ ] `_calculateHorizontalPosition()` private 메서드 구현
  - [ ] MenuAlignment에 따라 left 계산
    - [ ] start: anchorX
    - [ ] center: anchorX + (anchorWidth - menuWidth) / 2
    - [ ] end: anchorX + anchorWidth - menuWidth
  - [ ] 화면 경계 체크
    - [ ] 왼쪽 경계 (< screenMargin)
    - [ ] 오른쪽 경계 (> screenWidth - screenMargin)
  - [ ] 조정된 left 반환

- [ ] 최종 위치 계산
  - [ ] top 위치 (buttonGap 적용)
  - [ ] transformOrigin 설정
  - [ ] MenuPosition 객체 생성 및 반환

### Task 1.6: AnimatedOverlayMenu 구현 (2시간)

**파일**: `lib/src/core/animated_overlay_menu.dart`

- [ ] `_AnimatedOverlayMenu` StatefulWidget 생성
  - [ ] 필수 파라미터 정의
    - [ ] child (Widget)
    - [ ] transformOrigin (Alignment)
    - [ ] duration (Duration)
    - [ ] curve (Curve)
    - [ ] onAnimationComplete (VoidCallback)

- [ ] `_AnimatedOverlayMenuState` 구현
  - [ ] `SingleTickerProviderStateMixin` 추가
  - [ ] AnimationController 필드
  - [ ] Animation<double> scaleAnimation 필드
  - [ ] Animation<double> fadeAnimation 필드

- [ ] `initState()` 구현
  - [ ] AnimationController 생성
  - [ ] CurvedAnimation 생성
  - [ ] scaleAnimation 설정 (0.8 → 1.0)
  - [ ] fadeAnimation 설정 (0.0 → 1.0)
  - [ ] forward() 호출 및 onAnimationComplete 실행

- [ ] `dispose()` 구현
  - [ ] AnimationController dispose

- [ ] `close()` 메서드 구현
  - [ ] reverse() 호출하여 애니메이션 역재생
  - [ ] Future 반환

- [ ] `build()` 구현
  - [ ] AnimatedBuilder 사용
  - [ ] Transform.scale 적용
  - [ ] Opacity 적용
  - [ ] child 렌더링

---

## Day 2: 함수 및 위젯 구현

### Task 2.1: OverlayMenuEntry 추상 클래스 (15분)

**파일**: `lib/src/widgets/overlay_menu_entry.dart`

- [ ] `OverlayMenuEntry` 추상 클래스 생성
  ```dart
  abstract class OverlayMenuEntry extends StatelessWidget {
    const OverlayMenuEntry({Key? key}) : super(key: key);
  }
  ```

### Task 2.2: OverlayMenuDivider 구현 (30분)

**파일**: `lib/src/widgets/overlay_menu_divider.dart`

- [ ] `OverlayMenuDivider` 클래스 생성 (extends OverlayMenuEntry)
- [ ] 필드 정의
  - [ ] height (기본값 1.0)
  - [ ] thickness (기본값 1.0)
  - [ ] color (선택적)
  - [ ] indent (기본값 0.0)
  - [ ] endIndent (기본값 0.0)

- [ ] `build()` 구현
  - [ ] Divider 위젯 사용
  - [ ] Theme.dividerColor를 기본 색상으로

### Task 2.3: OverlayMenuItem 구현 (2시간)

**파일**: `lib/src/widgets/overlay_menu_item.dart`

- [ ] `OverlayMenuItem<T>` 클래스 생성 (extends OverlayMenuEntry)
- [ ] 필드 정의
  - [ ] value (T?, 선택적)
  - [ ] child (Widget, 필수)
  - [ ] leading (Widget?, 선택적)
  - [ ] trailing (Widget?, 선택적)
  - [ ] onTap (VoidCallback?, 선택적)
  - [ ] enabled (bool, 기본값 true)

- [ ] `build()` 구현
  - [ ] InkWell 또는 Material 사용
  - [ ] Container로 높이 48 설정
  - [ ] padding 적용 (horizontal 16)
  - [ ] Row로 구성
    - [ ] leading 있으면 표시 + SizedBox(width: 12)
    - [ ] Expanded로 child
    - [ ] trailing 있으면 SizedBox(width: 12) + 표시

- [ ] 인터랙션 처리
  - [ ] enabled가 false면 onTap null
  - [ ] enabled가 true면
    - [ ] onTap이 있으면: onTap 실행
    - [ ] onTap이 없고 value가 있으면: Navigator.pop(context, value)

- [ ] 스타일링
  - [ ] hover 효과 (InkWell 기본 제공)
  - [ ] disabled 시 opacity 0.5

### Task 2.4: OverlayMenu 구현 (2.5시간)

**파일**: `lib/src/widgets/overlay_menu.dart`

- [ ] `OverlayMenu<T>` 클래스 생성
- [ ] 필드 정의
  - [ ] items (List<OverlayMenuEntry>, 필수)
  - [ ] onItemSelected (Function(T)?, 선택적)
  - [ ] style (OverlayMenuStyle?, 선택적)

- [ ] `_defaultStyle()` private 메서드
  - [ ] Theme 기반 기본 스타일 생성
  - [ ] backgroundColor: Theme.cardColor
  - [ ] shape: RoundedRectangleBorder(radius: 8)

- [ ] `build()` 구현
  - [ ] effectiveStyle 계산 (style ?? _defaultStyle)
  - [ ] ListView.builder 생성
    - [ ] shrinkWrap: true
    - [ ] padding 적용
    - [ ] items 순회
  - [ ] ConstrainedBox로 크기 제약
    - [ ] maxHeight 적용
    - [ ] minWidth/maxWidth 적용 (있으면)
  - [ ] Container로 decoration
    - [ ] backgroundColor
    - [ ] border
    - [ ] borderRadius (shape에서 추출)
  - [ ] ClipRRect로 overflow 처리

- [ ] `_buildMenuItem()` private 메서드
  - [ ] OverlayMenuItem인 경우만 특별 처리
  - [ ] onItemSelected 연결
  - [ ] 그 외는 그대로 반환

### Task 2.5: showOverlayMenu() 함수 구현 (3시간)

**파일**: `lib/src/functions/show_overlay_menu.dart`

- [ ] 함수 시그니처 정의
  - [ ] 제네릭 <T>
  - [ ] 모든 파라미터 정의
  - [ ] Future<T?> 반환

- [ ] 입력 검증
  - [ ] anchorKey.currentContext null 체크
  - [ ] RenderBox 가져오기
  - [ ] null이면 FlutterError 발생

- [ ] Completer 생성
  - [ ] `Completer<T?>()` 생성

- [ ] `closeMenu()` 클로저 정의
  - [ ] animationKey.currentState?.close() 호출
  - [ ] overlayEntry.remove()
  - [ ] onClose 콜백 실행
  - [ ] completer.complete(value) 호출
  - [ ] 중복 호출 방지 (completer.isCompleted 체크)

- [ ] OverlayEntry 생성
  - [ ] GlobalKey<_AnimatedOverlayMenuState> 생성
  - [ ] builder 구현
    - [ ] menuWidget = builder(context)
    - [ ] menuSize 계산 (MenuSizeCalculator 사용)
    - [ ] position 계산 (MenuPositioner 사용)
    - [ ] GestureDetector로 외부 클릭 감지
      - [ ] barrierDismissible 체크
      - [ ] closeMenu() 호출
    - [ ] Container에 barrierColor 적용
    - [ ] Stack 사용
      - [ ] Positioned로 메뉴 배치
      - [ ] GestureDetector로 메뉴 내부 클릭 무시
      - [ ] _AnimatedOverlayMenu로 래핑
      - [ ] Material로 elevation, shadow 적용
      - [ ] menuWidget 렌더링

- [ ] Overlay.of(context).insert(overlayEntry) 호출

- [ ] completer.future 반환

### Task 2.6: 메인 export 파일 작성 (30분)

**파일**: `lib/flutter_overlay_menu.dart`

- [ ] 모든 public API export
  ```dart
  // 함수
  export 'src/functions/show_overlay_menu.dart';
  
  // 위젯
  export 'src/widgets/overlay_menu.dart';
  export 'src/widgets/overlay_menu_item.dart';
  export 'src/widgets/overlay_menu_divider.dart';
  export 'src/widgets/overlay_menu_entry.dart';
  
  // 모델
  export 'src/models/menu_style.dart';
  export 'src/models/enums.dart';
  // menu_position.dart는 내부용이므로 export 안 함
  ```

- [ ] 라이브러리 문서 주석 작성

---

## Day 3: 예제, 테스트, 문서화

### Task 3.1: 예제 앱 작성 (2시간)

**파일**: `example/lib/main.dart`

- [ ] 기본 앱 구조 설정
  - [ ] MaterialApp
  - [ ] HomePage 위젯

- [ ] 예제 1: 기본 드롭다운
  - [ ] GlobalKey 생성
  - [ ] TextButton 생성
  - [ ] showOverlayMenu 호출
  - [ ] 3개 아이템
  - [ ] 선택값 표시

- [ ] 예제 2: 아이콘 메뉴
  - [ ] IconButton(more_vert)
  - [ ] alignment: end
  - [ ] leading 아이콘 포함
  - [ ] Edit, Share, Delete 아이템

- [ ] 예제 3: 커스텀 스타일
  - [ ] 다크 배경
  - [ ] elevation 12
  - [ ] borderRadius 16
  - [ ] 커스텀 Duration, Curve

- [ ] 예제 4: 다양한 정렬
  - [ ] start, center, end 버튼 3개
  - [ ] 각각 다른 정렬로 메뉴 표시

- [ ] 예제 5: 위치 고정
  - [ ] above, auto, below 버튼 3개
  - [ ] 각각 다른 PositionPreference

### Task 3.2: README.md 작성 (1.5시간)

**파일**: `README.md`

- [ ] 제목 및 배지
  - [ ] pub.dev 배지 (준비)
  - [ ] License 배지

- [ ] 간단한 소개
- [ ] Features 섹션 (주요 기능 나열)
- [ ] Installation
  ```yaml
  dependencies:
    flutter_overlay_menu: ^0.1.0
  ```

- [ ] Quick Start
  - [ ] 가장 간단한 예제
  - [ ] 코드 설명

- [ ] Usage 섹션
  - [ ] 기본 사용법
  - [ ] 아이콘 포함
  - [ ] 커스텀 스타일
  - [ ] 다양한 옵션

- [ ] API Reference 링크
- [ ] Example 링크
- [ ] Contributing (간단히)
- [ ] License

### Task 3.3: API 문서 작성 (1시간)

**각 파일에 dartdoc 주석 추가**

- [ ] `show_overlay_menu.dart`
  - [ ] 함수 설명
  - [ ] 각 파라미터 설명
  - [ ] 사용 예제
  - [ ] Returns 설명

- [ ] `OverlayMenu`
  - [ ] 클래스 설명
  - [ ] 필드 설명
  - [ ] 사용 예제

- [ ] `OverlayMenuItem`
  - [ ] 클래스 설명
  - [ ] onTap vs value 동작 설명
  - [ ] 사용 예제

- [ ] `OverlayMenuStyle`
  - [ ] 클래스 설명
  - [ ] 각 필드 설명
  - [ ] 크기 계산 로직 설명

- [ ] Enums
  - [ ] 각 enum 설명
  - [ ] 각 값의 동작 설명

### Task 3.4: 기본 테스트 작성 (1시간)

**파일**: `test/flutter_overlay_menu_test.dart`

- [ ] MenuSizeCalculator 테스트
  - [ ] 너비 계산 테스트
  - [ ] 높이 계산 테스트
  - [ ] min/max 제약 테스트

- [ ] MenuPositioner 테스트
  - [ ] auto 방향 선택 테스트
  - [ ] below/above 강제 테스트
  - [ ] 정렬 계산 테스트
  - [ ] 화면 경계 체크 테스트

- [ ] 위젯 테스트 (간단히)
  - [ ] OverlayMenu 렌더링 확인
  - [ ] OverlayMenuItem 렌더링 확인

### Task 3.5: CHANGELOG.md 작성 (15분)

**파일**: `CHANGELOG.md`

- [ ] 버전 0.1.0 섹션 작성
  - [ ] 출시일
  - [ ] Initial release
  - [ ] 주요 기능 나열
    - [ ] showOverlayMenu() 함수
    - [ ] 스마트 포지셔닝
    - [ ] 커스터마이징 가능한 애니메이션
    - [ ] Material Design 스타일

### Task 3.6: 최종 점검 (30분)

- [ ] 모든 파일 import 확인
- [ ] Lint 에러 확인 및 수정
- [ ] 예제 앱 실행 테스트
  - [ ] 모든 예제 작동 확인
  - [ ] 다양한 화면 크기에서 테스트
- [ ] dartdoc 생성 확인
- [ ] pub.dev 점수 예상 체크
  - [ ] 문서화
  - [ ] 예제
  - [ ] 플랫폼 지원

---

## 선택적 Task (여유 있으면)

### Optional: 추가 스타일 개선

- [ ] OverlayMenuItemStyle 구현 (Phase 2 예정)
- [ ] hover 상태 색상 커스터마이징
- [ ] selected 상태 지원

### Optional: 더 많은 예제

- [ ] Divider 사용 예제
- [ ] onTap vs value 비교 예제
- [ ] 긴 리스트 스크롤 예제

### Optional: 고급 테스트

- [ ] 통합 테스트
- [ ] 애니메이션 테스트
- [ ] 다양한 화면 크기 테스트

---

## 📊 진행 체크

### Day 1
- [x] Task 1.1: 프로젝트 초기 설정
- [x] Task 1.2: Enums 및 기본 모델
- [x] Task 1.3: OverlayMenuStyle
- [x] Task 1.4: MenuSizeCalculator
- [x] Task 1.5: MenuPositioner
- [x] Task 1.6: AnimatedOverlayMenu

**Day 1 완료 기준**: 모든 핵심 로직이 작동하는 것을 간단한 테스트로 확인

### Day 2
- [x] Task 2.1: OverlayMenuEntry
- [x] Task 2.2: OverlayMenuDivider
- [x] Task 2.3: OverlayMenuItem
- [x] Task 2.4: OverlayMenu
- [x] Task 2.5: showOverlayMenu()
- [x] Task 2.6: 메인 export

**Day 2 완료 기준**: 간단한 예제가 작동함

### Day 3
- [x] Task 3.1: 예제 앱
- [x] Task 3.2: README.md
- [ ] Task 3.3: API 문서
- [ ] Task 3.4: 기본 테스트
- [x] Task 3.5: CHANGELOG.md
- [ ] Task 3.6: 최종 점검

**Day 3 완료 기준**: 모든 예제 작동, 문서 완성, pub.dev 배포 준비 완료

---

## 🎯 최종 완료 체크리스트

Phase 1 완료 조건:

- [ ] 모든 Day 1-3 Task 완료
- [ ] 5개 예제 모두 작동
- [ ] 위/아래 포지셔닝 정확
- [ ] 좌/중앙/우 정렬 정확
- [ ] 애니메이션 부드러움
- [ ] 외부 클릭으로 닫힘
- [ ] onTap과 value 모두 작동
- [ ] 스타일 적용 정확
- [ ] 스크롤 작동 (긴 리스트)
- [ ] README 명확함
- [ ] 테스트 통과
- [ ] Lint 에러 없음

---

**작성일**: 2025-12-04  
**상태**: ✅ Task List 준비 완료 - 구현 시작!
