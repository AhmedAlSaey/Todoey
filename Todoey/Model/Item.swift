//
//  TodoCellModel.swift
//  Todoey
//
//  Created by Ahmed AlSai on 5/13/19.
//  Copyright © 2019 Ahmed AlSai. All rights reserved.
//

import Foundation

class Item {
    var title : String
    var done : Bool = false
    
    init(_ title : String) {
        self.title = title
    }
}
