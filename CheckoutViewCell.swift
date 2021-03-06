//
//  CheckoutViewCell.swift
//  cafe
//
//  Created by 楊仁翰 on 2017/3/31.
//  Copyright © 2017年 Renhen Yang. All rights reserved.
//

import UIKit

class CheckoutViewCell: UITableViewCell {
    
    @IBOutlet weak var sugarSel: UILabel!
    @IBOutlet weak var iceSel: UILabel!
    @IBOutlet weak var productName: UILabel!
    @IBOutlet weak var productPrice: UILabel!
    @IBOutlet weak var productQuantity: UILabel!
    
    var productTotalAmount:Int!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        
        // Configure the view for the selected state
    }
    
    func SetProductAttribute(_ item:Item){
        
        productName.text = item.name
        sugarSel.text = item.sugar
        iceSel.text = item.ice
        
        
        let itemPrice = item.roundPrice as! Int
        let itemQty = item.qty as! Int
        productTotalAmount = itemPrice * itemQty
        
        productPrice.text = "$ \(String(productTotalAmount))"
        productQuantity.text = String(describing: item.qty!)
    }
    
}
