//
//  TaskHelper.swift
//  Todo
//
//  Created by Jeyaram on 10/06/21.
//

import UIKit
import CoreData
class TaskHelper : Task{
    static let container = (UIApplication.shared.delegate as! AppDelegate).persistentContainer
   
    static func insert(newTask task:String,completion:@escaping()->()){
//        let context = container.viewContext
        let context = container.newBackgroundContext()
        /*let newTask = Task(context: context)
        newTask.task = task
        newTask.date = getDate()
        save()
        completion()*/
        context.performAndWait {
            
            let newTask = Task(context: context)
            newTask.task = task
            newTask.date = getDate()
            context.saveContext()
            completion()
        }
    }
    
    static func delete(completedTask:Task){
        let context = container.viewContext
        context.delete(completedTask)
        context.saveContext()
    }
    static func fetchAll(completion:([Task])->()){
        let context = container.viewContext
        do{
            let task :[Task] = try context.fetch(Task.fetchRequest())
            completion(task)
        }catch{
            print("Error in Fetch")
        }
    }
    static func getDate()->String{
        let date = NSDate()
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "dd/MM/yyyy hh:mm:ss:a"
        let dateString = dateFormatter.string(from: date as Date)
        return dateString
    }
}
extension NSManagedObjectContext{
    func saveContext(){
        do{
            try self.save()
        }catch{
            print("Error in saving")
        }
    }
    
    func remove(_ element:NSManagedObject){
        self.delete(element)
        saveContext()
    }
    

}

