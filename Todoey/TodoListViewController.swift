//
//  ViewController.swift
//  Todoey
//
//  Created by Ahmed AlSai on 4/25/19.
//  Copyright © 2019 Ahmed AlSai. All rights reserved.
//

import UIKit

class TodoListViewController: UITableViewController {
    var itemArray = ["Buy egg", "buy milk", "Buy cheese"];
    let defaults = UserDefaults.standard
    override func viewDidLoad() {
        super.viewDidLoad()
        if let item = defaults.array(forKey: "TodoListArray") as? [String] {
            itemArray = item
        }
        // Do any additional setup after loading the view, typically from a nib.
    }
    //MARK - Tableview Datasource Methods
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "ToDoItem", for: indexPath)
        cell.textLabel?.text = itemArray[indexPath.row]
        return cell
    }
    
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return itemArray.count
    }
    
    //MARK - TableView Delegate Methods
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        print(itemArray[indexPath.row])
        tableView.cellForRow(at: indexPath)?.accessoryType = tableView.cellForRow(at: indexPath)?.accessoryType == .checkmark ? .none : .checkmark
        tableView.deselectRow(at: indexPath, animated: true)
        
    }
    //MARK - Add New Items
    @IBAction func addButtonPressed(_ sender: UIBarButtonItem) {
        let alert = UIAlertController(title: "Add new UI item", message: "", preferredStyle: .alert)
        var newItemText = UITextField()
        let action = UIAlertAction(title: "Add item", style: .default) { (UIAlertAction) in
            self.itemArray.append(newItemText.text!)
            self.defaults.set(self.itemArray, forKey: "TodoListArray");
            self.tableView.reloadData()
        }
        alert.addTextField { (alertTextField) in
            alertTextField.placeholder = "Create new item"
            newItemText = alertTextField
        }
        alert.addAction(action)
        present(alert, animated: true, completion: nil)
    }
    
}

