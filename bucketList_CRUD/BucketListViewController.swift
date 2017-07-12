//
//  ViewController.swift
//  bucketList_CRUD
//
//  Created by Erick Lui on 7/10/17.
//  Copyright © 2017 Erick Lui. All rights reserved.
//

import UIKit
import CoreData

class BucketListViewController: UITableViewController, AddItemTableViewControllerDelegate {
  
  var list = [BucketListItem]()
  
  // scratch pad for items that will be saved into database
  let manageObjectContext = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
  
  override func viewDidLoad() {
    super.viewDidLoad()
    fetchAllItems()
  }
  override func didReceiveMemoryWarning() {
    super.didReceiveMemoryWarning()
  }
  // func to request to database
  func fetchAllItems() {
    let request = NSFetchRequest<NSFetchRequestResult>(entityName: "BucketListItem")
    do {
      let result = try manageObjectContext.fetch(request)
      list = result as! [BucketListItem]
    } catch {
      print("\(error)")
    }
  }
  
  // how many rows in your table view
  override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    return list.count
  }
  // what each row should display
  override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
    let cell = tableView.dequeueReusableCell(withIdentifier: "ListItemCell", for: indexPath)
    cell.textLabel?.text = list[indexPath.row].text!
    return cell
  }
  // when add button is touched
  @IBAction func addButtonPressed(_ sender: UIBarButtonItem) {
    performSegue(withIdentifier: "updateSegue", sender: nil)
  }
  // when accessory button is touched
  override func tableView(_ tableView: UITableView, accessoryButtonTappedForRowWith indexPath: IndexPath) {
    performSegue(withIdentifier: "updateSegue", sender: indexPath)
  }
  // tell AddItemTableViewController that this is the delegate
  override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
    let navigationController = segue.destination as! UINavigationController
    let addItemTableViewController = navigationController.topViewController as! AddItemTableViewController
    addItemTableViewController.delegate = self
    
    if let ip = sender {
      let indexPath = ip as! NSIndexPath
      let item = list[indexPath.row].text!
      addItemTableViewController.item = item
      addItemTableViewController.indexPath = indexPath
    }
  }
  // when cancel button was pressed by AddItemTableViewController
  func cancelButtonPressed(by controller: AddItemTableViewController) {
    dismiss(animated: true, completion: nil)
  }
  // when save button was pressed by AddItemTableViewController
  func addItem(by controller: AddItemTableViewController, with text: String, at indexPath: NSIndexPath?) {
    if let ip = indexPath {
      list[ip.row].text! = text
    }
    else {
      let item = NSEntityDescription.insertNewObject(forEntityName: "BucketListItem", into: manageObjectContext) as! BucketListItem
      item.text = text
      list.append(item)
    }
    do {
      try manageObjectContext.save()
    } catch {
      print("\(error)")
    }
    tableView.reloadData()
    dismiss(animated: true, completion: nil)
  }
  // create delete button
  override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
    let item = list[indexPath.row]
    manageObjectContext.delete(item)
    do {
      try manageObjectContext.save()
    } catch {
      print("\(error)")
    }
    list.remove(at: indexPath.row)
    tableView.reloadData()
  }
}

