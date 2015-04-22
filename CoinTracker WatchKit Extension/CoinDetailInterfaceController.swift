//
//  CoinDetailInterfaceController.swift
//  CoinTracker
//
//  Created by Jonyzfu on 4/22/15.
//  Copyright (c) 2015 Razeware LLC. All rights reserved.
//

import Foundation
import WatchKit
import CoinKit

class CoinDetailInterfaceController: WKInterfaceController {
    var coin: Coin!
    
    override func awakeWithContext(context: AnyObject?) {
        super.awakeWithContext(context)
        
        if let coin = context as? Coin {
            self.coin = coin
            setTitle(coin.name)
            NSLog("\(self.coin)")
        }
    }
}
