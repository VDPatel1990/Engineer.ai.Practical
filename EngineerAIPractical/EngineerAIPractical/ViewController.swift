//
//  ViewController.swift
//  EngineerAIPractical
//
//  Created by Vipul on 30/12/19.
//  Copyright © 2019 Vipul. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        self.prepareView()
    }

    private func prepareView() {
        self.getUserList()
    }
    
    //MARK :- Get UserImage List api
    
    private func getUserList() {
        let params = ["offset" : "0", "limit" : "10"]
        APIManger.shared.sendGenericCall(router: .getUserList(param: params), type: UserModel.self, showProgressHud: true, successCompletion: { (response) in
            
        }) { (error) in
            
        }
    }
}

