//
//  DetailsViewController.swift
//  Waxnation
//
//  Created by Esso AWESSO on 03/12/2017.
//  Copyright © 2017 Esso AWESSO. All rights reserved.
//

import UIKit
import Nuke

class DetailsViewController: UIViewController {
    
    var item: Item!
    
    var photos = [URL]()
    
    @IBOutlet weak var imagesCollectionView: UICollectionView!
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
        
        guard let photosURL =  item.photos else { return }
        
        for photoURL in photosURL {
            if let url = photoURL {
                photos.append(url)
            }
        }
        imagesCollectionView.reloadData()
        
    }
    @IBAction func backAction(_ sender: Any) {
        navigationController?.popViewController(animated: true)
    }
    
    
    @IBAction func shareAction(_ sender: Any) {
        
        let firstActivityItem = item.description ?? ""
        var secondActivityItem : NSURL = NSURL(string: "https://shdh6.app.goo.gl")!
        DynamicLinkManager.generateInvitationDynamicLinkFor(item: item.identifier, success: { (shortURL) in
            if let shortURL = shortURL {
                secondActivityItem = NSURL(string: shortURL)!
                
                let activityViewController : UIActivityViewController = UIActivityViewController(
                    activityItems: [firstActivityItem, secondActivityItem], applicationActivities: nil)
                
                self.present(activityViewController, animated: true, completion: nil)
            }
            
        }) { (error) in
            print(error, "Error")
        }
        
        
    }
    
    func openShareView() {
        
    }
    
}

extension DetailsViewController: UICollectionViewDataSource {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return photos.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let photoURL = photos[indexPath.row]
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "detailsCellId", for: indexPath) as! DetailsCollectionViewCell
        cell.imageView.image = nil
        Nuke.loadImage(with: photoURL, into: cell.imageView)
        return cell
    }
    
}

extension DetailsViewController: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: view.frame.width, height: imagesCollectionView.frame.height)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return 0
    }
}

extension DetailsViewController: UICollectionViewDelegate {
    
}
