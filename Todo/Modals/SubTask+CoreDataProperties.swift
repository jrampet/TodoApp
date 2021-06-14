//
//  SubTask+CoreDataProperties.swift
//  Todo
//
//  Created by Jeyaram on 11/06/21.
//
//

import Foundation
import CoreData


extension SubTask {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<SubTask> {
        return NSFetchRequest<SubTask>(entityName: "SubTask")
    }

    @NSManaged public var task: String?
    @NSManaged public var date: String?
    @NSManaged public var parentTask: Task?

}

extension SubTask : Identifiable {

}
