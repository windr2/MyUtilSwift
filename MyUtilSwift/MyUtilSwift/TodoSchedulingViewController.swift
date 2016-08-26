//
//  TodoSchedulingViewController.swift
//  MyUtilSwift
//
//  Created by SEO_MAC on 2016. 8. 26..
//  Copyright © 2016년 SEO_MAC. All rights reserved.
//

import Foundation
import UIKit

class TodoSchedulingViewController: UIViewController{
    @IBOutlet var titleField: UITextField!
    @IBOutlet var deadlinePicker: UIDatePicker!
    
    @IBAction func savePressed(sender: AnyObject) {
        let dateTime = deadlinePicker.date
        let todoItem = TodoItem(deadline: dateTime , title: titleField.text! , UUID: NSUUID().UUIDString)
        
        print("select date : \(dateTime)")
        
        TodoList.sharedInstance.addItem(todoItem)
        self.navigationController?.popViewControllerAnimated(true)
        
    }

}
