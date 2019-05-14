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
        loadItems()
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
        self.saveItems()
        tableView.reloadData()
    }
    
    
    //MARK - Add New Items
    @IBAction func addButtonPressed(_ sender: UIBarButtonItem) {
        let alert = UIAlertController(title: "Add new UI item", message: "", preferredStyle: .alert)
        var newItemText = UITextField()
        let action = UIAlertAction(title: "Add item", style: .default) { (UIAlertAction) in
            let newItem = Item(newItemText.text!)
            self.itemArray.append(newItem)
            self.saveItems();
        }
        alert.addTextField { (alertTextField) in
            alertTextField.placeholder = "Create new item"
            newItemText = alertTextField
        }
        alert.addAction(action)
        present(alert, animated: true, completion: nil)
    }
    
    
    func saveItems(){
        let dataFilePath = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first? .appendingPathComponent("Items.plist")
        
        let encoder = PropertyListEncoder()
        
        do{
            let data = try encoder.encode(itemArray)
            try data.write(to: dataFilePath!)
        }
        catch {
            print("Error encoding itemArray, \(error)")
        }
        
        self.tableView.reloadData()
    }
    
    
    func loadItems(){
        let dataFilePath = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first? .appendingPathComponent("Items.plist")
        if let data = try? Data(contentsOf: dataFilePath!) {
            let decoder = PropertyListDecoder()
            do {
                itemArray = try decoder.decode([Item].self, from: data)
            }
            catch {
                print("Error decoding itemsArray, \(error)")
            }
        }
        
    }
    
}

