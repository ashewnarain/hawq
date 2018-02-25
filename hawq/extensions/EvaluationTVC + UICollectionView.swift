//
//  EvaluationTVC + UICollectionViewDelegate.swift
//  hawq
//
//  Created by Anthony Shewnarain on 2/17/18.
//  Copyright © 2018 Anthony Shewnarain. All rights reserved.
//

import UIKit

extension EvaluationTVC: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return imagePhotos.count
    }
    
    func collectionView(_ collectionView: UICollectionView,
                        cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "evaluationPhotoCell", for: indexPath)
        // remove previous subviews
        for view in cell.subviews {
            view.removeFromSuperview()
        }
        
        //configure the cell
        let imageView = UIImageView(frame: CGRect(x: 0, y:0, width: cell.frame.size.width, height: cell.frame.size.height))
        imageView.contentMode = UIViewContentMode.scaleAspectFit
        print("ImagePhotosCount-\(imagePhotos.count) indexpath=\(indexPath.row)")
        let image = imagePhotos[imagePhotos.count - (indexPath.row + 1)] as UIImage
        imageView.image = image
        imageView.tag = 1
        cell.addSubview(imageView)
        
        return cell
    }
    

}

