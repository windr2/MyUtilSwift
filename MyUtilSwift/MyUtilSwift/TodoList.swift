//
//  TodoList.swift
//  MyUtilSwift
//
//  Created by SEO_MAC on 2016. 8. 26..
//  Copyright © 2016년 SEO_MAC. All rights reserved.
//

import Foundation
import UIKit

class TodoList {
    class var sharedInstance : TodoList{
        struct Static {
            static let instance : TodoList = TodoList()
        }
        return Static.instance
    }
    
    private let ITEMS_KEY = "todoItems";
    
    
    func allItem() -> [TodoItem] {
        let todoDictionary = NSUserDefaults.standardUserDefaults().dictionaryForKey(ITEMS_KEY) ?? [:]
        let items = Array(todoDictionary.values);
        
        return items.map({
            TodoItem(deadline: $0["deadline"] as! NSDate, title: $0["title"] as! String, UUID: $0["UUID"] as! String!)
        }).sort({(left: TodoItem, right:TodoItem) -> Bool in
            (left.deadline.compare(right.deadline) == .OrderedAscending)
        })
        
        
    }
    
    func addItem(item: TodoItem){
        var todoDictionary = NSUserDefaults.standardUserDefaults().dictionaryForKey(ITEMS_KEY) ?? Dictionary()
        todoDictionary[item.UUID] = ["deadline": item.deadline , "title": item.title , "UUID": item.UUID]
        NSUserDefaults.standardUserDefaults().setObject(todoDictionary, forKey: ITEMS_KEY)
        
        let notification = UILocalNotification()
        notification.alertBody = "Todo Item \(item.title) is Overdue"
        notification.alertAction = "open"
        notification.fireDate = item.deadline
        notification.soundName = UILocalNotificationDefaultSoundName
        notification.userInfo = ["title": item.title , "UUID": item.UUID]
        
        UIApplication.sharedApplication().scheduleLocalNotification(notification)
        
        print("add item ok")
    }
    
    
    func removeItem(item: TodoItem){
        let scheduledNotifications: [UILocalNotification]? = UIApplication.sharedApplication().scheduledLocalNotifications
        guard scheduledNotifications != nil else {return}
        
        for notification in scheduledNotifications! {
            if (notification.userInfo!["UUID"] as! String == item.UUID ){
                UIApplication.sharedApplication().cancelLocalNotification(notification)
                break
            }
        }
        
        if var toItems = NSUserDefaults.standardUserDefaults().dictionaryForKey(ITEMS_KEY){
            toItems.removeValueForKey(item.UUID)
            NSUserDefaults.standardUserDefaults().setObject(toItems, forKey: ITEMS_KEY)
        }
        
    }
}
