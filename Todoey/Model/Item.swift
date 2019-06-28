//
//  Item.swift
//  Todoey
//
//  Created by Ahmed AlSai on 6/5/19.
//  Copyright © 2019 Ahmed AlSai. All rights reserved.
//

import Foundation
import RealmSwift

class Item: Object{
    @objc dynamic var title : String = ""
    @objc dynamic var done : Bool = false
    var parentCategory = LinkingObjects(fromType: Category.self, property: "items")
    @objc dynamic var dateCreated : Date = Date()
}
