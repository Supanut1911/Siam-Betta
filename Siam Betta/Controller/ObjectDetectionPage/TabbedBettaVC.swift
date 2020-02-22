//
//  TempVC.swift
//  Siam Betta
//
//  Created by Supanut Laddayam on 26/1/2563 BE.
//  Copyright © 2563 Supanut Laddayam. All rights reserved.
//

import UIKit
import Firebase
import Kingfisher
import FSPagerView

class TabbedBettaVC: UIViewController, FSPagerViewDataSource, FSPagerViewDelegate {
    
    var imageName: [String] = []
    var fishName = ""
    var db = Firestore.firestore()
    
    
    @IBOutlet weak var fishNameView: UIView!
    
    @IBOutlet weak var fishNameLabel: UILabel!
    
    
    @IBOutlet weak var pagerView: FSPagerView!{
        didSet {
            self.pagerView.register(FSPagerViewCell.self, forCellWithReuseIdentifier: "cell")
        }
    }
    
        
        
    @IBOutlet weak var fishDetailLabel: UILabel!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.pagerView.transformer = FSPagerViewTransformer(type: .depth)
        setUpShadow()
        fetchDocument()
        self.fishNameLabel.text = fishName
        
    }
    
    func numberOfItems(in pagerView: FSPagerView) -> Int {
        return imageName.count
    }
    
    func pagerView(_ pagerView: FSPagerView, cellForItemAt index: Int) -> FSPagerViewCell {
        let cell = pagerView.dequeueReusableCell(withReuseIdentifier: "cell", at: index)
        for i in 0...4 {
            if let url = URL(string: self.imageName[index]) {
                
                cell.imageView?.kf.setImage(with: url)
            }
        }
        
//        cell.imageView?.image = UIImage(named: self.imageName[index])
        cell.imageView?.contentMode = .scaleAspectFill
        cell.imageView?.clipsToBounds = true
        return cell
    }
    
    func setUpShadow () {
        fishNameView.layer.shadowColor = #colorLiteral(red: 0.6000000238, green: 0.6000000238, blue: 0.6000000238, alpha: 1)
        fishNameView.layer.shadowOpacity = 1
        fishNameView.layer.shadowOffset = .zero
        fishNameView.layer.shadowRadius = 10
    }
    
    func fetchDocument () {
        if self.fishName == "Bigear Betta" {
            let docRef = db.collection("categories").document("BigearBetta")
            docRef.getDocument { (snap, error) in
                guard let data = snap?.data() else { return }
                let fishDetail = data["detail"] as! String ?? ""
                self.fishDetailLabel.text = fishDetail
                
                let fishImage = data["imageUrl"] as! String ?? ""
                
//                if let url = URL(string: fishImage) {
//                    self.imageView.kf.setImage(with: url)
//                }
            }
        }
        
        else if self.fishName == "Crowntail Betta" {
            let docRef = db.collection("categories").document("CrownTail")
            docRef.getDocument { (snap, error) in
                guard let data = snap?.data() else { return }
                let fishDetail = data["detail"] as! String ?? ""
                self.fishDetailLabel.text = fishDetail
            }
        }
        
        else if self.fishName == "Doubletail Betta" {
            let docRef = db.collection("categories").document("DoubleTail")
            docRef.getDocument { (snap, error) in
                guard let data = snap?.data() else { return }
                let fishDetail = data["detail"] as! String ?? ""
                self.fishDetailLabel.text = fishDetail
            }
        }
            
        else if self.fishName == "Halfmoon Betta" {
            let docRef = db.collection("categories").document("Halfmoon")
            docRef.getDocument { (snap, error) in
                guard let data = snap?.data() else {return}
                let fishDetail = data["detail"] as! String ?? ""
                self.fishDetailLabel.text = fishDetail
                
                let fishImage = data["imageUrl"] as! String ?? ""
                
//                if let url = URL(string: fishImage) {
//                    self.imageView.kf.setImage(with: url)
//                }
            }
        }
        
        else if self.fishName == "Viltail Betta" {
            let docRef = db.collection("categories").document("Viltail")
            docRef.getDocument { (snap, error) in
                guard let data = snap?.data() else { return }
                let fishDetail = data["detail"] as! String ?? ""
                self.imageName.append(data["imageUrl1"] as! String)
                self.imageName.append(data["imageUrl2"] as! String)
                self.imageName.append(data["imageUrl3"] as! String)
                self.fishDetailLabel.text = fishDetail
                
                print("run here \(self.imageName)")
                
                DispatchQueue.main.async(execute: {
                    //perform all the UI updates on the main queue
                    self.pagerView.reloadData()
                    for i in 0...2 {
                        print(">>> \(self.imageName[i])")
                    }
                })
                
            }
        }
            
        else if self.fishName == "Wild Betta" {
            let docRef = db.collection("categories").document("WildBetta")
            docRef.getDocument { (snap, error) in
                guard let data = snap?.data() else { return }
                let fishDetail = data["detail"] as! String ?? ""
                self.fishDetailLabel.text = fishDetail
            }
        }
    }
    
}
