

import Foundation
import Alamofire

protocol Router {
    var path: String { get }
    var method: HTTPMethod { get }
    var parameter: [String:String] { get }
}

enum APIRouter {
    case getUserList(param: [String : String])
}

extension APIRouter : Router {
    var method: HTTPMethod {
        switch self {
        case .getUserList:
            return .get
        }
    }
    var path: String {
        switch self {
        case .getUserList :
            return Environment.basePath + "users"
        }
    }
    var parameter: [String : String] {
        switch self {
        case .getUserList(let param):
            return param
        }
    }
}

extension APIRouter {
    func getWithParameter() -> String {
        switch self {
        case .getUserList(let param):
            var url = URLComponents(string: self.path)!
            let queryItems = param.reduce(into: [URLQueryItem]()) { (result, kvPair) in
                result.append(URLQueryItem(name: kvPair.key, value: kvPair.value))
            }
            url.queryItems = queryItems
            return try! (url.asURL().absoluteString)
        }
    }
}
