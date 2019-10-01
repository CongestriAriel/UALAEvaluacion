//
//  BookListPresenter.swift
//  UALATest
//
//  Created by Ariel Congestri on 30/09/2019.
//  Copyright © 2019 Ariel Congestri. All rights reserved.
//

import Foundation
import UIKit
import Alamofire

class BookListPresenter {
    
    var books: [Book] = []
    var isAsendingOrder: Bool = true
    var isListView: Bool = true {
        didSet{
            delegate?.dataSourceWasUpdated()
        }
    }
    var filteringLogic = 0 {
        didSet {
            filterBooks()
        }
    }
    var filteredBooks: [Book] = []
    weak var delegate: PresenterDelgate?

    func getBooks() {
        BookService.getAllBooks { [weak self] (books, error)  in
            guard let self = self else { return }
            self.books = books
            self.filteredBooks = books
            self.sortArray(asending: self.isAsendingOrder)
            
        }
    }

    var itemsForSection: Int {
        return filteredBooks.count
    }

    func filterBooks() {
        switch filteringLogic {
        case 0:
            filteredBooks = books
        case 1:
            filteredBooks = books.filter({ (book) -> Bool in
                return book.isAvailable ?? true
            })
        case 2:
            filteredBooks = books.filter({ (book) -> Bool in
                return !(book.isAvailable ?? true)
            })
        default:
            return
        }
        delegate?.dataSourceWasUpdated()
    }

    func sizeForItemAt(IndexPath indexPath: IndexPath) -> CGSize {
        var width = UIScreen.main.bounds.width
        if !isListView {
            width = ( UIScreen.main.bounds.width - 10 )/2
        }
        return CGSize(width: width, height: 145)
    }

    func itemFor(IndexPath indexPath: IndexPath) -> BookListConfigutarion {
        return BookListConfigutarion(name: filteredBooks[indexPath.row].name, author: filteredBooks[indexPath.row].author, isAvailable: filteredBooks[indexPath.row].isAvailable, popularityIndex: filteredBooks[indexPath.row].popularityIndex, image: filteredBooks[indexPath.row].imageURL)
    }

    func sortArray(asending: Bool = true) {
        filterBooks()
        if asending {
            books = books.sorted(by: { $0.popularityIndex! > $1.popularityIndex! })
            filteredBooks = books
        } else {
            books = books.sorted(by: { $0.popularityIndex! < $1.popularityIndex! })
            filteredBooks = books
        }
        filterBooks()
        self.delegate?.dataSourceWasUpdated()
    }

    func itemForDetailAt(IndexPath indexPath: IndexPath) -> BookDetailConfiguration {
        return BookDetailConfiguration(id: filteredBooks[indexPath.row].id, name: filteredBooks[indexPath.row].name, author: filteredBooks[indexPath.row].author, isAvailable: filteredBooks[indexPath.row].isAvailable, popularityIndex: filteredBooks[indexPath.row].popularityIndex, imageURL: filteredBooks[indexPath.row].imageURL)
    }
}
