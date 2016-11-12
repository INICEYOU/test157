//
//  PersistencyManager.swift
//  Test157
//
//  Created by Andrey on 09.11.16.
//  Copyright © 2016 Kozhurin Andrey. All rights reserved.
//

import Foundation

class PersistencyManager: NSObject {
    
    fileprivate var order : Order?
    fileprivate let filename = NSHomeDirectory().appending("/Documents/order.bin")
    
    override init() {
        super.init()
        if let data = try? Data(contentsOf: URL(fileURLWithPath: filename)) {
            let unarchiveOrder = NSKeyedUnarchiver.unarchiveObject(with: data) as! Order?
            if let unwrappedOrder = unarchiveOrder {
                order = unwrappedOrder
            }
        } else {
            order = Order()
        }
    }
    
    func getOrder () -> Order {
        return order!
    }
    
    func saveOrder() {
        let data = NSKeyedArchiver.archivedData(withRootObject: self.order!)
        try? data.write(to: URL(fileURLWithPath: filename ), options: .atomic)
    }
}
