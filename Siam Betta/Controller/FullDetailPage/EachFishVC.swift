//
//  EachFishVC.swift
//  Siam Betta
//
//  Created by Supanut Laddayam on 6/11/2562 BE.
//  Copyright © 2562 Supanut Laddayam. All rights reserved.
//

import UIKit
import Kingfisher

class EachFishVC: UIViewController {

    //var
    var category: Category!
    var image = ""
    var fishName = ""
    var detail = ""
    var bodyDetail = ""
    var bodyImageUrl = ""
    var backFinImageUrl = ""
    var chestFinImageUrl = ""
    var paunchFinImageUrl = ""
    var tailFinImageUrl = ""
    
    @IBOutlet weak var fishNameLabel: UILabel!
    @IBOutlet weak var fishImageView: UIImageView!
    @IBOutlet weak var backBtn: UIButton!
    
    @IBOutlet weak var mainView: UIView!
    @IBOutlet weak var detailLabel: UILabel!
    
    @IBOutlet weak var bodyImageView: UIImageView!
    
    @IBOutlet weak var bodyDetailLabel: UILabel!
    
    
    @IBOutlet weak var chestFinImageView: UIImageView!
    @IBOutlet weak var backFinImageView: UIImageView!
    @IBOutlet weak var paunchFinImageView: UIImageView!
    @IBOutlet weak var tailFinImageView: UIImageView!
    
    
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setUI()
    }
    

    private func setUI() {
        
        // main image
        if let url = URL(string: image) {
            fishImageView.kf.setImage(with: url)
        }
        
        //body image
        if let url = URL(string: bodyImageUrl) {
            bodyImageView.kf.setImage(with: url)
        }
        
        //backFin image
        if let url = URL(string: backFinImageUrl) {
            backFinImageView.kf.setImage(with: url)
        }
        
        //chestFin image
        if let url = URL(string: chestFinImageUrl) {
            chestFinImageView.kf.setImage(with: url)
        }
        
        //paunchFin image
        if let url = URL(string: paunchFinImageUrl) {
            paunchFinImageView.kf.setImage(with: url)
        }
        
        //taikFin image
        if let url = URL(string: tailFinImageUrl) {
            tailFinImageView.kf.setImage(with: url)
        }
        
        detailLabel.text = detail
        bodyDetailLabel.text = bodyDetail
        fishNameLabel.text = fishName
    }
    
    @IBAction func backDidTap(_ sender: Any) {
        dismiss(animated: true, completion: nil)
    }
    
}
