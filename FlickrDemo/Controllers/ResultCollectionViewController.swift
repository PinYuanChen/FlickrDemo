//
//  ResultCollectionViewController.swift
//  FlickrDemo
//
//  Created by 陳品元 on 2020/4/13.
//  Copyright © 2020 ChenPinYuan. All rights reserved.
//

import UIKit

private let reuseIdentifier = "ResultCollectionViewCell"

class ResultCollectionViewController: UICollectionViewController {
    
    var keyword:String = ""
    var perPage:String = ""
    var aryItems = [Photo]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = "搜尋結果"
        let layout = self.collectionView.collectionViewLayout as? UICollectionViewFlowLayout
        let width = (self.collectionView.bounds.width - 20) / 2
        layout?.itemSize = CGSize(width: width, height: width + 50)
        loadData(keyword, perPage)
    }

    func loadData(_ keyword:String, _ perPage:String){
        APIManager.shared.fetchData(keyword, perPage) { (aryPhoto) in
            if let aryPhoto = aryPhoto {
                self.aryItems = aryPhoto
                DispatchQueue.main.async {
                    print(self.aryItems)
                    self.collectionView.reloadData()
                }
            }
        }
    }
    // MARK: UICollectionViewDataSource
    
    override func numberOfSections(in collectionView: UICollectionView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }


    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return aryItems.count
    }

    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: reuseIdentifier, for: indexPath) as! ResultCollectionViewCell
        return cell
    }
    
    
    override func collectionView(_ collectionView: UICollectionView, willDisplay cell: UICollectionViewCell, forItemAt indexPath: IndexPath) {
        let rCell:ResultCollectionViewCell = cell as! ResultCollectionViewCell
        let photo = aryItems[indexPath.item]
        rCell.labelTitle.text = photo.title
        rCell.imgView.image = nil
        APIManager.shared.fetchImage(photo.imageUrl) { (img) in
            if let img = img {
                DispatchQueue.main.async {
                    rCell.imgView.backgroundColor = .clear
                    rCell.imgView.image = img
                }
            }
        }
    }
 
}
