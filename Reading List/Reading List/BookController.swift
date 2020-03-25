//
//  BookController.swift
//  Reading List
//
//  Created by Akmal Nurmatov on 3/24/20.
//  Copyright © 2020 Lambda School. All rights reserved.
//

import Foundation

class BookController {
    var books: [Book] = []
    
    init() {
        loadFromPersistentStore()
    }
    
    func addBook(title:String,reasonToRead:String,hasBeenRead:Bool) {
        let book = Book(title: title, reasonToRead: reasonToRead, hasBeenRead: hasBeenRead)
        books.append(book)
        saveToPersistentStore()
    }
    
    func deleteBook(book: Book) {
        guard let index = books.firstIndex(of: book) else { return }
        books.remove(at: index)
        
    }
    
    func updateHasBeenRead(book: Book) {
        guard let index = books.firstIndex(of: book) else { return }
        books[index].hasBeenRead = !books[index].hasBeenRead
        
    }
    
    func updateBook(book: Book, title: String, reasonToRead: String) {
        guard let index = books.firstIndex(of: book) else { return }
        var scratch = book
        
        scratch.title = title
        scratch.reasonToRead = reasonToRead
        
        books.remove(at: index)
        books.append(scratch)
    }
    
    var readBooks: [Book] {
        return books.filter({ $0.hasBeenRead == true })
    }
    
    var unreadBooks: [Book] {
        return books.filter({ $0.hasBeenRead == false })
    }
    
    
    var readingListURL: URL? {
        let fileManager = FileManager.default
        
        let documentDir = fileManager.urls(for: .documentDirectory, in: .userDomainMask).first
        
        let booksURL = documentDir?.appendingPathComponent("Books.plist")
        
        return booksURL
    }
    
    func saveToPersistentStore() {
        do {
            let encoder = PropertyListEncoder()
            
            let booksData = try encoder.encode(books)
            
            guard let readingListURL = readingListURL else { return }
            
            try booksData.write(to: readingListURL)
            
        } catch {
            print("Error saving stars: \(error)")
        }
    }
    
    func loadFromPersistentStore() {
        do {
            guard let readingListURL = readingListURL else { return }
            
            let decoder = PropertyListDecoder()
            
            let booksPlist = try Data(contentsOf: readingListURL)
            
            let books = try decoder.decode([Book].self, from: booksPlist)
            
            self.books = books
            
        } catch {
            print("Error decoding our books: \(error)")
        }
    }
    
    
    
}
