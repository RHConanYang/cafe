//
//  Product.swift
//  cafe
//
//  Created by 楊仁翰 on 2017/3/31.
//  Copyright © 2017年 Renhen Yang. All rights reserved.
//

import Foundation
import FirebaseDatabase

class DrinkModel {
    
    var ref: DatabaseReference?
    var name: String?
    var calPrice:String?
    var picture: String?
    var price: String?
    var scribe: String?
    var type: String?
    
    init(snapshot: DataSnapshot) {
        ref = snapshot.ref
        let data = snapshot.value as! Dictionary<String, AnyObject>
        

        name = data["name"] as? String
        calPrice = data["calPrice"] as? String
        picture = data["picture"] as? String
        price = data["price"] as? String
        scribe =  data["scribe"] as? String
        type = data["type"] as? String
        
        
    }
}




