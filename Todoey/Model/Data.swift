//
//  Data.swift
//  Todoey
//
//  Created by Ahmed AlSai on 6/4/19.
//  Copyright © 2019 Ahmed AlSai. All rights reserved.
//

import Foundation
import RealmSwift

class Data : Object {
    @objc dynamic var name : String = ""
    @objc dynamic var age : Int = 0
}
