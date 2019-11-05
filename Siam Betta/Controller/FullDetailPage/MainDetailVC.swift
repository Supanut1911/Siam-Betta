//
//  MainDetailVC.swift
//  Siam Betta
//
//  Created by Supanut Laddayam on 4/11/2562 BE.
//  Copyright © 2562 Supanut Laddayam. All rights reserved.
//

import UIKit

class MainDetailVC: UIViewController {
    
    
    //var
    var categories = [Category]()
    

    @IBOutlet weak var collectionView: UICollectionView!
    @IBOutlet weak var activityIndicator: UIActivityIndicatorView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        collectionView.delegate = self
        collectionView.dataSource = self
        
        let category = Category.init(name: "halfmoon", id: "777", imgUrl: "https://www.petstock.com.au/images/cache/product_feature/images/products/5c3437611b41b5.08627595.jpeg")
        categories.append(category)
        
        collectionView.register(UINib(nibName: Identifiers.CategoryCell, bundle: nil), forCellWithReuseIdentifier: Identifiers.CategoryCell)
    }
    

   

}

extension MainDetailVC: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout  {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return categories.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        if let cell = collectionView.dequeueReusableCell(withReuseIdentifier: Identifiers.CategoryCell, for: indexPath) as? CategoryCell {
            cell.configureCell(category: categories[indexPath.item])
            return cell
        }
        return UICollectionViewCell()
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        
        let width = view.frame.width
        let cellWidth = (width - 50) / 2
        let cellHeight = cellWidth * 1.5
        print("width=\(cellWidth) , \(cellHeight)" )
        
        return CGSize(width: cellWidth, height: cellHeight)
    }

}
