//
//  Task+CoreDataProperties.swift
//  Todo
//
//  Created by Jeyaram on 11/06/21.
//
//

import Foundation
import CoreData


extension Task {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Task> {
        return NSFetchRequest<Task>(entityName: "Task")
    }

    @NSManaged public var date: String?
    @NSManaged public var task: String?
    @NSManaged public var subtask: NSSet?

}

// MARK: Generated accessors for subtask
extension Task {

    @objc(addSubtaskObject:)
    @NSManaged public func addToSubtask(_ value: SubTask)

    @objc(removeSubtaskObject:)
    @NSManaged public func removeFromSubtask(_ value: SubTask)

    @objc(addSubtask:)
    @NSManaged public func addToSubtask(_ values: NSSet)

    @objc(removeSubtask:)
    @NSManaged public func removeFromSubtask(_ values: NSSet)

}

extension Task : Identifiable {

}
