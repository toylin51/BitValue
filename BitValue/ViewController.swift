//
//  ViewController.swift
//  BitValue
//
//  Created by LinTing-yang on 2017/1/14.
//  Copyright © 2017年 sample. All rights reserved.
//

import UIKit

class ViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    @IBOutlet var tableView: UITableView!
    
    var json = NSMutableArray()
    var vc =  NSMutableArray()
    var vcDetail: VCViewController = VCViewController()
    
    @IBAction func webSiteBtn(_ sender: Any) {
        let url = URL(string: "http://coinmarketcap.com/")!
        if #available(iOS 10.0, *) {
            //對應 iOS 10 以上
            UIApplication.shared.open(url, options: [:], completionHandler: nil)
        } else {
            UIApplication.shared.openURL(url)
        }
    }
    
    @IBAction func unwindToMenu(segue: UIStoryboardSegue) {
        let paths : NSArray = NSSearchPathForDirectoriesInDomains(.documentDirectory, .userDomainMask, true) as NSArray
        let documentsDirectory = paths.object(at: 0) as! NSString
        let writablePath = documentsDirectory.appendingPathComponent("VirtualCurrency.plist")
        
        vc = NSMutableArray(contentsOfFile: writablePath)!
        tableView.reloadData()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //Load JSON from Crypto-Currency http://coinmarketcap.com/api/
        let url = URL(string: "https://api.coinmarketcap.com/v1/ticker")
        do{
            let jsonData = try Data(contentsOf: url!)
            json = try JSONSerialization.jsonObject(with: jsonData , options: JSONSerialization.ReadingOptions.mutableContainers) as! NSMutableArray
        }catch{
            print(error)
        }
        tableView.frame = CGRect(origin: CGPoint(x:0,y:20), size: CGSize(width:view.frame.width, height:view.frame.height-64))
        tableView.dataSource = self
        tableView.delegate = self
        
        tableView.setUpTableView()
        
        let paths : NSArray = NSSearchPathForDirectoriesInDomains(.documentDirectory, .userDomainMask, true) as NSArray
        let documentsDirectory = paths.object(at: 0) as! NSString
        let writablePath = documentsDirectory.appendingPathComponent("VirtualCurrency.plist")
        
        vc = NSMutableArray(contentsOfFile: writablePath)!
        
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if (segue.identifier == "VCDetail"){
            self.vcDetail = segue.destination as! VCViewController
        }
    }
    
    //MARK: TableView
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return vc.count
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath) as! CustomTableViewCell
        for dictionary in json{
            let myVC = vc[indexPath.row] as! String
            let data = (dictionary as AnyObject).object(forKey: "name") as? String
            if myVC == data {
                cell.currencyName.text = (dictionary as AnyObject).object(forKey: "symbol") as? String
                cell.currencyValue.text = (dictionary as AnyObject).object(forKey: "price_usd") as? String
                var i = (dictionary as AnyObject).object(forKey: "percent_change_24h")
                i = nullToNil(value: i as AnyObject?)
                if (i != nil){
                    cell.currencyChange.setTitle(i as? String, for: .normal)
                }else{
                    cell.currencyChange.setTitle("null", for: .normal)
                }
            }
        }
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        tableView.deselectRow(at: indexPath, animated: true)
        
        //改變顯示虛擬貨幣的資訊
        for dictionary in json{
            let myVC = vc[indexPath.row] as! String
            let data = (dictionary as AnyObject).object(forKey: "name") as? String
            if myVC == data {
                vcDetail.VCName.text = (dictionary as AnyObject).object(forKey: "name") as? String
                vcDetail.btc_price.text = (dictionary as AnyObject).object(forKey: "price_btc") as? String
                vcDetail.market_cap.text = (dictionary as AnyObject).object(forKey: "market_cap_usd") as? String
                vcDetail.volume_24h.text = (dictionary as AnyObject).object(forKey: "24h_volume_usd") as? String
                vcDetail.available_supply.text = (dictionary as AnyObject).object(forKey: "available_supply") as? String
            }
        }
    }
    
    func nullToNil(value : AnyObject?) -> AnyObject? {
        if value is NSNull {
            return nil
        } else {
            return value
        }
    }
}

