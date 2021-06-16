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
        let context = Core.backgroundContext
        let predicate = NSPredicate(format: "task == %@",task)
        TaskHelper.fetchData(entity: Task.self, namePredicate: predicate, completion: {(data) in
            guard let data = data else{return}
            if(data.count == 0){
                context.perform {
                     let newTask = Task(context: context)
                     newTask.task = task
                     newTask.date = Utilities.getDate()
                     context.saveContext()
                     completion()
                 }
            }else{
                data[0].setValue(task, forKey: "task")
            }
            
        })
    }
}
