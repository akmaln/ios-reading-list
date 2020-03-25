//
//  BookTableTableViewCell.swift
//  Reading List
//
//  Created by Akmal Nurmatov on 3/24/20.
//  Copyright © 2020 Lambda School. All rights reserved.
//

import UIKit


class BookTableViewCell: UITableViewCell {
    
    @IBOutlet weak var bookLabel: UILabel!
    @IBOutlet weak var readUnreadButton: UIButton!
    
    var book: Book? {
    didSet{
    updateViews()
    }
    }
    var delegate: BookTableViewCellDelegate?
    
    
    @IBAction func checkUncheckButton(_ sender: Any) {
        
        book!.hasBeenRead = !book!.hasBeenRead
        delegate?.toggleHasBeenRead(for: self) 
    }
   
    func updateViews() {
        guard let book = book else { return }
        
        bookLabel.text = book.title
        
    }
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
