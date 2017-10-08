//
//  ItemCoreDataProperties.swift
//  cafe
//
//  Created by 楊仁翰 on 2017/4/1.
//  Copyright © 2017年 Renhen Yang. All rights reserved.
//

import Foundation
import CoreData

extension Item {
    
    @NSManaged var displayPrice: String?
    @NSManaged var image: Data?
    @NSManaged var name: String?
    @NSManaged var qty: NSNumber?
    @NSManaged var roundPrice: NSNumber?

}
