//
//  ProductInfoViewController.swift
//  cafe
//
//  Created by 楊仁翰 on 2017/4/1.
//  Copyright © 2017年 Renhen Yang. All rights reserved.
//

import UIKit
import CoreData

class ProductInfoViewController: UIViewController {
    
    // Managed Object Context - reference to Core Data / access to Core Data
    let moc = DataController().managedObjectContext;
    
    @IBOutlet weak var sugarSeg: UISegmentedControl!
    @IBOutlet weak var iceSeg: UISegmentedControl!
    @IBOutlet weak var prodactImage: UIImageView!
    @IBOutlet weak var prodactPrice: UILabel!
    @IBOutlet weak var prodactName: UILabel!
    @IBOutlet weak var prodactDescription: UILabel!
    @IBOutlet weak var orderNowButton: UIButton!
    @IBOutlet weak var addToBasketButton: UIButton!
    @IBOutlet weak var alertBox: UIView!
    @IBOutlet weak var backGro: UIImageView!
    var setTitle:String!
    var picture: String!
    var calPrice: String!
    var price: String!
    var scribe: String!
    
    
    
    var prodactData:[String]!
    var categoryName:String!
    var listItems = [NSManagedObject]()
    var iceSel:String = ""
    var sugarSel:String = ""

    
    
    override func viewDidLoad() {
        
        title = "\(setTitle!)";
        
        //Buttons attributes
        addToBasketButton.layer.borderWidth = 1;
        addToBasketButton.layer.borderColor = UIColor.darkGray.cgColor
        addToBasketButton.layer.shadowColor = UIColor.darkGray.cgColor
        addToBasketButton.layer.shadowRadius = 4
        addToBasketButton.layer.shadowOpacity = 0.5
        addToBasketButton.layer.shadowOffset = CGSize(width: 0, height: 0)
        
        orderNowButton.backgroundColor = UIColor.darkGray
        
        orderNowButton.setTitleColor(UIColor.white, for: .normal)
        orderNowButton.layer.shadowColor = UIColor.darkGray.cgColor
        orderNowButton.layer.shadowRadius = 4
        orderNowButton.layer.shadowOpacity = 0.5
        orderNowButton.layer.shadowOffset = CGSize(width: 0, height: 0)
        
        // Blureffect.
        let blurEffect = UIBlurEffect(style: UIBlurEffectStyle.light)
        let blurEffectView = UIVisualEffectView(effect: blurEffect)
        blurEffectView.frame = backGro.bounds
        blurEffectView.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        backGro.addSubview(blurEffectView)
        
        
        // Cart Button
        let cartButton = UIBarButtonItem(image: UIImage(named: "cart30"), style: UIBarButtonItemStyle.plain, target: self, action: #selector(ProductInfoViewController.cartScreen));
        
        self.navigationItem.rightBarButtonItem = cartButton;
        
        // Retrieve the data from Core Data
        let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: "Item");
        
        do{
            let results = try moc.fetch(fetchRequest);
            listItems = results as! [NSManagedObject];
        }
        catch{
            print("Data did not Retrieve");
        }
      
        // Set redius and bounds
        prodactImage.layer.cornerRadius = 10
        prodactImage.clipsToBounds = true
        
        // Prodact data
        prodactName.text = setTitle
        prodactImage.image = UIImage(named: picture)
        prodactPrice.text = price
        prodactDescription.text = scribe

        
    }
    
    // Move to shopping cart screen
    @objc func cartScreen(){
        let shoppingCartScreen = storyboard?.instantiateViewController(withIdentifier: "shopping cart view") as! ShoppingCartVC
        
        navigationController?.show(shoppingCartScreen, sender: self)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        // Retrieve the data from Core Data
        let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: "Item");
        
