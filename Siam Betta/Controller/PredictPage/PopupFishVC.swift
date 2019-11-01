//
//  PopupFishVC.swift
//  Siam Betta
//
//  Created by Supanut Laddayam on 31/10/2562 BE.
//  Copyright © 2562 Supanut Laddayam. All rights reserved.
//

import UIKit

class PopupFishVC: UIViewController {

    var predictFish: String = "defalut text"
    
    @IBOutlet weak var cancelBtn: UIButton!
    @IBOutlet weak var predictLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        

    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        print("after pass: \(predictFish)")
        predictLabel.text = predictFish
    }
    
    @IBAction func cancelDidTap(_ sender: Any) {
        dismiss(animated: true, completion: nil)
    }
    

}
