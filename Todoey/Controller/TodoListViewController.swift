//
//  ViewController.swift
//  Todoey
//
//  Created by Ahmed AlSai on 4/25/19.
//  Copyright © 2019 Ahmed AlSai. All rights reserved.
//

import UIKit

class TodoListViewController: UITableViewController {
    var itemArray = [Item]()
    let defaults = UserDefaults.standard
    override func viewDidLoad() {
        super.viewDidLoad()
        let newItem = Item("Buy Milk");
        itemArray.append(newItem);
        
        let newItem2 = Item("Buy eggs");
        itemArray.append(newItem2);
        
        let newItem3 = Item("Buy rice");
        itemArray.append(newItem3);
        
        let newItem4 = Item("Buy pasta");
        itemArray.append(newItem4);
        
        if let items = defaults.array(forKey: "TodoListArray") as? [Item]{
            itemArray = items
        }
        // Do any additional setup after loading the view, typically from a nib.
    }
    //MARK - Tableview Datasource Methods
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "ToDoItem", for: indexPath)
        let item = itemArray[indexPath.row]
        cell.textLabel?.text = item.title
        cell.accessoryType = item.done ? .checkmark : .none
        return cell
    }
    
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return itemArray.count
    }
    
    //MARK - TableView Delegate Methods
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        print(itemArray[indexPath.row])
        itemArray[indexPath.row].done = !itemArray[indexPath.row].done
        tableView.deselectRow(at: indexPath, animated: true)
        tableView.reloadData()
    }
    //MARK - Add New Items
    @IBAction func addButtonPressed(_ sender: UIBarButtonItem) {
        let alert = UIAlertController(title: "Add new UI item", message: "", preferredStyle: .alert)
        var newItemText = UITextField()
        let action = UIAlertAction(title: "Add item", style: .default) { (UIAlertAction) in
            let newItem = Item(newItemText.text!)
            self.itemArray.append(newItem)
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

