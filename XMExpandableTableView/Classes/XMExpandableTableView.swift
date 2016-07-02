//
//  XMExpandableTableViewController.swift
//  ExpandableTableView
//
//  Created by Xavier Merino on 6/18/16.
//  Copyright © 2016 Xavier Merino. All rights reserved.
//

import UIKit

/// `XMExpandableTableView` is a subclass of `UITableViewController`.
/// It allows you to specify a height for a collapsed and expanded state for a cell.
/// This behavior is only supported for tableviews that have 1 section. It supports the addition and removal of rows.
public class XMExpandableTableView: UITableViewController {
    
    /// `XMExpandableRowModel` contains information about the rows in your tableview. More specifically the height of each cell in its collapsed and expanded state.
    /// It currently only works for tableviews that have 1 section. It could be expanded to suit a tableview with more number of sections.
    public struct XMExpandableRowModel {
        /// A `Row` object contains information about the collapsed and expanded height of the cell. It also tells you whether the cell is expanded or not.
        struct Row {
            /// Collapsed height of the cell
            var collapsed:Int
            /// Expanded height of the cell
            var expanded:Int
            /// State of the cell (Expanded / Not Expanded)
            var isExpanded:Bool = false
            
            init(collapsed:Int, expanded:Int, isExpanded:Bool){
                self.collapsed = collapsed
                self.expanded = expanded
                self.isExpanded = isExpanded
        }
            
            /// Allows using subscript to access the parameters of the `Row` object.
            /// This will allow `row[0]` to access `collapsed` and so on.
            /// You can get or set values this way.
            /// If index is not within 0 and 2, it will return -1.
        subscript(property: Int) -> AnyObject {
                get {
                    var index:Int = property
                    index = index >= 0 && index <= 2 ? index : -1
                    
                    switch index {
                    case 0:
                        return self.collapsed
                    case 1:
                        return self.expanded
                    case 2:
                        return self.isExpanded
                    default:
                        return index
                    }
                }
                
                /// `newValue` refers to the value to be assigned to the accessed property.
                set {
                    var index:Int = property
                    index = index >= 0 && index <= 2 ? index : -1
                    
                    switch index {
                    case 0:
                        self.collapsed = newValue as! Int
                    case 1:
                        self.expanded = newValue as! Int
                    case 2:
                        self.isExpanded = newValue as! Bool
                    default:
                        break
                    }
                    
                }
            }
        }
        
        /// Main data structure in `XMExpandableRowModel`. It is a dictionary that contains entries for all of the rows.
        private var expandableHeights = [Int:Row]()
        
        /// Standard Collapsed Height that will be set to all rows if not specified.
        public var standardCollapsedHeight:Int = 44
        
        /// Standard Expanded Height that will be set to all rows if not specified.
        public var standardExpandedHeight:Int = 44
        
        /// Constants that allow using labels instead of numbers for subscripting.
        let collapsed:Int = 0
        let expanded:Int = 1
        let isExpanded:Int = 2
        
        /// Sets a cell's collapsed height to the value specified by `collapsedHeight`
        /// If the cell hasn't been added before, add it throught `addRow`.
        public mutating func setCollapsedHeight(forRow row:Int, collapsedHeight:Int) {
            /// Checks if `expandableHeights` contains the row you are assigning to.
            /// If it does not, then it does nothing.
            if expandableHeights.keys.contains(row){
                expandableHeights[row]![collapsed] = collapsedHeight
            }
        }
        
        /// Sets a cell's collapsed height to the value specified by `collapsedHeight`
        /// If the cell hasn't been added before, add it throught `addRow`.
        public mutating func setExpandedHeight(forRow row:Int, expandedHeight:Int) {
            /// Checks if `expandableHeights` contains the row you are assigning to.
            /// If it does not, then it does nothing.
            if expandableHeights.keys.contains(row){
                expandableHeights[row]![expanded] = expandedHeight
            }
        }
        
        /// Sets a cell's collapsed height to the value specified by `standardCollapsedHeight`
        /// If the cell hasn't been added before, add it throught `addRow`.
        public mutating func setCollapsedHeightStandard(forRow row:Int) {
            /// Checks if `expandableHeights` contains the row you are assigning to.
            /// If it does not, then it does nothing.
            if expandableHeights.keys.contains(row){
                expandableHeights[row]![collapsed] = standardCollapsedHeight
            }
        }
        
        /// Sets a cell's collapsed height to the value specified by `standardExpandedHeight`
        /// If the cell hasn't been added before, add it throught `addRow`.
        public mutating func setExpandedHeightStandard(forRow row:Int) {
            /// Checks if `expandableHeights` contains the row you are assigning to.
            /// If it does not, then it does nothing.
            if expandableHeights.keys.contains(row){
                expandableHeights[row]![expanded] = standardExpandedHeight
            }
        }
        
        /// Sets a cell's collapsed height to the value specified by `standardExpandedHeight`
        /// If the cell hasn't been added before, add it throught `addRow`.
        mutating func setRowIsExpanded(forRow row:Int, expanded:Bool) {
            /// Checks if `expandableHeights` contains the row you are assigning to.
            /// If it does not, then it does nothing.
            if expandableHeights.keys.contains(row){
                expandableHeights[row]![isExpanded] = expanded
            }
        }
        
