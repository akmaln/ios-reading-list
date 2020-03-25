//
//  BookDetailViewController.swift
//  Reading List
//
//  Created by Akmal Nurmatov on 3/24/20.
//  Copyright © 2020 Lambda School. All rights reserved.
//

import UIKit

class BookDetailViewController: UIViewController {

    @IBOutlet weak var bookTitleTextField: UITextField!
    @IBOutlet weak var bookDescriptionTextView: UITextView!
    @IBAction func saveButton(_ sender: Any) {
        if book == nil {
            guard let bookDescriptionTextView = bookDescriptionTextView.text, let bookTitleTextField = bookTitleTextField.text else {return}
            bookController?.addBook(title: bookTitleTextField, reasonToRead: bookDescriptionTextView, hasBeenRead: false)
        } else {
            guard let book = book else {return}
            bookController?.updateHasBeenRead(book: book)
        }
        
        navigationController?.popToRootViewController(animated: true)
    }
    
    var bookController: BookController?
    var book: Book?
    
    func updateViews() {
       
        if book == nil {
            self.title = "Add new book:"
        } else {
            self.title = book!.title
        }
        
        guard let book = book else { return }
        
        bookTitleTextField.text = book.title
        bookDescriptionTextView.text = book.reasonToRead
        
        
        
        
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        updateViews() 
        // Do any additional setup after loading the view.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
