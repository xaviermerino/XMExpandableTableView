# XMExpandableTableView

[![CI Status](http://img.shields.io/travis/Xavier Merino/XMExpandableTableView.svg?style=flat)](https://travis-ci.org/Xavier Merino/XMExpandableTableView)
[![Version](https://img.shields.io/cocoapods/v/XMExpandableTableView.svg?style=flat)](http://cocoapods.org/pods/XMExpandableTableView)
[![License](https://img.shields.io/cocoapods/l/XMExpandableTableView.svg?style=flat)](http://cocoapods.org/pods/XMExpandableTableView)
[![Platform](https://img.shields.io/cocoapods/p/XMExpandableTableView.svg?style=flat)](http://cocoapods.org/pods/XMExpandableTableView)

## Overview
XMExpandableTableView is a subclass of UITableViewController. It allows you to quickly implement a table view whose cells can expand. You can customize your cell to reflect changes when it expands and collapses.

![Screenshot](https://thumbs.gfycat.com/OddballDenseHerald-size_restricted.gif)

## Requirements
* iOS 8+

## Installation
You can install XMExpandableTableView manually by simply copying `XMExpandableTableView.swift` into your project's workspace.  

XMExpandableTableView is available through [CocoaPods](http://cocoapods.org).  To install it, simply add the following line to your Podfile:

```ruby
pod "XMExpandableTableView"
```

## Usage

* In the Storyboard and drag a Table View Controller
* Create a .swift file for the Table View Controller
* Select the view and under the Identity Inspector select your newly created Swift file. Make sure that your file is set to inherit from `UITableViewController`.

![Screenshot](https://dl.dropboxusercontent.com/u/72507896/XMExpandableTableView/demoFile.png)

* Import XMExpandableTableView into your project.

```Swift
import XMExpandableTableView
```

* In your file, make sure to replace `UITableViewController` with `XMExpandableTableView`.

```Swift
import UIKit
import XMExpandableTableView

class DemoTableViewController: XMExpandableTableView {
```

* Let `XMExpandableTableView` know about the cells you want to expand by using `super.rowModel.addRow(rowNumber, collapsedHeight: cHeight, expandedHeight: eHeight)`. You should do this for every row, even the ones you don't plan on expanding. In the example provided below we want to be able expand the first two cells and leave the third one always collapsed.

```Swift
override func viewDidLoad() {
    super.viewDidLoad()

    // Adding rows to the model
    super.rowModel.addRow(0, collapsedHeight: 83, expandedHeight: 174)
    super.rowModel.addRow(1, collapsedHeight: 83, expandedHeight: 174)

    // Setting the standard collapsed height to the default 44.
    super.rowModel.standardCollapsedHeight = 44
    super.rowModel.addRow(2, collapsedHeight: super.rowModel.standardCollapsedHeight, expandedHeight: super.rowModel.standardCollapsedHeight)
}
```

* The rows will expand when selected. If you wish to do something else upon selection you must override the `didSelectRowAtIndexPath` provided by `XMExpandableTableView`. Make sure to call the XMExpandableTableView method to keep the expanding / collapsing functionality. An example is provided below.

```Swift
override func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
    // Keeps the expand / collapse behavior
    super.tableView(tableView, didSelectRowAtIndexPath: indexPath)

    // ExpandedRow will be -1 if no row is selected.
    let expandedRow = super.rowModel.getExpandedRow()

    // Your code goes here

}

```

* If you want to delete a cell make sure to call `super.tableView(tableView, commitEditingStyle: .Delete, forRowAtIndexPath: indexPath)` to let `XMExpandableTableView` know that you are deleting a row. It will update its internal model and everything will work as intended. Also make sure to delete the content from your data source. An example is provided below.

![Remove Row](https://dl.dropboxusercontent.com/u/72507896/XMExpandableTableView/deleteRow.png)

```Swift
override func tableView(tableView: UITableView, commitEditingStyle editingStyle: UITableViewCellEditingStyle, forRowAtIndexPath indexPath: NSIndexPath) {
    if editingStyle == .Delete {
        // Makes XMExpandableTableView update its internal row model.
        super.tableView(tableView, commitEditingStyle: .Delete, forRowAtIndexPath: indexPath)
        // Make sure to delete the content from your data source as well.
        data.removeAtIndex(indexPath.row)
        pictures.removeAtIndex(indexPath.row)
        tableView.deleteRowsAtIndexPaths([indexPath], withRowAnimation: .Fade)
    }
}
```

You can see the full example by following the steps in the Example section.

## Example

To run the example project, clone the repo, and run `pod install` from the Example directory first.

## Issues
If you find any issues regarding this project let me know and file them in the Issues section. My email is below.

## Author

Xavier Merino, xaviermerino@gmail.com

## License

XMExpandableTableView is available under the MIT license. See the LICENSE file for more info.
