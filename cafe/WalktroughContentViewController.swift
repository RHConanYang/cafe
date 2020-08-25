//
//  WalktroughContentViewController.swift
//  cafe
//
//  Created by 楊仁翰 on 2017/5/15.
//  Copyright © 2017年 Renhen Yang. All rights reserved.
//

import UIKit

class WalktroughContentViewController: UIViewController {

    @IBOutlet weak var heading: UILabel!
    @IBOutlet weak var image: UIImageView!
    @IBOutlet weak var footing: UILabel!
    @IBOutlet weak var pageCtrl: UIPageControl!
    @IBOutlet weak var fowardButton: UIButton!

    var index = 0
    var headingString = ""
    var imageFile = ""
    var content = ""
    

    
    override func viewDidLoad() {
        super.viewDidLoad()

        heading.text = headingString
        footing.text = content
        image.image = UIImage(named: imageFile)
        
        
        // set page control's page index.
        pageCtrl.currentPage = index
        
        // Switch page 1, 2, 3
        switch index {
        case 0 ... 1:
            fowardButton.setTitle("NEXT", for: .normal)
        case 2:
            fowardButton.setTitle("DONE", for: .normal)
        default:
            break
        }
    }
    

    // For buttons Action.
    @IBAction func tappedNext(_ sender: UIButton) {
        switch index {
        case 0 ... 1:
            let pageViewController = parent as! WalktroughPageViewController
            pageViewController.foward(index: index)
        case 2:
            UserDefaults.standard.set(true, forKey: "hasViewedWalkthrough") // User delaults.
            dismiss(animated: true, completion: nil)
        default:
            break
        }
        
        
        
    }

    

    
    

}
