//
//  ViewController.swift
//  Todo App
//
//  Created by A on 6/30/20.
//  Copyright © 2020 Taha. All rights reserved.
//

import UIKit
import SQLite

protocol taskListView :class{
    
    
    func reloadTaskTableView() -> Void
    
    func creatTableSqlite() -> Void
    func setDafaultsSqlite() -> Void
    
    func getTasksFromDB() -> Void
}


class tasksViewController: UIViewController {
    
    @IBOutlet weak var taskTableView:UITableView!
    let navigationInstance = Navigations()
    var presenter : TaskListPresenter!
    var database: Connection!
    let usersTable = Table("Tasks")
    let titles = Expression<String>("title")
    let context = Expression<String>("context")
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        setDafaultsSqlite()
        creatTableSqlite()
       
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
         getTasksFromDB()
    }
    @IBAction func addNewTask(_ sender: Any) {
        showTaskAlert()
        
    }
    
    func  showTaskAlert(){
        
        navigationInstance.showAlert(controller: self)
        navigationInstance.closure = { [weak self] (title,context) in
            self?.presenter.getNewTask(connection: self!.database, title: title, context: context)
        }
        
    }
    
    
    
}

extension tasksViewController: UITableViewDelegate,UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return presenter.getNumberCell(section: section)
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "taskListsCell", for: indexPath)as! taskListsCell
        presenter.configureCell(cell: cell, index: indexPath)
        return cell
    }
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            print("Deleted")
            
            let Task = presenter.getTaskForSpecificCell(index: indexPath)
            presenter.deleteTask(index: indexPath,database:self.database, TaskModel: Task)
        }
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        let Task = presenter.getTaskForSpecificCell(index: indexPath)
        presenter.didSelectAtRow(controller:self,taskModel: Task)
    }
    
}

extension tasksViewController :taskListView{
    func getTasksFromDB() {
        presenter.getObjectsFromDataBase(database: self.database)
        
    }
    
    func creatTableSqlite() {
        let createTable = self.usersTable.create { (table) in
            table.column(self.titles)
            table.column(self.context)
            
        }
        
        do {
            try self.database.run(createTable)
            print("Created Table")
        } catch {
            print(error)
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
    
    func reloadTaskTableView() {
        print("hi")
        self.taskTableView.reloadData()
    }
    
}
