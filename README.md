<p align="center">
    <img src="Logo.png" width="484" max-width="80%" alt=".. =." />
</p>

[![Swift 5.1](https://img.shields.io/badge/Swift-5.1-orange.svg)]()
[![swiftpm compatible](https://img.shields.io/badge/swiftpm-compatible-brightgreen.svg?style=flat)](https://swift.org/package-manager) 

A Swift package with a few usefull operators that can improve ergonomics of your codebase.

## Problem 🌊
Image the situation when you write a function that should create a view:
```swift
func makeUIView() -> UIView {
    return UIView()
}
```

With Swift 5.1 implicit returns syntax you can write instead this:
```swift
func makeUIView() -> UIView {
    UIView()
}
```
Or just:
```swift
func makeUIView() -> UIView {
    .init()
}
```

But if you(probably) need to customize this fresh instance you are left with no other choise, 
but to bring the `return` keyword back, but besides that you have to write a separate line 
with declaration:
```swift
func makeUIView() -> UIView {
    let view = UIView()
    view.backgroundColor = .red
    view.translatesAutoresizingMaskIntoConstraints = false
    view.clipsToBounds = true
    view.alpha = 0.2
    return view
}
```

## Solution 🦾
Use SetterOperators and write this intead:
```swift
func makeUIView() -> UIView {
    .init()
        .. \.backgroundColor .= .red
        .. \.translatesAutoresizingMaskIntoConstraints .= false
        .. \.clipsToBounds .= true
        .. \.alpha .= 0.2
}
```

### How does it work? 📖
This library consists of a two operators:
1. The first one is `..` it takes and object and a keypath and returns a setter
2. The second is `.=` it takes a setter and value and returns an updated instance
It as simple as that!😎

KeyPath can be multilevel, so you can have even such setups:
```swift
func person() -> Person {
    .init()
        .. \.name.first .= "Mike"
        .. \.age .= 22
}
```

### Warning ❗️
Swift compiler does an extremely good job with flattening closures, so you won't get any
performance penalty here. And keyPaths work just as fast as dot notation(if not faster🤭).
The only caveat that is indeed real consists in fact that value-type version of `..` has to make
a copy of provided value, so avoid using it with really large structures.
