//
//  Header.swift
//  Todo
//
//  Created by Jeyaram on 09/06/21.
//

import UIKit

class Header: UITableViewHeaderFooterView {

    @IBOutlet weak var taskField : UITextField!
    @IBOutlet var addImage  : UIImageView!
    @IBOutlet var headLabel : UILabel!
    var tapAdd:((_ newTask: String)->())?
        override func awakeFromNib() {
            super.awakeFromNib()
            taskField.placeholder = "Whats your next task?.."
            let tapRecognizer = UITapGestureRecognizer(target: self, action: #selector(tapIcon(sender:)))
            addImage.isUserInteractionEnabled = true
            addImage.addGestureRecognizer(tapRecognizer)
        }
    @objc func tapIcon(sender: UITapGestureRecognizer){
        guard let newTask = taskField.text else{return}
        tapAdd?(newTask)
    }
        override init(reuseIdentifier: String?) {
            super.init(reuseIdentifier: reuseIdentifier)
        }

        required init?(coder: NSCoder) {
            super.init(coder: coder)
        }

}