        /// Gets a cell's collapsed height.
        /// If the cell does not exist within the model then it returns `-1`.
        /// If the cell hasn't been added before, add it throught `addRow`.
        public func getCollapsedHeight(forRow row:Int) -> CGFloat {
            /// Checks if `expandableHeights` contains the row you are attempting to read from.
            /// If it does not, then it returns `-1`
            if expandableHeights.keys.contains(row){
                return expandableHeights[row]![collapsed] as! CGFloat
            }
            return -1
        }
        
        /// Gets a cell's expanded height.
        /// If the cell does not exist within the model then it returns `-1`.
        /// If the cell hasn't been added before, add it throught `addRow`.
        public func getExpandedHeight(forRow row:Int) -> CGFloat {
            /// Checks if `expandableHeights` contains the row you are attempting to read from.
            /// If it does not, then it returns `-1`
            if expandableHeights.keys.contains(row){
                return expandableHeights[row]![expanded] as! CGFloat
            }
            return -1
        }
        
        /// Gets a cell's state.
        /// If the cell does not exist within the model then it returns `-1`.
        /// If the cell hasn't been added before, add it throught `addRow`.
        public func isRowExpanded(forRow row:Int) -> Bool {
            /// Checks if `expandableHeights` contains the row you are attempting to read from.
            /// If it does not, then it returns `false`
            if expandableHeights.keys.contains(row){
                return expandableHeights[row]![isExpanded] as! Bool
            }
            return false
        }
        
        /// Adds a new row to the model.
        /// In order to create a new row you need a row number, its collapsed height, and its expanded height.
        /// If you provide a row number that already exists, then that row will be update with the values provided.
        public mutating func addRow(row:Int, collapsedHeight:Int, expandedHeight:Int){
            let newRow:Row = Row(collapsed: collapsedHeight, expanded: expandedHeight, isExpanded: false)
            expandableHeights[row] = newRow
        }
        
        /// Removes a row from the model.
        /// In order to remove a new row you need a row number.
        /// Subsequent rows will just be adjusted to reflect their new row number.
        public mutating func removeRow(row:Int){
            expandableHeights.removeValueForKey(row)
            var fromKey = row + 1
            var toKey = row
            let iterations:Int = expandableHeights.count - row
            
            /// Moving all the rows up after the specified row was deleted.
            for _ in 0...iterations {
                if let entry = expandableHeights.removeValueForKey(fromKey){
                    expandableHeights[toKey] = entry
                    fromKey += 1
                    toKey += 1
                }
            }
        }
        
        /// Gets the row number of the expanded cell.
        /// If there is no expanded row then it will return `-1`
        public func getExpandedRow() -> Int {
            for key in expandableHeights.keys {
                if expandableHeights[key]![isExpanded] as! Bool == true {
                    return key
                }
            }
            return -1
        }
    }
    
    /// Holds the `NSIndexPath` of the selected row. If its nil no row has been selected.
    var selectedCellIndexPath:NSIndexPath?
    public var rowModel = XMExpandableRowModel()
    
    override public func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override public func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    /// Returns the height of the cell. This allows to control the height for collapsed and expanded states.
    /// If the cell is already expanded it will provide the collapsed value, otherwise it will provide the expanded value.
    override public func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
        guard let selectedCellIndexPath = selectedCellIndexPath else {
            return rowModel.getCollapsedHeight(forRow: indexPath.row)
        }
        
        if selectedCellIndexPath == indexPath {
            return rowModel.getExpandedHeight(forRow: indexPath.row)
        }
        
        return rowModel.getCollapsedHeight(forRow: indexPath.row)
    }
    
    /// When a cell is selected `selectedCellIndexPath` gets updated. This allows, in combination with `heightForRowAtIndexPath` to expand a specific cell.
    /// It also updates the row model to reflect which cell is expanded. Its worth noting that only one cell can be expanded at the time. This is, all expanded
    /// cells will return to their collapsed height once a new cell is expanded.
    override public func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        if let selectedCellIndexPath = selectedCellIndexPath {
            if selectedCellIndexPath == indexPath {
                self.selectedCellIndexPath = nil
                self.rowModel.setRowIsExpanded(forRow: indexPath.row, expanded: false)
            } else {
                self.rowModel.setRowIsExpanded(forRow: selectedCellIndexPath.row, expanded: false)
                self.selectedCellIndexPath = indexPath
                self.rowModel.setRowIsExpanded(forRow: indexPath.row, expanded: true)
            }
        } else {
            selectedCellIndexPath = indexPath
            self.rowModel.setRowIsExpanded(forRow: indexPath.row, expanded: true)
        }
        
        /// Reflects the changes in the tableview.
        tableView.beginUpdates()
        tableView.endUpdates()
    }
    
    /// This function defines the behavior of a removed cell. It deletes the cell from the row model. When overriding this method in your tableview, make sure to call
    /// super on this method so that this occurs. Don't forget to delete the content from the data source as well.
    override public func tableView(tableView: UITableView, commitEditingStyle editingStyle: UITableViewCellEditingStyle, forRowAtIndexPath indexPath: NSIndexPath) {
        /// Attempting to delete the cell creates the delete option to the right. But it also shows the expanded contents of the cell if there is free space below.
        /// This behavior is unintended.
        
        if editingStyle == UITableViewCellEditingStyle.Delete {
            self.rowModel.removeRow(indexPath.row)
        }
        
        /// Reflects the changes in the tableview.
        tableView.beginUpdates()
        tableView.endUpdates()
    }
    
}
