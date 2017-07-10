//
//  AddItemTableViewControllerDelegate.swift
//  bucketList_CRUD
//
//  Created by Erick Lui on 7/10/17.
//  Copyright © 2017 Erick Lui. All rights reserved.
//

import Foundation

protocol AddItemTableViewControllerDelegate: class {
  func cancelButtonPressed(by controller: AddItemTableViewController)
  func addItem(by controller: AddItemTableViewController, with text: String, at indexPath: NSIndexPath?)
}
