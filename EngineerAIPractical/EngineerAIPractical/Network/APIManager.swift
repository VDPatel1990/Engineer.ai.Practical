//
//  APIManger.swift
//  EngineerAIPractical
//
//  Created by Vipul on 30/12/19.
//  Copyright © 2019 Vipul. All rights reserved.
//

import Foundation
import Alamofire
import AlamofireJsonToObjects
import SVProgressHUD

let appDelegate = UIApplication.shared.delegate as! AppDelegate

class APIManger {
    
    static let shared:APIManger =  {
        let instance = APIManger()
        return instance
    }()
    
    let session : SessionManager!
    private init() {
        let configuration = URLSessionConfiguration.default
        configuration.httpMaximumConnectionsPerHost = 4
        session = Alamofire.SessionManager.init(configuration: configuration)
    }
}

extension APIManger {
    func sendGenericCall<T:GenericModal>(router:APIRouter,type:T.Type, showProgressHud: Bool = false, successCompletion:@escaping (_ response:T)->Void,failure:@escaping (_ error:Error)->Void)  {
        
        if NetworkReachabilityManager()!.isReachable == false {
            SVProgressHUD.dismiss()
            self.alertMessage(message: "internet is not available")
            return
        }
        
        var path = router.path
        if router.method == .get {
            path = router.getWithParameter()
        }
        
        if showProgressHud {
            SVProgressHUD.show()
        }
        
        session.request(path, method: router.method, parameters: nil, encoding: JSONEncoding.default, headers: nil).responseObject { (response:DataResponse<T>) in
            SVProgressHUD.dismiss()
                if response.result.isSuccess {
                    successCompletion(response.result.value!)
                }else{
                    failure(response.error!)
                }
            }
    }
    
    private func alertMessage(message:String) {
        let alert = UIAlertController(title: "Error", message: message, preferredStyle: UIAlertController.Style.alert)
        alert.addAction(UIAlertAction(title: "OK", style: UIAlertAction.Style.default, handler: nil))
        appDelegate.window?.rootViewController!.present(alert, animated: true, completion: nil)
    }
}

