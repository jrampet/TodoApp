//
//  SubTaskController.swift
//  Todo
//
//  Created by Jeyaram on 11/06/21.
//

import UIKit
import CoreData
class SubTaskController: UIViewController {
    @IBOutlet var table: UITableView!
    var subTasks = [SubTask](){
        didSet{
            DispatchQueue.main.async {
                self.table.reloadData()
            }
        }
    }
    var currentTask : Task?
    override func viewDidLoad() {
        super.viewDidLoad()
        table.register(UINib(nibName: Constants.cellIdentifier, bundle: nil), forCellReuseIdentifier: Constants.cellIdentifier)
        
        table.register(UINib(nibName: Constants.Xib.header, bundle: nil), forHeaderFooterViewReuseIdentifier: Constants.Xib.header)
        table.delegate = self
        table.dataSource  = self
        fetchRequest()
        // Do any additional setup after loading the view.
    }

}

extension SubTaskController : UITableViewDelegate,UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        subTasks.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: Constants.cellIdentifier) as! TaskCell
        cell.configure(subTask: subTasks[indexPath.row])
        return cell
    }
    func tableView(_ tableView: UITableView, trailingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration? {
        let contextItem = UIContextualAction(style: .destructive, title: "Delete", handler: {[weak self]
            (contextualAction, view, boolValue) in
            guard let self = self else{return}
            let remove = self.subTasks[indexPath.row]
            TaskHelper.delete(completedTask: remove)
            self.fetchRequest()
        })
        return UISwipeActionsConfiguration(actions: [contextItem])
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        guard let currentTask = currentTask else{return UIView()}
        let headerView:Header = tableView.dequeueReusableHeaderFooterView(withIdentifier: Constants.Xib.header) as! Header
        headerView.tintColor = .white
        headerView.headLabel.text = "Add your Sub Task"
        (subTasks.count == 0) ? (headerView.taskField.placeholder = "Add your first SubTask") : (headerView.taskField.placeholder = "Add your SubTask")
        headerView.tapAdd = {[weak self]
            (data) in
            if let self = self{
                SubTask.insertSubTask(newTask: data, under: currentTask,completion: {
                    self.fetchRequest()
                })
            }
            
        }
        return headerView
    }
   
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 100
    }
}


extension SubTaskController{
 
    func fetchRequest(){
        guard let currentTask = currentTask else{return}
        SubTask.fetchTask(under: currentTask, completion: {
            (data) in
            subTasks = data
        })
    }
  
}
