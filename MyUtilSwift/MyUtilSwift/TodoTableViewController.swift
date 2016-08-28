//
//  TodoTableViewController.swift
//  MyUtilSwift
//
//  Created by SEO_MAC on 2016. 8. 26..
//  Copyright © 2016년 SEO_MAC. All rights reserved.
//

import Foundation
import UIKit

class TodoTableViewController: UITableViewController{
    
    var todoItems: [TodoItem] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        NSNotificationCenter.defaultCenter().addObserver(
            self,
            selector: #selector(TodoTableViewController.refreshList),
            name: "TodoListShouldRefresh",
            object: nil)
    }
    
    
    
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
        refreshList()
    }
    
    func refreshList() {
        todoItems = TodoList.sharedInstance.allItems();
        
        if todoItems.count >= 64 {
            self.navigationItem.rightBarButtonItem!.enabled = false
        }
        
        tableView.reloadData()
    }
    
    override func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 1
    }
    
    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return todoItems.count
    }
    
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("todoCell" , forIndexPath: indexPath)
        let todoItem = todoItems[indexPath.row] as TodoItem
        
        cell.textLabel?.text = todoItem.title as String!
        if todoItem.isOverdue {
            cell.detailTextLabel?.textColor = UIColor.redColor()
        }else{
            cell.detailTextLabel?.textColor = UIColor.blackColor()
        }
        
        let dateFormatter = NSDateFormatter()
        dateFormatter.dateFormat = "'Due' MM dd 'at' h:mm a"
        cell.detailTextLabel?.text = dateFormatter.stringFromDate(todoItem.deadline)
        
        return cell
    }
    
    override func tableView(tableView: UITableView, canEditRowAtIndexPath indexPath: NSIndexPath) -> Bool {
        return true;
    }
    
    override func tableView(tableView: UITableView, commitEditingStyle editingStyle: UITableViewCellEditingStyle, forRowAtIndexPath indexPath: NSIndexPath) {
        if editingStyle == .Delete{
            let item = todoItems.removeAtIndex(indexPath.row);
            tableView.deleteRowsAtIndexPaths([indexPath], withRowAnimation: .Fade)
            TodoList.sharedInstance.removeItem(item)
            
            self.navigationItem.rightBarButtonItem!.enabled = true
        }
    }
  
}
