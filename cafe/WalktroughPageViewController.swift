//
//  WalktroughPageViewController.swift
//  cafe
//
//  Created by 楊仁翰 on 2017/5/15.
//  Copyright © 2017年 Renhen Yang. All rights reserved.
//

import UIKit

class WalktroughPageViewController: UIPageViewController, UIPageViewControllerDataSource {
    var pageHeadings = ["pageHeadings1", "pageHeadings2", "pageHeadings3"]
    var pageImages = ["pic1", "pic2", "pic3"]
    var pageContent = ["pageContent1", "pageContent2", "pageContent3"]
    
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        dataSource = self
        // set first view
        if let startingViewController = contentViewController(at: 0) {setViewControllers([startingViewController], direction: .forward, animated: true, completion: nil)
        }
    }


  
    // MARK: pageView Before After
    func pageViewController(_ pageViewController: UIPageViewController, viewControllerBefore viewController: UIViewController) -> UIViewController? {
        var index = (viewController as! WalktroughContentViewController).index
        index -= 1
        
        return contentViewController(at: index)
    }
    
    func pageViewController(_ pageViewController: UIPageViewController, viewControllerAfter viewController: UIViewController) -> UIViewController? {
        var index = (viewController as! WalktroughContentViewController).index
        index += 1
        
        return contentViewController(at: index)
    
    }

    
    
    
    
    
    // Set content for for label 1. 2. 3.
    func contentViewController(at index: Int) -> WalktroughContentViewController? {
        if index < 0 || index >= pageHeadings.count {
            return nil
        }
        // set new viewController and send data
        if let pageContentViewController = storyboard?.instantiateViewController(withIdentifier: "WalktroughContentViewController") as? WalktroughContentViewController {
            pageContentViewController.imageFile = pageImages[index]
            pageContentViewController.headingString = pageHeadings[index]
            pageContentViewController.content = pageContent[index]
            pageContentViewController.index = index
            
            return pageContentViewController
        }
        return nil
    }
    
    // Foward function.
    func foward(index: Int) {
        if let nextViewController = contentViewController(at: index + 1) {
            setViewControllers([nextViewController], direction: .forward, animated: true, completion: nil)
        }
    }
    
    
    
    
    

}
