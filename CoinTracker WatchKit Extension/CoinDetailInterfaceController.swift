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
    let defaults = NSUserDefaults.standardUserDefaults()
    let favoriteCoinKey = "favoriteCoin"
    
    @IBOutlet weak var coinImage: WKInterfaceImage!
    @IBOutlet weak var nameLabel: WKInterfaceLabel!
    @IBOutlet weak var table: WKInterfaceTable!
    @IBOutlet weak var favoriteSwitch: WKInterfaceSwitch!
    
    
    override func awakeWithContext(context: AnyObject?) {
        super.awakeWithContext(context)
        
        if let coin = context as? Coin {
            self.coin = coin
            setTitle(coin.name)
            coinImage.setImageNamed(coin.name)
            nameLabel.setText(coin.name)
        }
        
        // Create two arrays to hold the title and value
        let titles = ["Current Price", "Yesterday's Price", "Volume"]
        let values = ["\(coin.price) USD", "\(coin.price24h) USD", String(format: "%.4f", coin.volume)]
        
        // Set the number of rows on the table
        table.setNumberOfRows(titles.count, withRowType: "CoinRow")
        
        for i in 0..<titles.count {
            if let row = table.rowControllerAtIndex(i) as? CoinRow {
                row.titleLabel.setText(titles[i])
                row.detailLabel.setText(values[i])
            }
        }
        
        if let favoriteCoin = defaults.stringForKey(favoriteCoinKey) {
            favoriteSwitch.setOn(favoriteCoin == coin.name)
        }
    }
    
    @IBAction func favoriteSwitchValueChanged(value: Bool) {
        // Make sure the coin is not nil
        if let coin = coin {
            // Remove any previously stored favorite from the defaults
            defaults.removeObjectForKey(favoriteCoinKey)
            // If user has set the switch to on, then store the name of current coin
            if value {
                defaults.setObject(coin.name, forKey: favoriteCoinKey)
            }
            
            // Synchronize the defaults to guarantee the changes are written to disk and any observers are notified of the changes
            defaults.synchronize()
        }
    }
}
