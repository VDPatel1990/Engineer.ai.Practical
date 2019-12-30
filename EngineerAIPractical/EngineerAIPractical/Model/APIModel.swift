//
//  APIModel.swift
//  EngineerAIPractical
//
//  Created by Vipul on 30/12/19.
//  Copyright © 2019 Vipul. All rights reserved.
//

import Foundation
import AlamofireJsonToObjects

class GenericModal: EVNetworkingObject {
    var status = ""
    var message = ""
}

class UserModel: GenericModal {
    var data = UserList()
}

class UserList: EVNetworkingObject {
    var users = [Users]()
    var hasMore = false
}

class Users: EVNetworkingObject {
    var name = ""
    var image = ""
    var items = [String]()
}
