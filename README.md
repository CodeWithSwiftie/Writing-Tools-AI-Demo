# 🔧 iOS Writing Tools AI Demo

![Swift](https://img.shields.io/badge/Swift-5.9-orange.svg)
![Platform](https://img.shields.io/badge/Platform-iOS_18.2-blue.svg)
![License](https://img.shields.io/badge/License-MIT-green.svg)

A demonstration project showcasing the integration of the new Apple Writing Tools API introduced in iOS 18.2.

## 📱 Overview

This project demonstrates the usage of the new `showWritingTools(_:)` API that provides access to built-in AI writing tools in iOS applications.

<img src="preview.gif" width="300">

## ✨ Key Features

- Native Apple Writing Tools AI integration
- Delegate pattern demonstration and event handling

## 🛠 Requirements

- iOS 18.2+
- iPadOS 18.2+
- Mac Catalyst 18.2+
- Xcode 15.2+
- Swift 5.9+

## 📖 Usage

1. Clone the repository
```bash
git clone https://github.com/CodeWithSwiftie/Writing-Tools-AI-Demo.git
```

2. Open `AI Tools.xcodeproj` in Xcode

3. Run the project on a device or simulator with iOS 18.2+

## 💡 Key Components

### ViewController
Main controller demonstrating Writing Tools integration:

```swift
textView.becomeFirstResponder()
textView.showWritingTools(textView)
```

## 📝 Implementation Notes

- API is only available on iOS 18.2 and above
- Requires active firstResponder for text view
- Supports both plain text and attributed text

## ✉️ Contact

If you have any questions or suggestions, feel free to create an issue or reach out directly.

---

⭐️ If you find this project helpful, don't forget to give it a star!
