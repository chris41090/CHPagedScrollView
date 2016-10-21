# CHPagedScrollView

CHPagedScrollView is a class  written in Swift 3 and designed to simplify the implementation of horizontal, paged scrolling views

## Supported OS & SDK Versions
* Supported build target - iOS 8.0 
* Earliest supported deployment target - iOS 8.0

NOTE: 'Supported' means that the library has been tested with this version. 'Compatible' means that the library should work on this OS version (i.e. it doesn't rely on any unavailable SDK features) but is no longer being tested for compatibility and may require tweaking or bug fixes to run correctly.


## Features

* Easy - to - user
* Written in swift 3
* Fast
* All delegate methods tha you will need
* You can use whatever views you want

## Examples
![example1](http://g.recordit.co/6tBy0lr7I5.gif)

![expmple2](http://g.recordit.co/D9zcSUkANh.gif)

## Intallation

To use the CHPagesScrollView class in an app, just drag the CHPagesScrollView class files (demo files and assets are not needed) into your project.

## Properties
```swift
   var pageViews = [UIView]()
```
  By seting this array with whatever view you like set up the pages of the scroll view
 
## Methods
  ```swift
    func scrollAtIndex(_ index:Int) {
```
  With this function you can scroll to any page you want
  
  
## Protocols

CHPagesScrollView provides a protocol interface, CHPagedScrollViewDelegate and you can set it with chPagedScrollViewDelegate property.  The CHPagedScrollViewDelegate protocol has the following methods:
```swift
    func pountoScrollView(_ pountoScrollView:CHPagedScrollView, didScrollToIndex index:Int, currentView:UIView)
```
  This method is called when the CHPagesScrollView has moved to a another page.

```swift
    func pountoScrollView(_ pountoScrollView:CHPagedScrollView, didSelectView view:UIView, atIndex index:Int)
```
  This method is called when the user has tapped to a view.
