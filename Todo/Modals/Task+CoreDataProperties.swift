//
//  Task+CoreDataProperties.swift
//  Todo
//
//  Created by Jeyaram on 09/06/21.
//
//

import Foundation
import CoreData


extension Task {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Task> {
        return NSFetchRequest<Task>(entityName: "Task")
    }

    @NSManaged public var task: String?
    @NSManaged public var date: String?

}

extension Task : Identifiable {

}
