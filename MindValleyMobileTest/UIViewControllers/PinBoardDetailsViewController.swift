//
//  PinBoardDetailsViewController.swift
//  MindValleyMobileTest
//
//  Created by Engineer 144 on 24/06/2019.
//  Copyright © 2019 Engineer 144. All rights reserved.
//

import UIKit

class PinBoardDetailsViewController: UIViewController {
    
    @IBOutlet weak var userProfileImage: UIImageView!
    @IBOutlet weak var PinimageView: UIImageView!
    @IBOutlet weak var totalLikesLabel: UILabel!
    @IBOutlet weak var userName: UILabel!
    
    @IBOutlet weak var categoriesCollectionView: UICollectionView!

    
    var pinModel : PinModel!
    private var dataSource : PinsCollectionViewDataSource<CategoryCollectionViewCell, String>!

    override func viewDidLoad() {
        super.viewDidLoad()
        
        if #available(iOS 11.0, *) {
          self.navigationItem.largeTitleDisplayMode = .never
        } else {
            // Fallback on earlier versions
        }

        
        setUpViews()
      
    }
    

    
    func setUpViews(){
        
        self.PinimageView.setImage(url: pinModel.imageUrl)
        self.userName.text = pinModel.userName
        self.userProfileImage.setImage(url: pinModel.userImageUrl)
        self.userProfileImage.rounded()
        self.totalLikesLabel.text = pinModel.likes
        
         dataSource = PinsCollectionViewDataSource(cellIdentifier: Constants.CategoryCollectionViewCell, items: pinModel?.categories ?? []) { cell, category in
            
           cell.titleLabel.text = category
            
         
        }
        
        
        self.categoriesCollectionView.dataSource = self.dataSource
        self.categoriesCollectionView.reloadData()
    }
    
    
    
    

}
