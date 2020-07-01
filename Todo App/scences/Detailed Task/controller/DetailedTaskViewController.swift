//
//  DetailedTaskViewController.swift
//  Todo App
//
//  Created by A on 7/1/20.
//  Copyright © 2020 Taha. All rights reserved.
//

import UIKit
import SQLite
protocol getDetailedTask :class{
    func getDetailedTask(Model:taskModel)->Void
//    func creatTableSqlite() -> Void
//    func setDafaultsSqlite() -> Void
    func setNewEditedTask(model:taskModel)-> Void
}

class DetailedTaskViewController: UIViewController {

    @IBOutlet weak var detailedTitleTask : UILabel!
    
    @IBOutlet weak var detailedContextTask : UILabel!
    
    var presenter : detailedTaskPresentation?
    
    let navigationInstance = Navigations()
    var Task : taskModel?
    var database: Connection!

    
    override func viewDidLoad() {
        super.viewDidLoad()
        setDafaultsSqlite()

    }
    
    @IBAction func editDetailedTask(_ sender: Any) {
        
        showAlert()
    }
    
    
    @IBAction func detleteDetailedTask(_ sender: Any) {
        deleteTask()
    }
    
    func deleteTask(){
        
        presenter?.deleteTask(connection: self.database, TaskModel: Task!)
    }

    func showAlert(){
        guard let Title = Task?.title else { return  }
        guard let context = Task?.cnotext else { return  }
        navigationInstance.showEditedTaskAlert(Title: Title, context: context, controller: self)
        navigationInstance.editedTaskClosure =  {[weak self] (title,context)  in
//             print("titless",title,context)
            self?.presenter?.editTask(dataBase:self!.database, Title: title, context: context)
            
        }
        
    }
    func setData(model:taskModel){
        self.detailedTitleTask.text = model.title
        self.detailedContextTask.text = model.cnotext
    }
}

extension DetailedTaskViewController:getDetailedTask{
    func setNewEditedTask(model:taskModel) {
        DispatchQueue.main.async {
            self.Task = model
            self.setData(model: model)
        }
    }
    

    func setDafaultsSqlite() {
        do {

            let documentDirectory = try FileManager.default.url(for: .documentDirectory, in: .userDomainMask, appropriateFor: nil, create: true)
            let fileUrl = documentDirectory.appendingPathComponent("Tasks").appendingPathExtension("sqlite3")
            let database = try Connection(fileUrl.path)
            self.database = database
        } catch {
            print(error)
        }
    }
    
    
    func getDetailedTask(Model: taskModel) {
        //
        DispatchQueue.main.async {
            self.Task = Model
            self.setData(model: Model)
        }
    }
    
    
}
