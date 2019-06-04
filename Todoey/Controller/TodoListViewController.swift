//
//  ViewController.swift
//  Todoey
//
//  Created by Ahmed AlSai on 4/25/19.
//  Copyright © 2019 Ahmed AlSai. All rights reserved.
//

import UIKit
import CoreData

class TodoListViewController: UITableViewController {
    var itemArray = [Item]()
    let defaults = UserDefaults.standard
    let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
    var selectedCategory : Category? {
        didSet {
            loadItems()
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        print(FileManager.default.urls(for: .documentDirectory, in: .userDomainMask))
        // Do any additional setup after loading the view, typically from a nib.
    }
    
    
    //MARK: - Tableview Datasource Methods
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
    
    
    //MARK: - TableView Delegate Methods
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        print(itemArray[indexPath.row])
        //itemArray[indexPath.row].done = !itemArray[indexPath.row].done
        context.delete(itemArray[indexPath.row])
        itemArray.remove(at: indexPath.row)
        tableView.deselectRow(at: indexPath, animated: true)
        self.saveItems()
    }
    
    
    //MARK: - Add New Items
    @IBAction func addButtonPressed(_ sender: UIBarButtonItem) {
        let alert = UIAlertController(title: "Add new UI item", message: "", preferredStyle: .alert)
        var newItemText = UITextField()
        let action = UIAlertAction(title: "Add item", style: .default) { (UIAlertAction) in
            let newItem = Item(context: self.context)
            newItem.title = newItemText.text!
            newItem.parentCategory = self.selectedCategory
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
        do{
            try context.save()
        }
        catch {
            print("Error saving context, \(error)")
        }
        
        self.tableView.reloadData()
    }
    
    
    func loadItems(with request: NSFetchRequest<Item> = Item.fetchRequest()) {
        var categoryPredicate = NSPredicate(format: "parentCategory.name MATCHES %@", selectedCategory!.name!)
        if let originalpredicate = request.predicate {
            categoryPredicate = NSCompoundPredicate(type: NSCompoundPredicate.LogicalType.and, subpredicates: [originalpredicate, categoryPredicate])
        }
        request.predicate = categoryPredicate
        do{
            itemArray = try context.fetch(request)
            tableView.reloadData()
        }
        catch {
            print("Error fetching data from context \(error)")
        }
    }
    
    
    
}

//MARK: - Search bar methods
extension TodoListViewController: UISearchBarDelegate {
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        let request : NSFetchRequest<Item> = Item.fetchRequest()
        request.predicate = NSPredicate(format: "title CONTAINS[cd] %@", searchBar.text!)
        let ascendDescriptr = NSSortDescriptor(key: "title", ascending: true)
        request.sortDescriptors = [ascendDescriptr]
        
        loadItems(with: request)
        
    }
    func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
        searchBar.resignFirstResponder()
        searchBar.text = ""
        loadItems()
    }
    
    func searchBarTextDidBeginEditing(_ searchBar: UISearchBar) {
        searchBar.showsCancelButton = true
        UIView.animate(withDuration: 0.1) { // not ideal to hardcode the duration
            searchBar.layoutIfNeeded()
        }
    }
    
    func searchBarTextDidEndEditing(_ searchBar: UISearchBar) {
        searchBar.showsCancelButton = false
        UIView.animate(withDuration: 0.1) {
            searchBar.layoutIfNeeded()
        }
    }
    
}

