//
//  DemoTableViewController.swift
//  XMExpandableTableViewControllerDemo
//
//  Created by Xavier Merino on 6/26/16.
//  Copyright © 2016 Xavier Merino. All rights reserved.
//

import UIKit
import XMExpandableTableView

class DemoTableViewController: XMExpandableTableView {
    
    var data:[[String]] = [["Xavier Merino", "BSc. Computer Engineering", "Enjoys coding in Swift as a hobby."], ["Chocolate Snail", "Chocolate Eater", "Eats chocolate all day long."], ["Non-Expandable Row"]]
    
    var pictures:[UIImage] = [UIImage(named: "profilePic")!, UIImage(named: "profilePic2")!, UIImage()]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Adding rows to the model
        super.rowModel.addRow(0, collapsedHeight: 83, expandedHeight: 174)
        super.rowModel.addRow(1, collapsedHeight: 83, expandedHeight: 174)
        
        // Setting the standard collapsed height to the default 44.
        super.rowModel.standardCollapsedHeight = 44
        super.rowModel.addRow(2, collapsedHeight: super.rowModel.standardCollapsedHeight, expandedHeight: super.rowModel.standardCollapsedHeight)
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    // MARK: - Table view data source
    
    override func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 1
    }
    
    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return data.count
    }
    
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        // This if statement is here because we only have two expandable cells, which are rows 0 and 1.
        if indexPath.row < 2 {
            let cell = tableView.dequeueReusableCellWithIdentifier("customCell", forIndexPath: indexPath) as! CustomTableViewCell
            let row = indexPath.row
            cell.expandingAccessory.image = UIImage(named: "down")!
            cell.profilePic.image = pictures[row]
            cell.nameLabel.text = data[row][0]
            cell.line1Label.text = data[row][1]
            cell.line2Label.text = data[row][2]
            return cell
        } else {
            let cell = tableView.dequeueReusableCellWithIdentifier("nonExpandableCell", forIndexPath: indexPath)
            let row = indexPath.row
            cell.textLabel?.text = data[row][0]
            return cell
        }
        
    }
    
    override func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        super.tableView(tableView, didSelectRowAtIndexPath: indexPath)
        
        // ExpandedRow will be -1 if no row is selected.
        let expandedRow = super.rowModel.getExpandedRow()
        var expandedCell:UITableViewCell
        
        // This if statement is here because we only have two expandable cells, which are rows 0 and 1.
        if indexPath.row < 2 {
            if expandedRow == -1 {
                expandedCell = tableView.cellForRowAtIndexPath(indexPath)!
                (expandedCell as! CustomTableViewCell).expandingAccessory.image = UIImage(named: "down")!
            } else {
                expandedCell = tableView.cellForRowAtIndexPath(NSIndexPath(forRow: expandedRow, inSection: 0))!
                (expandedCell as! CustomTableViewCell).expandingAccessory.image = UIImage(named: "up")!
            }
        }
        
    }
    
    override func tableView(tableView: UITableView, didDeselectRowAtIndexPath indexPath: NSIndexPath) {
        // This if statement is here because we only have two expandable cells, which are rows 0 and 1.
        if indexPath.row < 2 {
            let cell = tableView.cellForRowAtIndexPath(indexPath) as! CustomTableViewCell
            cell.expandingAccessory.image = UIImage(named: "down")!
        }
    }
    
    override func tableView(tableView: UITableView, commitEditingStyle editingStyle: UITableViewCellEditingStyle, forRowAtIndexPath indexPath: NSIndexPath) {
        if editingStyle == .Delete {
            super.tableView(tableView, commitEditingStyle: .Delete, forRowAtIndexPath: indexPath)
            data.removeAtIndex(indexPath.row)
            pictures.removeAtIndex(indexPath.row)
            tableView.deleteRowsAtIndexPaths([indexPath], withRowAnimation: .Fade)
        }
    }
    
}
