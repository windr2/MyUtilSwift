//
//  TodoItem.swift
//  MyUtilSwift
//
//  Created by SEO_MAC on 2016. 8. 26..
//  Copyright © 2016년 SEO_MAC. All rights reserved.
//

import Foundation

struct TodoItem{
    var title: String
    var deadline: NSDate
    var UUID: String
    
    init (deadline: NSDate , title: String , UUID: String){
        self.deadline = deadline
        self.title = title
        self.UUID = UUID
        
    }
    
    var isOverdue: Bool {
        return (NSDate().compare(self.deadline) == NSComparisonResult.OrderedDescending)
    }
}