        do{
            let results = try moc.fetch(fetchRequest)
            listItems = results as! [NSManagedObject]
        }
        catch{
            print("Data didn not Retrieve")
        }
        
    }
    
    // Order Now Button - add product to shopping cart and move to shopping cart screen
    @IBAction func orderNowButton(_ sender: UIButton) {
        var productFound = ""
//        var indexPath = 0
        
        // Check if product exists
        
        for i in 0 ..< listItems.count {
            if setTitle == listItems[i].value(forKey: "name") as? String {
                productFound = setTitle
//                indexPath = i
                //print("Product Exists \n\(productFound)")
            }
        }
        
        // If product Not exists create new one, else exceed the quantity of the product in one
        if productFound.isEmpty {
            //print("EMPTY")
            
            // Add/Save the product info to Core Data attributes
            let entityDescription = NSEntityDescription.entity(forEntityName: "Item", in: moc)
            let item = Item(entity: entityDescription!, insertInto: moc)
            item.name = prodactName.text
            item.image = UIImagePNGRepresentation(prodactImage.image!)
            item.displayPrice = prodactPrice.text!
            item.ice = iceSeg.titleForSegment(at: iceSeg.selectedSegmentIndex)
            item.sugar = sugarSeg.titleForSegment(at: sugarSeg.selectedSegmentIndex)
            let roundPrice = calPrice
            item.roundPrice = Int(roundPrice!) as NSNumber?
            item.qty = 1
            
            //print("Items saved: \(item)");
            do {
                try moc.save()
                listItems.append(item)
            }catch {
                print("Didn't Save")
            }
            
        } else {
            
//            let itemUpdate = listItems[indexPath] as! Item;
//            itemUpdate.qty = (Int(truncating: itemUpdate.qty!) + 1) as NSNumber
            
            let entityDescription = NSEntityDescription.entity(forEntityName: "Item", in: moc)
            let item = Item(entity: entityDescription!, insertInto: moc)
            item.name = prodactName.text
            item.image = UIImagePNGRepresentation(prodactImage.image!)
            item.displayPrice = prodactPrice.text!
            item.ice = iceSeg.titleForSegment(at: iceSeg.selectedSegmentIndex)
            item.sugar = sugarSeg.titleForSegment(at: sugarSeg.selectedSegmentIndex)
            let roundPrice = calPrice
            item.roundPrice = Int(roundPrice!) as NSNumber?
            item.qty = 1
            
            do{
                try moc.save()
            }catch {
                print("Failed to save");
                return;
            }
        }
        
        // Move to shopping cart screen
        let shoppingCartScreen = storyboard?.instantiateViewController(withIdentifier: "shopping cart view") as! ShoppingCartVC;
        navigationController?.show(shoppingCartScreen, sender: self)
        
    }
    
    // Add To Basket Button - add product to shopping cart
    @IBAction func addToBasketButton(_ sender: UIButton) {
        var productFound = ""
//        var indexPath = 0

        
        // Check if product exists
        for i in 0 ..< listItems.count {
            if setTitle == listItems[i].value(forKey: "name") as? String {
                productFound = setTitle
//                indexPath = i
                //print("Product Exists \n\(productFound)")
            }
        }
        
        if productFound.isEmpty {
            //print("EMPTY")
            // Add/Save the product info to Core Data attributes
            let entityDescription = NSEntityDescription.entity(forEntityName: "Item", in: moc);
            let item = Item(entity: entityDescription!, insertInto: moc);
            item.name = prodactName.text;
            item.image = UIImagePNGRepresentation(prodactImage.image!);
            item.displayPrice = prodactPrice.text!
            item.ice = iceSeg.titleForSegment(at: iceSeg.selectedSegmentIndex)
            item.sugar = sugarSeg.titleForSegment(at: sugarSeg.selectedSegmentIndex)
            let roundPrice = calPrice
            item.roundPrice = Int(roundPrice!) as NSNumber?
            item.qty = 1
            //print("Items saved: \(item)");
            do {
                try moc.save();
                listItems.append(item);
            }catch {
                print("Didn't Save");
            }
            
            // Alert Box - Main
            if alertBox.isHidden==true {
                showAlert()
            } else {
                resetVariables()
                //print("Variables are reset: \(alertBox.hidden)")
                showAlert()
            }
            //print("Alert show: \(alertBox.hidden)")
        } else {
            
//            let itemUpdate = listItems[indexPath] as! Item;
//            itemUpdate.qty = Int(truncating: itemUpdate.qty!) + 1 as NSNumber
            
            let entityDescription = NSEntityDescription.entity(forEntityName: "Item", in: moc);
            let item = Item(entity: entityDescription!, insertInto: moc);
            item.name = prodactName.text;
            item.image = UIImagePNGRepresentation(prodactImage.image!);
            item.displayPrice = prodactPrice.text!
            item.ice = iceSeg.titleForSegment(at: iceSeg.selectedSegmentIndex)
            item.sugar = sugarSeg.titleForSegment(at: sugarSeg.selectedSegmentIndex)
            let roundPrice = calPrice
            item.roundPrice = Int(roundPrice!) as NSNumber?
            item.qty = 1;
            
            do{
                try moc.save();
            }catch {
                print("Failed to save");
                return;
            }
            
            // Alert Box - Main
            if alertBox.isHidden==true {
                showAlert()
            } else {
                resetVariables()
                showAlert()
            }
        }
        
    }
    
    // Alert Box - Show the alert with animation
    func showAlert(){
        alertBox.isHidden=false
        UIView.animate(withDuration: 6, animations: {
            self.alertBox.alpha=0;//slow fade out
        })
    }
    // Alert Box - Reset the variables
    func resetVariables(){
        alertBox.isHidden=true
        self.alertBox.alpha=1
    }
    
    
}
