//
//  SearchViewController.swift
//  BitValue
//
//  Created by LinTing-yang on 2017/1/17.
//  Copyright © 2017年 sample. All rights reserved.
//

import UIKit

class SearchViewController: UIViewController, UITableViewDelegate, UITableViewDataSource, UISearchBarDelegate, UISearchDisplayDelegate{
    
    @IBOutlet var searchBar: UISearchBar!
    @IBOutlet var tableView: UITableView!
    
    var dataArr = [String]()
    var filteredArr = [String]()
    var json = NSMutableArray()
    var vc =  NSMutableArray()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //Load JSON from Crypto-Currency http://coinmarketcap.com/api/
        let url = URL(string: "https://api.coinmarketcap.com/v1/ticker")
        do{
            let jsonData = try Data(contentsOf: url!)
            json = try JSONSerialization.jsonObject(with: jsonData , options: JSONSerialization.ReadingOptions.mutableContainers) as! NSMutableArray
            for i in json {
                let vc = (i as AnyObject).object(forKey: "name") as! String
                dataArr.append(vc)
            }
        }catch{
            print(error)
        }
        
        
        tableView.delegate = self
        tableView.dataSource = self
        tableView.setUpTableView()
        searchBar.delegate = self
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        //直接跳出搜尋
        searchBar.becomeFirstResponder()
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    // MARK: Table View
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if tableView != self.tableView{
            return self.filteredArr.count
        }else{
            return 0
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = UITableViewCell()
        
        if tableView != self.tableView {
            cell.textLabel?.text = self.filteredArr[indexPath.row]
            cell.backgroundColor = UIColor.black
            cell.textLabel?.textColor = UIColor.white
            tableView.backgroundColor = UIColor.black
        }
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let paths : NSArray = NSSearchPathForDirectoriesInDomains(.documentDirectory, .userDomainMask, true) as NSArray
        let documentsDirectory = paths.object(at: 0) as! NSString
        let writablePath = documentsDirectory.appendingPathComponent("VirtualCurrency.plist")
        
        vc = NSMutableArray(contentsOfFile: writablePath)!
        vc.add(filteredArr[indexPath.row])
        
        vc.write(toFile: writablePath, atomically: true)
        self.performSegue(withIdentifier: "unwindToEdit", sender: self)
    }
    
    // MARK: Search func
    
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        filteredArr = dataArr.filter({ (name: String) -> Bool in
            if name.lowercased().contains(self.searchBar.text!.lowercased()){
                return true
            } else {
                return false
            }
        })
        self.tableView.reloadData()
    }
    
    func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
        self.performSegue(withIdentifier: "unwindToEdit", sender: self)

    }
}
