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
    var predictPercen: Double = 0.0
    var takePhotoImage: UIImage!
    
    var imageFirebase: String = ""
    
    var db = Firestore.firestore()
    
    @IBOutlet weak var cancelBtn: UIButton!
    @IBOutlet weak var predictLabel: UILabel!
    @IBOutlet weak var confidenceLabel: UILabel!
    @IBOutlet weak var imageFromTaking: UIImageView!
    @IBOutlet weak var detailLabel: UILabel!
    @IBOutlet weak var fulldetailBtnView: UIView!
    @IBOutlet weak var descriptionFishDetailView: UIView!
    
    
    @IBOutlet weak var predictFX: UIVisualEffectView!
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
//        self.testColorView.setGradientBackground(colorOne: UIColor.Orange, colorTwo: UIColor.OceanBlue)
        self.bgView.setGradientBackground(colorOne: UIColor.OceanBlue, colorTwo: UIColor.LightOrange)
        predictLabel.text = predictFish
//        setRoundedImg()
        imageFromTaking.image = takePhotoImage
        confidenceLabel.text = String(predictPercen)
//        if let url = URL(string: imageFirebase) {
//            imageFirebaseView.kf.setImage(with: url)
//        }
        
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


        fulldetailBtnView.layer.cornerRadius = 30
        fulldetailBtnView.layer.shadowColor = UIColor.black.cgColor
        fulldetailBtnView.layer.shadowOpacity = 0.4
        fulldetailBtnView.layer.shadowOffset = CGSize.zero
        fulldetailBtnView.layer.shadowRadius = 4
        
        
        
    }
    
    private func setRoundedImg() {
        imageFromTaking.layer.cornerRadius = 10
        imageFromTaking.clipsToBounds = true
        imageFromTaking.layer.borderColor = AppColors.Offwhite.cgColor
        imageFromTaking.layer.borderWidth = 1
    }
    
    
    
    func fetchDocument() {
        if self.predictFish == "It's not Betta fish" {
            let docRef = db.collection("categories").document("Halfmoon")
            docRef.getDocument { (snap, error) in
                guard let data = snap?.data() else {return}
                let name = data["name"] as! String ?? ""
                let imageUrl = data["imageUrl"] as! String ?? ""
                print(imageUrl)
                self.imageFirebase = imageUrl
            }
        }
        
        else {
            print("not feteching")
        }
        
    }
    
    @IBAction func cancelDidTap(_ sender: Any) {
        dismiss(animated: true, completion: nil)
    }
    

    @IBAction func goFullDetailBtn(_ sender: Any) {
        print("go full detail")
    }
}
