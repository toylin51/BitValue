//
//  VCViewController.swift
//  BitValue
//
//  Created by LinTing-yang on 2017/1/20.
//  Copyright © 2017年 sample. All rights reserved.
//

import UIKit

class VCViewController: UIViewController {

    @IBOutlet var VCName: UILabel!
    @IBOutlet var btc_price: UILabel!
    @IBOutlet var market_cap: UILabel!
    @IBOutlet var volume_24h: UILabel!
    @IBOutlet var available_supply: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()

    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

}
