//
//  Item.swift
//  ToDoList-Juangco
//
//  Created by Jared Juangco on 17/6/22.
//

import Foundation

class Item: Codable {
    var title: String
    var done: Bool
    
    init(title: String = "", done: Bool = false) {
        self.title = title
        self.done = done
    }
}
