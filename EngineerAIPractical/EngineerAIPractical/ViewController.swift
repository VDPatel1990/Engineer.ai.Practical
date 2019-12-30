//
//  ViewController.swift
//  EngineerAIPractical
//
//  Created by Vipul on 30/12/19.
//  Copyright © 2019 Vipul. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    @IBOutlet private weak var collectionImage : UICollectionView!
    
    private var arrayUsers = [Users]()
    private var hasMore = false
    private var offset = 0
    

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        self.prepareView()
    }

    private func prepareView() {
        self.title = "User List"
        self.getUserList()
    }
    
    //MARK :- Get UserImage List api
    
    private func getUserList() {
        let params = ["offset" : "0", "limit" : "10"]
        APIManger.shared.sendGenericCall(router: .getUserList(param: params), type: UserModel.self, showProgressHud: true, successCompletion: { (response) in
            self.hasMore = response.data.hasMore
            if self.offset == 0 {
                self.arrayUsers = response.data.users
            }else{
                self.arrayUsers.append(contentsOf: response.data.users)
            }
            self.collectionImage.reloadData()
            
        }) { (error) in
            
        }
    }
}

extension ViewController : UICollectionViewDataSource, UICollectionViewDelegate {
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return arrayUsers.count
    }
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return arrayUsers[section].items.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "CollectionCell", for: indexPath) as! CollectionCell
        cell.setImage = arrayUsers[indexPath.section].items[indexPath.item]
        return cell
    }
}

extension ViewController : UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        if self.arrayUsers[indexPath.section].items.count % 2 == 0 {
            return CGSize(width: self.collectionImage.frame.width/2 - 5, height: self.collectionImage.frame.width/2 - 5)
        }else{
            if indexPath.item == 0 {
                return CGSize(width: self.collectionImage.frame.width - 5, height: self.collectionImage.frame.width - 5)
            }else{
                return CGSize(width: self.collectionImage.frame.width/2 - 5, height: self.collectionImage.frame.width/2 - 5)
            }
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return UIEdgeInsets.zero
    }
}

