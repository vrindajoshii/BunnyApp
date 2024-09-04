//
//  ToDoItem.swift
//  BunnyApp
//
//  Created by Vrinda Joshi on 01/09/2024.
//

import Foundation

struct ToDoItem: Codable, Identifiable{
    let id: String
    let title: String
    let dueDate: TimeInterval
    let createdDate: TimeInterval
    var isDone: Bool //var so can mutate it
    
    mutating func setDone(_ state: Bool){ //mutating bc this is a struct which is a value type
        isDone = state
    }
}
