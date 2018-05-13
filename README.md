<p align="center">
    <img src="https://github.com/horitaku46/Assets/blob/master/BlowinSwiper/banner.png" align="center" width="600">
</p>

[![Platform](http://img.shields.io/badge/platform-iOS-blue.svg?style=flat)](https://developer.apple.com/iphone/index.action)
![Swift](https://img.shields.io/badge/Swift-4.0-orange.svg)
[![Cocoapods](https://img.shields.io/badge/Cocoapods-compatible-brightgreen.svg)](https://img.shields.io/badge/Cocoapods-compatible-brightgreen.svg)
[![Carthage compatible](https://img.shields.io/badge/Carthage-Compatible-brightgreen.svg?style=flat)](https://github.com/Carthage/Carthage)
[![License](http://img.shields.io/badge/license-MIT-lightgrey.svg?style=flat)](http://mit-license.org)

## Overview
`BlowinSwiper` makes it possible to swipe back from anywhere on the screen at `UINavigationController`!  
I developed `BlowinSwiper` for handling with various gestures. But only right swipe...

<p align="center">
    <img src="https://github.com/horitaku46/Assets/blob/master/BlowinSwiper/normal.gif" width="300">
    <img src="https://github.com/horitaku46/Assets/blob/master/BlowinSwiper/horizon_scroll.gif" width="300">
</p>

## Features
<img src="https://github.com/horitaku46/Assets/blob/master/BlowinSwiper/twitter_search.png" align="right" width="220">

In this library, I considered what to do the handling of the horizontal scroll. It is like a search screen on Twitter Client App.  
It is the screen on the right.
Sample is thinking about handling with [SwipeMenuViewController](https://github.com/yysskk/SwipeMenuViewController).

- Support iPhone, iPad and iPhone X! 🎉

<br>
<br>
<br>
<br>
<br>
<br>
<br>
<br>

## Translation
Mr. [Gargo](https://github.com/Gargo) translated [this README into Russian](http://gargo.of.by/blowinswiper/)!🙇‍♂️

## Requirements
- Xcode 9.0+
- iOS 10+
- Swift 4.0+

## Installation
### CocoaPods
```ruby
pod 'BlowinSwiper'
```
### Carthage
```ruby
github "horitaku46/BlowinSwiper"
```

## Usage
**See [Example](https://github.com/horitaku46/BlowinSwiper/tree/master/Example), for more details.**

### Normal
**《１》** Please add `UIGestureRecognizerDelegate` to `UINavigationController`. Because to enable edge swipe back.

```swift
import UIKit

final class NavigationController: UINavigationController {
    override func viewDidLoad() {
        super.viewDidLoad()
        interactivePopGestureRecognizer?.delegate = self
    }
}

extension NavigationController: UIGestureRecognizerDelegate {
    func gestureRecognizer(_ gestureRecognizer: UIGestureRecognizer,
                           shouldBeRequiredToFailBy otherGestureRecognizer: UIGestureRecognizer) -> Bool {
        return true
    }
}
```

**《２》** Please set `BlowinSwipeable` to `UIViewController`, and set `configureSwipeBack()` to `viewDidAppear`.

```swift
import UIKit

final class ViewController: UIViewController, BlowinSwipeable {

    var blowinSwiper: BlowinSwiper?

    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        configureSwipeBack()
    }
}
```
---
### Horizontal scroll handling
**《１》** Please do 《１》 of Normal.  
**《２》** Please refer to the following source code.  
Set `BlowinSwipeable` to `UIViewController`.  
Set `configureSwipeBack(isLowSensitivity: true)` and `enabledRecognizeSimultaneously(scrollView: swipeMenuView.contentScrollView)` to `viewDidAppear`.  
Set `disabledRecognizeSimultaneously()` to `viewDidDisappear`.

```swift
import UIKit

final class ViewController: UIViewController, BlowinSwipeable {

    var blowinSwiper: BlowinSwiper?

    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        configureSwipeBack(isInsensitive: true)
        enabledRecognizeSimultaneously(scrollView: swipeMenuView.contentScrollView)
    }

    override func viewDidDisappear(_ animated: Bool) {
        super.viewDidDisappear(animated)
        disabledRecognizeSimultaneously()
    }
}

extension MenuViewController: SwipeMenuViewDelegate {
    func swipeMenuViewDidScroll(_ contentScrollView: UIScrollView) { // added itself to this delegate.
        handleScrollRecognizeSimultaneously(scrollView: contentScrollView)
    }
}
```

## Author
### Takuma Horiuchi
- [Facebook](https://www.facebook.com/profile.php?id=100008388074028)
- [Twitter](https://twitter.com/horitaku_)
- [GitHub](https://github.com/horitaku46)

## License
`BlowinSwiper` is available under the MIT license. See the [LICENSE](./LICENSE) file for more info.
