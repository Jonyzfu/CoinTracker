//
//  CoinGlanceInterfaceController.swift
//  CoinTracker
//
//  Created by Jonyzfu on 4/23/15.
//  Copyright (c) 2015 Razeware LLC. All rights reserved.
//

import Foundation
import WatchKit
import CoinKit

class CoinGlanceInterfaceController: WKInterfaceController {
    // Define three outlets for the coin icon, name and current price
    @IBOutlet weak var coinImage: WKInterfaceImage!
    @IBOutlet weak var nameLabel: WKInterfaceLabel!
    @IBOutlet weak var priceLabel: WKInterfaceLabel!
    
    // Create a reference to the CoinHelper class to access the cached coin data and retrieve the favorite cryptocurrency
    let helper = CoinHelper()
    let defaults = NSUserDefaults.standardUserDefaults()
    
    override func awakeWithContext(context: AnyObject?) {
        super.awakeWithContext(context)
        
        // Ask the defaults for the favorite currency
        let favoriteCoin = defaults.stringForKey("favoriteCoin") ?? "DOGE"
        // Retrieve the cached coin data using CoinHelper class
        let coins = helper.cachedPrices()
        for coin in coins {
            if coin.name == favoriteCoin {
                coinImage.setImageNamed(coin.name)
                nameLabel.setText(coin.name)
                priceLabel.setText("\(coin.price)")
                updateUserActivity("com.rareware.CoinTracker.glance", userInfo: ["coin": coin.name], webpageURL: nil)
                break
            }
        }
    }
    
}
