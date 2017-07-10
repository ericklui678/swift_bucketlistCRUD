//
//  ViewController.swift
//  bucketList_CRUD
//
//  Created by Erick Lui on 7/10/17.
//  Copyright © 2017 Erick Lui. All rights reserved.
//

import UIKit

class BucketListViewController: UITableViewController, AddItemTableViewControllerDelegate {
  
  var list = ["Compete in ping pong", "Win smash tournament", "Get iOS job"]
  
  override func viewDidLoad() {
    super.viewDidLoad()
  }
  override func didReceiveMemoryWarning() {
    super.didReceiveMemoryWarning()
  }
  // how many rows in your table view
  override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    return list.count
  }
  // what each row should display
  override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
    let cell = tableView.dequeueReusableCell(withIdentifier: "ListItemCell", for: indexPath)
    cell.textLabel?.text = list[indexPath.row]
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
      let item = list[indexPath.row]
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
      list[ip.row] = text
    }
    else { list.append(text) }
    tableView.reloadData()
    dismiss(animated: true, completion: nil)
  }
  // create delete button
  override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
    list.remove(at: indexPath.row)
    tableView.reloadData()
  }
}

