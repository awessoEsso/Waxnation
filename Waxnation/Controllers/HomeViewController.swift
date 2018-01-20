//
//  HomeViewController.swift
//  Waxnation
//
//  Created by Esso AWESSO on 14/01/2018.
//  Copyright © 2018 Esso AWESSO. All rights reserved.
//

import UIKit

class HomeViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        
        
    }

}

extension HomeViewController: UICollectionViewDelegate {
    
}

extension HomeViewController: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let width:CGFloat = collectionView.frame.width - 16
        let height:CGFloat = 120
        return CGSize(width: width, height: height)
    }
}

extension HomeViewController: UICollectionViewDataSource {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 8
    }
    
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "shopCollectionViewCellId", for: indexPath) as! ShopCollectionViewCell
        cell.imageView.image = #imageLiteral(resourceName: "sosoden")
        
        return cell
    }
}
