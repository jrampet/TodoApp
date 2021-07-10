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
    
    static func insertSubTask(newTask task:String,under parentTask: NSManagedObjectID,completion:@escaping()->()){
        let context = Core.viewcontext
        guard let localParent = context.object(with: parentTask) as? Task else{return}
        let predicate = NSPredicate(format: "parentTask == %@ && task == %@",localParent,task)
        
        TaskHelper.fetchData(entity: SubTask.self, namePredicate: predicate, completion: {
            (data) in
            guard let data = data else{return}
            if data.count == 0{
                context.perform {
                let newTask = SubTask(context: context)
                    newTask.task = task
                    newTask.date = Utilities.getDate()
                    newTask.parentTask = localParent
                    context.saveContext()
                    completion()
                }
            }else{
                data[0].task = task
            }
//            print(data[0].task)
        })

        
        
    }
}
/*
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
 */
