//
//  TaskCell.swift
//  Todo
//
//  Created by Jeyaram on 09/06/21.
//

import UIKit

class TaskCell: UITableViewCell {
    @IBOutlet var task : UILabel!
    @IBOutlet var dateAdded : UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    func configure(task: Task){
//        print(task.date,task.task)
        self.task.text = task.task
        self.dateAdded.text = task.date
    }

    
}
