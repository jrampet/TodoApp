//
//  Task+CoreDataClass.swift
//  Todo
//
//  Created by Jeyaram on 11/06/21.
//
//

import Foundation
import CoreData

@objc(Task)
public class Task: NSManagedObject {
    
    static func fetchAll(completion:([Task])->()){
        do{
            let task :[Task] = try Core.viewcontext.fetch(Self.fetchRequest())
            completion(task)
        }catch{
            print("Error in Fetch")
        }
    }
    static func insert(newTask task:String,completion:@escaping()->()){
        Core.backgroundContext.perform {
            let newTask = Task(context: Core.backgroundContext)
            newTask.task = task
            newTask.date = Utilities.getDate()
            Core.backgroundContext.saveContext()
            completion()
        }
    }
}
