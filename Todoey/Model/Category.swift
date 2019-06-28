//
//  Category.swift
//  Todoey
//
//  Created by Ahmed AlSai on 6/5/19.
//  Copyright © 2019 Ahmed AlSai. All rights reserved.
//

import Foundation
import RealmSwift

class Category : Object {
    @objc dynamic var name : String = ""
    var items = List<Item>()
}
