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
    
    var itemArray = [Item]()
    
    let dataFilePath = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first?.appendingPathExtension("Items.plist")
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        navigationController?.navigationBar.prefersLargeTitles = true
        
        print(dataFilePath)
        
        loadItems()
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
        
        let item = itemArray[indexPath.row]
        cellConfig.text = item.title
        
        // Ternary operator
        // value = condition ? valueIfTrue : valueIfFalse
        
        // cell.accessoryType = item.done == true ? .checkmark : .none
        
        // OR
        
        cell.accessoryType = item.done ? .checkmark : .none
        
        cell.contentConfiguration = cellConfig
        
        return cell
    }
    
    //MARK:- Tableview Delegate Methods
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        itemArray[indexPath.row].done = !itemArray[indexPath.row].done
        
        saveItems()
        
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
                    
                    let newItem = Item()
                    newItem.title = safeText
                    itemArray.append(newItem)
                    
                    saveItems()
                    
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
    
    //MARK:- Model Manipulation Methods
    
    func saveItems() {
        
        let encoder = PropertyListEncoder()
        
        do {
            let data = try encoder.encode(itemArray)
            try data.write(to: dataFilePath!)
        } catch {
            print("Error encoding item array, \(error)")
        }
        
        tableView.reloadData()
    }
    
    func loadItems() {
        
        if let data = try? Data(contentsOf: dataFilePath!) {
            let decoder = PropertyListDecoder()
            
            do {
                itemArray = try decoder.decode([Item].self, from: data)
            } catch {
                print("Error decoding item array, \(error)")
            }
        }
    }
    
}
