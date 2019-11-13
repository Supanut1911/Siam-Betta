//
//  PopupFishVC.swift
//  Siam Betta
//
//  Created by Supanut Laddayam on 31/10/2562 BE.
//  Copyright © 2562 Supanut Laddayam. All rights reserved.
//

import UIKit
import Firebase
import Kingfisher


class PopupFishVC: UIViewController {

    var predictFish: String = "defalut text"
    var secPredictFish: String = ""
    
    var predictPercen: Double = 0.0
    var secPredictPercen: Double = 0.0
    
    var takePhotoImage: UIImage!
    
    var imageFirebase: String = ""
    
    var db = Firestore.firestore()
    
    @IBOutlet weak var cancelBtn: UIButton!
    @IBOutlet weak var predictLabel: UILabel!
    
    
    @IBOutlet weak var topFishName: UILabel!
    @IBOutlet weak var topConfidenceLabel: UILabel!
    
    
    @IBOutlet weak var secFishName: UILabel!
    @IBOutlet weak var secConfidenceLabel: UILabel!
    
    
    
    @IBOutlet weak var imageFromTaking: UIImageView!
    @IBOutlet weak var detailLabel: UILabel!
    
    @IBOutlet weak var descriptionFishDetailView: UIView!
    
    
    
    @IBOutlet weak var predictView: UIView!
    //    @IBOutlet weak var imageFirebaseView: UIImageView!
    
    @IBOutlet weak var bgView: UIImageView!
    override func viewDidLoad() {
        super.viewDidLoad()
        

    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        fetchDocument()
        setUp()
        
        
    }
    
    func setUp() {
        self.bgView.setGradientBackground(colorOne: UIColor.OceanBlue, colorTwo: UIColor.LightOrange)
        predictLabel.text = predictFish
        topFishName.text = predictFish
        secFishName.text = secPredictFish
        imageFromTaking.image = takePhotoImage
        topConfidenceLabel.text = String(round(predictPercen))
        print("value : \(secPredictPercen)")
        secConfidenceLabel.text = String(round(secPredictPercen))

        setupView()
    }
    
    
    // setUP about View
    func setupView() {
        predictView.layer.cornerRadius = 25
        predictView.layer.shadowColor = AppColors.PINK.cgColor
        predictView.layer.shadowOpacity = 0.4
        predictView.layer.shadowOffset = CGSize.zero
        predictView.layer.shadowRadius = 4
        
        descriptionFishDetailView.layer.cornerRadius = 15
        descriptionFishDetailView.layer.shadowColor = UIColor.black.cgColor
        descriptionFishDetailView.layer.shadowOpacity = 0.4
        descriptionFishDetailView.layer.shadowOffset = CGSize.zero
        descriptionFishDetailView.layer.shadowRadius = 4

    }
    
    private func setRoundedImg() {
        imageFromTaking.layer.cornerRadius = 10
        imageFromTaking.clipsToBounds = true
        imageFromTaking.layer.borderColor = AppColors.Offwhite.cgColor
        imageFromTaking.layer.borderWidth = 1
    }
    
    
    
    func fetchDocument() {
        //case 1 - bigear
        if self.predictFish == "BigearBetta" {
            let docRef = db.collection("categories").document("BigearBetta")
            docRef.getDocument { (snap, error) in
                guard let data = snap?.data() else {return}
                let detail = data["detail"] as! String ?? ""
//                let imageUrl = data["imageUrl"] as! String ?? ""
//                print(imageUrl)
//                self.imageFirebase = imageUrl
                self.detailLabel.text = detail
            }
        }
        
        //case 2 - crowntail
        else if self.predictFish == "CrowntailBetta" {
            let docRef = db.collection("categories").document("CrownTail")
            docRef.getDocument { (snap, error) in
                guard let data = snap?.data() else {return}
                let detail = data["detail"] as! String ?? ""
                self.detailLabel.text = detail
            }
        }
        
        //case 3 - doubletail
        else if self.predictFish == "DoubletailBetta" {
            let docRef = db.collection("categories").document("DoubleTail")
            docRef.getDocument { (snap, error) in
                guard let data = snap?.data() else {return}
                let detail = data["detail"] as! String ?? ""
                self.detailLabel.text = detail
            }
        }
        
        //case 4 - halfmoon
        else if self.predictFish == "HalfmoonBetta" {
            let docRef = db.collection("categories").document("Halfmoon")
            docRef.getDocument { (snap, error) in
                guard let data = snap?.data() else {return}
                let detail = data["detail"] as! String ?? ""
                self.detailLabel.text = detail
            }
        }
        
        //case 5 - viltail
        else if self.predictFish == "ViltailBetta" {
            let docRef = db.collection("categories").document("Viltail")
            docRef.getDocument { (snap, error) in
                guard let data = snap?.data() else {return}
                let detail = data["detail"] as! String ?? ""
                self.detailLabel.text = detail
            }
        }
            
        //case 6 - wild
        else if self.predictFish == "WildBetta" {
            let docRef = db.collection("categories").document("WildBetta")
            docRef.getDocument { (snap, error) in
                guard let data = snap?.data() else {return}
                let detail = data["detail"] as! String ?? ""
                self.detailLabel.text = detail
            }
        }
            
        else {
            print("not feteching")
        }
        
    }
    
    @IBAction func cancelDidTap(_ sender: Any) {
        dismiss(animated: true, completion: nil)
    }
    
    
}
