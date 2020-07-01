//
//  taskListsCell.swift
//  Todo App
//
//  Created by A on 6/30/20.
//  Copyright © 2020 Taha. All rights reserved.
//

import UIKit


protocol configureTaskCell {
    func configureTaskCell(model:[taskModel],index:IndexPath)
}
class taskListsCell: UITableViewCell {

    @IBOutlet weak var taskDetails: UILabel!
    @IBOutlet weak var taskName: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}

extension taskListsCell :configureTaskCell{
    func configureTaskCell(model: [taskModel], index: IndexPath) {
        let task = model[index.row]
        self.taskName.text = task.title
        self.taskDetails.text = task.cnotext
    }
    
    
}
