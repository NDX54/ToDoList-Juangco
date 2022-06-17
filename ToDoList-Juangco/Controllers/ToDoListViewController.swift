//
//  ViewController.swift
//  ToDoList-Juangco
//
//  Created by Jared Juangco on 17/6/22.
//

//
//  ViewController.swift
//  ToDoList-Juangco
//
//  Created by Jared Juangco on 17/6/22.
//

import UIKit

class ToDoListViewController: UITableViewController {
    
    var itemArray = ["Find Me Mym", "My dog stepped on a bee", "OBJECTION HEARSAY"]
    
    let defaults = UserDefaults.standard

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        navigationController?.navigationBar.prefersLargeTitles = true
        
    }
    
    //MARK:- Tableview Datasource Methods
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return itemArray.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: K.toDoItemCellRI, for: indexPath)
        var cellConfig = cell.defaultContentConfiguration()
        
        cellConfig.text = itemArray[indexPath.row]
        
        cell.contentConfiguration = cellConfig
        
        return cell
    }
    
    //MARK:- Tableview Delegate Methods
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        // print("Index path: \(indexPath.row), Item name: \(itemArray[indexPath.row])")
        
        if tableView.cellForRow(at: indexPath)?.accessoryType == .checkmark {
            tableView.cellForRow(at: indexPath)?.accessoryType = .none
        } else {
            tableView.cellForRow(at: indexPath)?.accessoryType = .checkmark
        }
        
        tableView.deselectRow(at: indexPath, animated: true)
        
    }

    //MARK:- Add New Items
    
    
    @IBAction func addButtonPressed(_ sender: UIBarButtonItem) {
        
        var textField = UITextField()
        
        let alert = UIAlertController(title: "Add new Todo Item", message: "", preferredStyle: .alert)
        
        let action = UIAlertAction(title: "Add Item", style: .default) { [self] (action) in
            // What will happen when the user clicks the Add Item button on our UIAlert
            if let safeText = textField.text {
                if safeText.isEmpty {
                    
                    let emptyTextAlert = UIAlertController(title: "Error", message: "Field cannot be left blank", preferredStyle: .alert)
                    
                    let emptyTextOkAction = UIAlertAction(title: "OK", style: .default) { emptyTextAction1 in
                        self.present(alert, animated: true)
                    }
                    
                    let emptyTextCancelAction = UIAlertAction(title: "Cancel", style: .cancel)
                    
                    emptyTextAlert.addAction(emptyTextOkAction)
                    emptyTextAlert.addAction(emptyTextCancelAction)
                    present(emptyTextAlert, animated: true)
                    
                } else {
                    
                    print(safeText)
                    itemArray.append(safeText)
                    defaults.set(itemArray, forKey: "TodoListArray")
                    tableView.reloadData()
                    
                }
            }
        }
        
        let cancelAction = UIAlertAction(title: "Cancel", style: .cancel)
        
        alert.addTextField { alertTextField in
            alertTextField.placeholder = "Create new item"
            textField = alertTextField
        }
        
        alert.addAction(action)
        alert.addAction(cancelAction)
        present(alert, animated: true)
    }
    
}
