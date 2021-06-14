//
//  SubTask+CoreDataClass.swift
//  Todo
//
//  Created by Jeyaram on 11/06/21.
//
//

import Foundation
import CoreData

@objc(SubTask)
public class SubTask: NSManagedObject {
    
    static func fetchAll(completion:([SubTask])->()){
        do{
            let task :[SubTask] = try Core.viewcontext.fetch(Self.fetchRequest())
            completion(task)
        }catch{
            print("Error in Fetch")
        }
    }
    static func fetchTask(under currentTask:Task,completion:([SubTask])->()){
        do{
            let request = self.fetchRequest() as NSFetchRequest<SubTask>
            let namePredicate   = NSPredicate(format: "parentTask == %@",currentTask)
            request.predicate = namePredicate
            let task :[SubTask] = try Core.viewcontext.fetch(request)
            completion(task)
        }catch{
            print("Error in Fetch")
        }
    }
    
    static func insertSubTask(newTask task:String,under parentTask: Task,completion:@escaping()->()){
            Core.backgroundContext.perform {
            let newTask = SubTask(context: Core.viewcontext)
            newTask.task = task
            newTask.date = Utilities.getDate()
            newTask.parentTask = parentTask
            Core.backgroundContext.saveContext()
            completion()
        }
        
    }
}
