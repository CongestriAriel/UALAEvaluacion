//
//  RequestBuilder.swift
//  UALATest
//
//  Created by Ariel Congestri on 30/09/2019.
//  Copyright © 2019 Ariel Congestri. All rights reserved.
//

import Foundation
import Alamofire

enum RequestBuilder: URLRequestConvertible {
    case getBooks

    var path: String {
        switch self {
        case .getBooks:
            return "books"
        }
    }

    var parameters: [String : Any]? {
        switch self {
        case .getBooks:
            return nil
        default:
            return nil
        }
    }

    func asURLRequest() throws -> URLRequest {
        let urlString = APIRouter.baseURL
        let url = try urlString.asURL()
        
        var request = URLRequest(url: url.appendingPathComponent(path))
        
        request.httpMethod = HTTPMethod.get.rawValue
        return try URLEncoding.default.encode(request, with: parameters)
    }
}
