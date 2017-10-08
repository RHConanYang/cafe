//
//  MainViewController.swift
//  cafe
//
//  Created by 楊仁翰 on 2017/7/28.
//  Copyright © 2017年 Renhen Yang. All rights reserved.
//

import UIKit
import FirebaseAuth

class MainViewController: UIViewController {

    
    @IBOutlet weak var startOrder: UIButton!
    
    @IBOutlet weak var information: UIButton!
    
    @IBOutlet weak var positionOf59: UIButton!
    
    @IBOutlet weak var logout: UIButton!
    
    @IBOutlet weak var babkGr: UIImageView!
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //title = ""
        // button effect
        startOrder.backgroundColor = UIColor.darkGray
        startOrder.layer.cornerRadius = startOrder.frame.height / 2
        startOrder.setTitleColor(UIColor.white, for: .normal)
        startOrder.layer.shadowColor = UIColor.darkGray.cgColor
        startOrder.layer.shadowRadius = 4
        startOrder.layer.shadowOpacity = 0.5
        startOrder.layer.shadowOffset = CGSize(width: 0, height: 0)
        
        information.backgroundColor = UIColor.darkGray
        information.layer.cornerRadius = information.frame.height / 2
        information.setTitleColor(UIColor.white, for: .normal)
        information.layer.shadowColor = UIColor.darkGray.cgColor
        information.layer.shadowRadius = 4
        information.layer.shadowOpacity = 0.5
        information.layer.shadowOffset = CGSize(width: 0, height: 0)
        
        positionOf59.backgroundColor = UIColor.darkGray
        positionOf59.layer.cornerRadius = information.frame.height / 2
        positionOf59.setTitleColor(UIColor.white, for: .normal)
        positionOf59.layer.shadowColor = UIColor.darkGray.cgColor
        positionOf59.layer.shadowRadius = 4
        positionOf59.layer.shadowOpacity = 0.5
        positionOf59.layer.shadowOffset = CGSize(width: 0, height: 0)
        
        logout.backgroundColor = UIColor.darkGray
        logout.layer.cornerRadius = information.frame.height / 2
        logout.setTitleColor(UIColor.white, for: .normal)
        logout.layer.shadowColor = UIColor.darkGray.cgColor
        logout.layer.shadowRadius = 4
        logout.layer.shadowOpacity = 0.5
        logout.layer.shadowOffset = CGSize(width: 0, height: 0)
        
        // Blureffect.
        let blurEffect = UIBlurEffect(style: UIBlurEffectStyle.light)
        let blurEffectView = UIVisualEffectView(effect: blurEffect)
        blurEffectView.frame = babkGr.bounds
        blurEffectView.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        babkGr.addSubview(blurEffectView)
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        
        // hide navigationcontroller in bush
        self.navigationController?.setNavigationBarHidden(true, animated: animated)
    }
    
    func logoutScreen() {
        do {
            try Auth.auth().signOut()
            let storyboard = UIStoryboard(name: "Main", bundle: nil)
            let vc = storyboard.instantiateViewController(withIdentifier: "loginPage" ) as UIViewController
            self.present(vc, animated: true, completion: nil)
        }catch{
            print(error)
        }
        
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        
        
        // get navigation back
        self.navigationController?.setNavigationBarHidden(false, animated: animated)
    }
    
    @IBAction func logoutTap(_ sender: UIButton) {
        
        logoutScreen()
    }

    

    

}
