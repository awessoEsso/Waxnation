 //
//  ViewController.swift
//  Waxnation
//
//  Created by Esso AWESSO on 02/12/2017.
//  Copyright © 2017 Esso AWESSO. All rights reserved.
//

import UIKit
import Nuke

class  ItemsViewController: UIViewController {
    
    var items = [Item]()

    @IBOutlet weak var itemsCollectionView: UICollectionView!
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        FirebaseManager.shared.items(with: { (items) in
            self.items = items
            self.itemsCollectionView.reloadData()
        }) { (error) in
            print(error ?? "Error")
        }
        
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let destination = segue.destination
        switch destination {
        case is DetailsViewController:
            if let selectedIdex = itemsCollectionView.indexPathsForSelectedItems?.first?.row {
                let itemSelected = items[selectedIdex] 
                let detailsViewController = destination as! DetailsViewController
                detailsViewController.item = itemSelected
            }
            
        default:
            print("Default")
        }
    }
}


extension ItemsViewController: UICollectionViewDataSource {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return items.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let item = items[indexPath.item]
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "collectionViewItemId", for: indexPath) as! ItemCollectionViewCell
        cell.descriptionLabel.text = item.description ?? "Description"
        cell.priceLabel.text = "\(item.price ?? 0) €"
        cell.coverImage.image = nil
        if let coverImageURL = item.coverImageURL {
            Nuke.loadImage(with: coverImageURL, into: cell.coverImage)
        }
        return cell
    }
}

extension ItemsViewController: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return 10
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: view.frame.width/2 - 5, height: 320)
    }
}


extension ItemsViewController: UICollectionViewDelegate {
    
}
