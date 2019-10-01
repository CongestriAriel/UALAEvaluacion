//
//  BookService.swift
//  UALATest
//
//  Created by Ariel Congestri on 30/09/2019.
//  Copyright © 2019 Ariel Congestri. All rights reserved.
//

import Foundation
import Alamofire

open class BookService {
    class func getAllBooks(completion: @escaping ([Book], Error?) -> Void) {
        request(RequestBuilder.getBooks).responseJSON { (response) in
            
            guard let data = response.data else { completion([],response.error); return }
            do {
                let decoder = JSONDecoder()
                let books = try decoder.decode([Book].self, from: data)
                completion(books, nil)
            } catch {
                completion([],nil)
            }
        }
    }
}
