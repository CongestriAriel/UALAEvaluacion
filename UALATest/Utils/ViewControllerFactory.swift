//
//  ViewControllerFactory.swift
//  UALATest
//
//  Created by Ariel Congestri on 30/09/2019.
//  Copyright © 2019 Ariel Congestri. All rights reserved.
//

import Foundation
import UIKit

enum StoryboardFileNames {
    case bookMain, bookDetail
    
    var identifier: String? {
        switch self {
        case .bookDetail:
            return "BookDetailViewController"
        case .bookMain:
            return "BookListViewController"
        }
    }
    
}

class ViewControllerFactory {
    
    private class func viewControllerFromNib<T: UIViewController>(name identifierName: StoryboardFileNames, type: T.Type) -> T {
        guard let name = identifierName.identifier else { fatalError("No such identifier from \(identifierName)") }
        return T.init(nibName: name, bundle: nil)
    }

    class var bookList: BookListViewController {
        let bookListVC = viewControllerFromNib(name: .bookMain, type: BookListViewController.self)
        let presenter = BookListPresenter()
        presenter.delegate = bookListVC
        bookListVC.presenter = presenter
        presenter.getBooks()
        return bookListVC
    }

    class func bookDetail(object: BookDetailConfiguration) -> BookDetailViewController {
        let bookDetailVC = viewControllerFromNib(name: .bookDetail, type: BookDetailViewController.self)
        bookDetailVC.object = object
        return bookDetailVC
    }
}

