//
//  Order.swift
//  cafe
//
//  Created by 楊仁翰 on 2017/5/9.
//  Copyright © 2017年 Renhen Yang. All rights reserved.
//

import UIKit
import FirebaseDatabase

class OrderModel {
    
    var ref: DatabaseReference?
    var name:String?
    var price:Int?
    var qty:Int?
    var text: String?
    var total: String?
    var uid: String?
    var subtotal: Int?
    var uEm: String?
    var autoId: String?
    var timestamp: NSNumber?
    var ice: String?
    var sugar: String?
    
    
    init(snapshot: DataSnapshot) {
        ref = snapshot.ref
        let data = snapshot.value as! Dictionary<String, AnyObject>
        
        uid = data["uid"] as? String
        name = data["name"] as? String
        ice = data["ice"] as? String
        sugar = data["sugar"] as? String
        price = data["price"] as? Int
        qty =  data["qty"] as? Int
        text = data["text"] as? String
        total = data["total"] as? String
        subtotal = data["subtotal"] as? Int
        uEm = data["email"] as? String
        timestamp = data["timestamp"] as? NSNumber
        autoId = snapshot.key
    }
}

struct orderDetail {
    
    var name:String
    var singlePrice:Int
    var totalPrice:Int
    var detail: String
    
    

}

