//
//  Navigations.swift
//  Todo App
//
//  Created by A on 7/1/20.
//  Copyright © 2020 Taha. All rights reserved.
//

import UIKit
class Navigations{
    
    var closure : (( _ title:String, _ context:String)->Void)?
    var editedTaskClosure: (( _ title:String, _ context:String)->Void)?
    
    func showAlert(controller:UIViewController){
        let alertController = UIAlertController(title: "Add Todo Item", message: "Enter title and content", preferredStyle: .alert)
        alertController.addTextField(configurationHandler: nil)
        alertController.addTextField(configurationHandler: nil)
        alertController.textFields?[0].placeholder = "Enter your title"
        alertController.textFields?[1].placeholder = "Enter your task details"
        alertController.addAction(UIAlertAction(title: "Confirm", style: .default, handler: { [weak self](_) in
            let titleText = alertController.textFields?[0].text ?? ""
            let contentText = alertController.textFields?[1].text ?? ""
            guard !titleText.isEmpty else{return}
            guard !contentText.isEmpty else{return}
            //                           self?.presenter.getNewTask(connection: self!.database, title: titleText, context: contentText)
            self?.closure?(titleText, contentText)
            
        }))
        
        alertController.addAction(UIAlertAction(title: "Cancel", style: .cancel, handler: nil))
        controller.present(alertController, animated: true, completion: nil)
    }
    
    
     func showEditedTaskAlert(Title:String,context:String,controller:UIViewController){
        let alertController = UIAlertController(title: "Edit Todo Item", message: "Enter title and content", preferredStyle: .alert)
        alertController.addTextField(configurationHandler: nil)
        alertController.addTextField(configurationHandler: nil)
        alertController.textFields?[0].text = Title
        alertController.textFields?[1].text = context
        alertController.addAction(UIAlertAction(title: "Confirm", style: .default, handler: { [weak self](_) in
            let titleText = alertController.textFields?[0].text ?? ""
            let contentText = alertController.textFields?[1].text ?? ""
            guard !titleText.isEmpty else{return}
            guard !contentText.isEmpty else{return}
            //                           self?.presenter.getNewTask(connection: self!.database, title: titleText, context: contentText)
            self?.editedTaskClosure?(titleText,contentText)
            
        }))
        
        alertController.addAction(UIAlertAction(title: "Cancel", style: .cancel, handler: nil))
        controller.present(alertController, animated: true, completion: nil)
    }
}


