//
//  Functions.swift
//  Todo
//
//  Created by Jeyaram on 11/06/21.
//

import UIKit
import CoreData
extension UIViewController{
    func pushController(_ newController: UIViewController,with title:String){
        newController.title = title
        guard let controller = self.navigationController else { return }
        controller.pushViewController(newController, animated: true)
    }
}

struct Core{
    static let container = (UIApplication.shared.delegate as! AppDelegate).persistentContainer
    static let viewcontext = container.viewContext
    static let backgroundContext = container.newBackgroundContext()
}
struct Utilities{
    static func getDate()->String{
        let date = NSDate()
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "dd/MM/yyyy hh:mm:ss:a"
        let dateString = dateFormatter.string(from: date as Date)
        return dateString
    }
}
