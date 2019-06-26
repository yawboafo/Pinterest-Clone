//
//  PinsCollectionViewDataSource.swift
//  MindValleyMobileTest
//
//  Created by Engineer 144 on 22/06/2019.
//  Copyright © 2019 Engineer 144. All rights reserved.
//

import Foundation
import Foundation
import UIKit

class PinsCollectionViewDataSource<Cell :UICollectionViewCell,model> : NSObject, UICollectionViewDataSource {
    
    
    
    private var cellIdentifier :String!
    private var items :[model]!
    var configureCell :(Cell,model) -> ()
    
    init(cellIdentifier :String, items :[model], configureCell: @escaping (Cell,model) -> ()) {
        
        self.cellIdentifier = cellIdentifier
        self.items = items
        self.configureCell = configureCell
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return self.items.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: self.cellIdentifier, for: indexPath) as! Cell
        cell.layer.cornerRadius = 4
        let borderColor: CGColor! =  UIColor(hue: 0/360, saturation: 0/100, brightness: 90/100, alpha: 1.0).cgColor //
        
        
        
        cell.layer.borderColor = borderColor
        let item = self.items[indexPath.row]
        self.configureCell(cell,item)
        return cell
    }
    
    
   
    
}
