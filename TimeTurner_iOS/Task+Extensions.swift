//
//  Task+Extensions.swift
//  TimeTurner_iOS
//
//  Created by Boychaboy Mac on 2020/03/29.
//  Copyright © 2020 Kun Jeong. All rights reserved.
//

import Foundation
import CoreData

extension Task: Identifiable {
    public var wrappedName: String {
        name ?? "New To-Do"
    }
//    static func getIncompleteTasks() -> NSFetchRequest<Task> {
//      let request: NSFetchRequest<Task> = Task.fetchRequest()
//      request.sortDescriptors = [NSSortDescriptor(keyPath: \Task.dateAdded, ascending: false)]
//        request.predicate = NSPredicate(format: "isComplete == %@", NSNumber(value: false))
//      return request
//    }
}
