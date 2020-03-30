//
//  ShoppingCartViewCell.swift
//  cafe
//
//  Created by 楊仁翰 on 2017/3/31.
//  Copyright © 2017年 Renhen Yang. All rights reserved.
//

import UIKit

protocol ShoppingCartViewCellDelegate {
    func ShoppingCartViewCellSetQuantity(_ cell: ShoppingCartViewCell, quantity: Int, itemUpdate: Item)
}

class ShoppingCartViewCell: UITableViewCell {
    @IBOutlet weak var productImage: UIImageView!
    @IBOutlet weak var sugarSel: UILabel!
    @IBOutlet weak var productName: UILabel!
    @IBOutlet weak var iceSel: UILabel!
    @IBOutlet weak var productPrice: UILabel!
    @IBOutlet weak var productQuantity: UILabel!
    @IBOutlet weak var productStepper: UIStepper!
    
    
    var delegate:ShoppingCartViewCellDelegate?
    
    var itemUpdate:Item?
    
    var quantity:Int {
        get {
            if (self.productStepper != nil) {
                return Int(self.productStepper!.value)
            }
            
            return 0
        }
        
        set {
            self.setItemQuantity(newValue)
        }
        
    }
    
    // Set product attribute to UILabel, UIImage, UIStepper
    func setItemAttribute(_ item: Item) {
        //print(itemDict)
        productName?.text = item.name
        sugarSel?.text = item.sugar
        iceSel?.text = item.ice
        
        productPrice?.text = item.displayPrice
        
        if let qty:NSNumber = item.qty {
            _ = "數量. \(qty.intValue)"
            self.productStepper?.value = qty.doubleValue
            // Show the quantity from Core Data when the view did Load
            self.productQuantity?.text = "數量: \(qty)";
            productStepper.minimumValue = 1
        }
        
        let images = item.image
        productImage.image = UIImage(data: (images)! as Data)
        
        // The current item will be equal to the itemUpdate to make change on quantity attribute
        itemUpdate = item
        
    }
    
    @IBAction func stepperValueChanged(_ sender: AnyObject) {
        
        
        let value = Int(productStepper!.value)
        
        setItemQuantity(value)
    }
    
    func setItemQuantity(_ quantity: Int) {
        let itemQuantityText = "數量 \(quantity)"
        productQuantity?.text = itemQuantityText
        productStepper?.minimumValue = 1
        productStepper?.value = Double(quantity)
        
        // Notify delegate, if there is one, too...
        if (delegate != nil) {
            delegate?.ShoppingCartViewCellSetQuantity(self, quantity: quantity, itemUpdate: itemUpdate!)
        }
        
    }
    
}
