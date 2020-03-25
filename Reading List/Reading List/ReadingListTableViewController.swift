//
//  ReadingListTableViewController.swift
//  Reading List
//
//  Created by Akmal Nurmatov on 3/24/20.
//  Copyright © 2020 Lambda School. All rights reserved.
//

import UIKit

class ReadingListTableViewController: UITableViewController {

    let bookController = BookController()
    
    override func viewDidLoad() {
        super.viewDidLoad()

    }
    override func viewWillAppear(_ animated: Bool) {
      super.viewWillAppear(animated)
       
      tableView.reloadData()
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "AddNewBookDetail" {
            guard let addBookVC = segue.destination as? BookDetailViewController else {return}
            addBookVC.bookController = bookController
        } else {
            guard let viewBookVC = segue.destination as? BookDetailViewController else {return}
            guard let indexPath = tableView.indexPathForSelectedRow else {return}
            let book = bookFor(indexPath: indexPath)
            viewBookVC.bookController = bookController
            viewBookVC.book = book 
        }
    }

    override func numberOfSections(in tableView: UITableView) -> Int {
        
        return 2
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        if section == 0 { return bookController.readBooks.count }
        else { return bookController.unreadBooks.count }
        
    }

    func bookFor(indexPath: IndexPath) -> Book {
        if indexPath.section == 0 {
            return bookController.readBooks[indexPath.row]
        } else {
            return bookController.unreadBooks[indexPath.row]
        }
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "BookCell", for: indexPath) as! BookTableViewCell
        
        cell.book = bookFor(indexPath: indexPath)
        cell.delegate = self
        
        return cell
    }
    
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
        
        if editingStyle == .delete {
            bookController.deleteBook(book: bookFor(indexPath: indexPath))
            tableView.deleteRows(at: [indexPath], with: .fade)
        }
    }
    
    override func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        if section == 0 {
            return "Read Books"
        } else {
            return "Unread Books"
        }
    }
}

extension ReadingListTableViewController: BookTableViewCellDelegate {
    func toggleHasBeenRead(for cell: BookTableViewCell) {
        guard let indexPath = tableView.indexPath(for: cell) else {return}
        let book = bookFor(indexPath: indexPath)
        
        bookController.updateHasBeenRead(book: book)
        tableView.reloadData()
    }
    
    
}
