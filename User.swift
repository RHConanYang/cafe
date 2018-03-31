//
//  User.swift
//  cafe
//
//  Created by 楊仁翰 on 2017/7/28.
//  Copyright © 2017年 Renhen Yang. All rights reserved.
//

import UIKit

class User: NSObject {
    var id: String?
    var name: String?
    var email: String?
    
    init(dictionary: [String: AnyObject]) {
        self.id = dictionary["id"] as? String
        self.name = dictionary["name"] as? String
        self.email = dictionary["email"] as? String
        
    }
}
