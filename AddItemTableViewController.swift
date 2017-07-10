//
//  AddItemTableViewController.swift
//  bucketList_CRUD
//
//  Created by Erick Lui on 7/10/17.
//  Copyright © 2017 Erick Lui. All rights reserved.
//

import UIKit

class AddItemTableViewController: UITableViewController {
  
  var item: String?
  var indexPath: NSIndexPath?
  weak var delegate: AddItemTableViewControllerDelegate?

  @IBOutlet weak var textField: UITextField!
  
  override func viewDidLoad() {
    super.viewDidLoad()
    textField.text = item
  }
  override func didReceiveMemoryWarning() {
    super.didReceiveMemoryWarning()
  }
  @IBAction func cancelButtonPressed(_ sender: UIBarButtonItem) {
    print("cancel pressed")
    delegate?.cancelButtonPressed(by: self)
  }
  
  @IBAction func saveButtonPressed(_ sender: UIBarButtonItem) {
    let text = textField.text!
    delegate?.addItem(by: self, with: text, at: indexPath)
  }
}
