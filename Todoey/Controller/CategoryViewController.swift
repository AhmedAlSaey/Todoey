//
//  CategoryViewController.swift
//  Todoey
//
//  Created by Ahmed AlSai on 6/3/19.
//  Copyright © 2019 Ahmed AlSai. All rights reserved.
//

import UIKit
import RealmSwift

class CategoryViewController: UITableViewController {
    
    let realm = try! Realm()
    
    var categoryList : Results<Category>?
    var newName : UITextField?

    override func viewDidLoad() {
        super.viewDidLoad()
        loadCategories()
    }
    
    //MARK: - TableView Datasource Methods
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "CategoryCell", for: indexPath)
        cell.textLabel?.text = categoryList?[indexPath.row].name ?? "No Categories added yet"
        cell.accessoryType = .disclosureIndicator
        return cell
    }
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return categoryList?.count ?? 1
    }
    
    //MARK: - Data Manipulation Methods
    func save(category : Category){
        do{
            try realm.write {
                realm.add(category)
            }
        }
        catch {
            print("Error saving context: \(error)")
        }
        tableView.reloadData()
    }
    
    func  loadCategories(){
        categoryList = realm.objects(Category.self)
        tableView.reloadData()
//        do {
//            categoryList = try context.fetch(request)
//        }
//        catch{
//            print("Error fetching context: \(error)")
//        }
//        tableView.reloadData()
    }
    
    
    
    //MARK: - Add New Category
    @IBAction func addButtonPressed(_ sender: UIBarButtonItem) {
        var newName = UITextField()
        let alert = UIAlertController(title: "Add new category", message: "", preferredStyle: .alert)
        alert.addTextField { (categoryNameTextField) in
            categoryNameTextField.placeholder = "Category name"
            newName = categoryNameTextField
        }
        let addAction = UIAlertAction(title: "Add", style: .default) { (UIAlertAction) in
            let tempCategory = Category()
            tempCategory.name = newName.text!
            self.save(category: tempCategory)
        }
        alert.addAction(addAction)
        self.present(alert, animated: true)
    }
    
    //MARK: - TableView Delegate Methods
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        performSegue(withIdentifier: "goToItems", sender: self)
    }
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let destinationVC = segue.destination as! TodoListViewController
        if let indexpath = tableView.indexPathForSelectedRow {
            destinationVC.selectedCategory = categoryList?[indexpath.row]
        }
    }
    
    
}
