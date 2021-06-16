//
//  MainController.swift
//  Todo
//
//  Created by Jeyaram on 09/06/21.
//

import UIKit
import CoreData

class MainController: UIViewController {
    @IBOutlet var table : UITableView!
    var tasks = [Task](){
        didSet{
            DispatchQueue.main.async {
                self.table.reloadData()
            }
        }
    }
    let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
    var headerView : Header?
    let mainStoryBoard = UIStoryboard(name: Constants.mainStoryBoard , bundle: nil)
    override func viewDidLoad() {
        super.viewDidLoad()
        registerCell()
//        fetchRequest()
        fetchGeneric()
//        newBackground()
 
        // Do any additional setup after loading the view.
    }
    

    

}
extension MainController : UITableViewDelegate,UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        tasks.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: Constants.cellIdentifier,for: indexPath) as! TaskCell
        cell.configure(task: tasks[indexPath.row])
//        print(tasks[indexPath.row].task)
        return cell
    }
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        headerView = tableView.dequeueReusableHeaderFooterView(withIdentifier: Constants.Xib.header) as? Header
        guard let headerView = headerView else{return UIView()}
        headerView.tintColor = .white
        headerView.tapAdd = {[weak self]
            (data) in
            if let self = self{
                Task.insert(newTask: data,completion: {
                    self.fetchGeneric()
                })
            }
            
        }
        return headerView
    }

    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        UITableView.automaticDimension
    }
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        
        return 100
    }
    func tableView(_ tableView: UITableView, trailingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration? {
        let contextItem = UIContextualAction(style: .destructive, title: "Delete", handler: {[weak self]
            (contextualAction, view, boolValue) in
            guard let self = self else{return}
            let remove = self.tasks[indexPath.row]
            TaskHelper.delete(completedTask: remove)
            self.fetchGeneric()
        })
        return UISwipeActionsConfiguration(actions: [contextItem])
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let newController = self.mainStoryBoard.instantiateViewController(identifier: Constants.subTaskIdentifier) as SubTaskController
//        newController.currentTask = tasks[indexPath.row]
        newController.currentTaskId = tasks[indexPath.row].objectID
        self.pushController(newController, with: tasks[indexPath.row].task!)
    }
  
}

extension MainController{
 
//    func fetchRequest(){
//        Task.fetchAll(completion: {
//            (data) in
//            tasks = data
//        })
//    }
    
    func fetchGeneric(){
        TaskHelper.fetchData(entity: Task.self, completion: {
            (data) in
            if let data = data{
                tasks = data
            }
        })
    }
    func registerCell(){
        table.register(UINib(nibName: Constants.cellIdentifier, bundle: nil), forCellReuseIdentifier: Constants.cellIdentifier)
        
        table.register(UINib(nibName: Constants.Xib.header, bundle: nil), forHeaderFooterViewReuseIdentifier: Constants.Xib.header)
    }
}

struct Constants{
    static let cellIdentifier = "TaskCell"
    static let subTaskIdentifier = "SubTaskController"
    static let mainStoryBoard = "Main"
    struct Xib{
        static let header = "Header"
    }
}

