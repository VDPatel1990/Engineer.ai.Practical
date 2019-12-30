//
//  ViewController.swift
//  EngineerAIPractical
//
//  Created by Vipul on 30/12/19.
//  Copyright © 2019 Vipul. All rights reserved.
//

import UIKit
import UIScrollView_InfiniteScroll

final class ViewController: UIViewController {
    
    //MARK:- Outlets
    @IBOutlet private weak var collectionImage : UICollectionView!
    
    //MARK:- Variabels
    private var arrayUsers = [Users]()
    private var hasMore = false
    private var offset = 0
    
    //MARK:- View Life Cycles
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        self.prepareView()
    }

    private func prepareView() {
        self.title = "User List"
        self.collectionImage.register(UINib(nibName: "CollectionHeaderView", bundle: nil), forSupplementaryViewOfKind: UICollectionView.elementKindSectionHeader, withReuseIdentifier: "CollectionHeaderView")
        self.collectionImage.addInfiniteScroll { (collectionView) in
            if self.hasMore {
                self.offset += 10
                self.getUserList()
            }else{
                collectionView.finishInfiniteScroll()
            }
        }
        self.getUserList()
    }
    
    //MARK:- Get UserImage List api
    private func getUserList() {
        let params = ["offset" : "\(self.offset)", "limit" : "10"]
        APIManger.shared.sendGenericCall(router: .getUserList(param: params), type: UserModel.self, showProgressHud: self.offset == 0 ? true : false, successCompletion: { (response) in
            self.hasMore = response.data.hasMore
            self.collectionImage.finishInfiniteScroll()
            if self.offset == 0 {
                self.arrayUsers = response.data.users
            }else{
                self.arrayUsers.append(contentsOf: response.data.users)
            }
            if !self.hasMore {
                self.collectionImage.removeInfiniteScroll()
            }
            self.collectionImage.reloadData()
        }) { (error) in
            print("Error found : \(error)")
        }
    }
}

//MARK:- UICollectionView Delegate and DataSource
extension ViewController : UICollectionViewDataSource, UICollectionViewDelegate {
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return arrayUsers.count
    }
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return arrayUsers[section].items.count
    }
    func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        switch kind {
        case UICollectionView.elementKindSectionHeader:
            let headerView = collectionView.dequeueReusableSupplementaryView(ofKind: kind, withReuseIdentifier: "CollectionHeaderView", for: indexPath as IndexPath) as! CollectionHeaderView
            headerView.backgroundColor = UIColor.clear;
            headerView.user = self.arrayUsers[indexPath.section]
            return headerView
        default:
            assert(false, "Unexpected element kind")
        }
    }
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "CollectionCell", for: indexPath) as! CollectionCell
        cell.setImage = arrayUsers[indexPath.section].items[indexPath.item]
        return cell
    }
}

//MARK:- UICollectionView FlowLayout
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

