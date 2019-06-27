//
//  PinBoardCollectionViewController.swift
//  MindValleyMobileTest
//
//  Created by Engineer 144 on 24/06/2019.
//  Copyright © 2019 Engineer 144. All rights reserved.
//

import UIKit




class PinBoardCollectionViewController: UICollectionViewController, PinterestLayoutDelegate{
    
   
    

    
    private var dataSource : PinsCollectionViewDataSource<PinsCollectionViewCell, PinModel>!
    private var pinsViewModel : PinViewModel!
    var refreshControl = UIRefreshControl()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
      
        
        setUpResfreshController()
        configurePinterestLayout()
        pinsViewModel = PinViewModel()
        pinsViewModel.loadPins()
        
        self.pinsViewModel.bindSourceToModels = {
            self.updateDataSource()
        }
        
          pinsViewModel.loadPins()
    }
   
    
    private func configurePinterestLayout(){
        
        
        if let layout = collectionView.collectionViewLayout as? PinterestLayout {
            layout.delegate = self
        }
        collectionView.contentInset = UIEdgeInsets(top: 10, left: 10, bottom: 10, right: 10)
    }
    private func updateDataSource(){
    self.dataSource = PinsCollectionViewDataSource(cellIdentifier: Constants.PinsCollectionViewCell, items: self.pinsViewModel.pins) { cell, pin in
        cell.pinID.text = pin.id
        cell.pinImageView.setImage(url: pin.imageUrl)
    
    }
    
    reloadDataToCollectionView()
    
}
    private func reloadDataToCollectionView(){
    mainThread {
       
        self.collectionView.isHidden = false
        self.collectionView.dataSource = self.dataSource
        self.collectionView.reloadData()
    }
}
    
    
    
    private func performSegueForShowPinDetails(segue :UIStoryboardSegue) {
        
        guard let indexPath = self.collectionView.indexPathsForSelectedItems?.first else {
            fatalError("indexPath not found")
        }
        
        let pinModel = self.pinsViewModel.source(at: indexPath.row)
        let detailView = segue.destination as! PinBoardDetailsViewController
        detailView.pinModel = pinModel
    }
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {

       if segue.identifier == Constants.showPinDetailSegueID {
         performSegueForShowPinDetails(segue: segue)
      }
}
    
    
    
}




//setup Methods for PullRefresh
extension PinBoardCollectionViewController {
    
    func setUpResfreshController(){
        refreshControl = UIRefreshControl()
        refreshControl.addTarget(self, action: #selector(refresh), for: .valueChanged)
        self.collectionView.refreshControl = refreshControl
    }
    
    
    @objc func refresh(sender:AnyObject) {
        
        pinsViewModel.invalideCachedData()
        reloadDataToCollectionView()
        pinsViewModel.loadPins()
        refreshControl.endRefreshing()
    }
}



//PinterestLayout delegates and CollectionViewDelegate override

extension PinBoardCollectionViewController {
    
    func collectionView(_ collectionView: UICollectionView, heightForPhotoAtIndexPath indexPath: IndexPath) -> CGFloat {
        let item = pinsViewModel.pins[indexPath.item]
        return item.height
    }
    
    override func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
        self.performSegue(withIdentifier: "showDetailsSegue", sender: nil)
    }

    
}
