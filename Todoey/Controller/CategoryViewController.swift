//
//  CategoryViewController.swift
//  Todoey
//
//  Created by Ahmed AlSai on 6/3/19.
//  Copyright © 2019 Ahmed AlSai. All rights reserved.
//

import UIKit
import CoreData

class CategoryViewController: UITableViewController {
    
    var categoryList = [Category]()
    let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
    var newName : UITextField?

    override func viewDidLoad() {
        super.viewDidLoad()
        loadCategories()
    }
    
    //MARK: - TableView Datasource Methods
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "CategoryCell", for: indexPath)
        cell.textLabel?.text = categoryList[indexPath.row].name
        cell.accessoryType = .disclosureIndicator
        return cell
    }
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return categoryList.count
    }
    
    //MARK: - Data Manipulation Methods
    func saveCategories(){
        do{
            try context.save()
        }
        catch {
            print("Error saving context: \(error)")
        }
        tableView.reloadData()
    }
    
    func  loadCategories(forRequest request : NSFetchRequest<Category> = Category.fetchRequest()){
        do {
            categoryList = try context.fetch(request)
        }
        catch{
            print("Error fetching context: \(error)")
        }
        tableView.reloadData()
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
            let tempCategory = Category(context: self.context)
            tempCategory.name = newName.text
            self.categoryList.append(tempCategory)
            self.saveCategories()
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
            destinationVC.selectedCategory = categoryList[indexpath.row]
        }
    }
    
    
}
