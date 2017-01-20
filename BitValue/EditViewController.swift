//
//  EditViewController.swift
//  BitValue
//
//  Created by LinTing-yang on 2017/1/19.
//  Copyright © 2017年 sample. All rights reserved.
//

import UIKit

class EditViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {

    @IBOutlet var tableView: UITableView!
    var vc =  NSMutableArray()
    
    
    @IBAction func doneButton(_ sender: Any) {
        self.performSegue(withIdentifier: "unwindToMenu", sender: self)
    }
    @IBAction func unwindToEdit(segue: UIStoryboardSegue) {
        let paths : NSArray = NSSearchPathForDirectoriesInDomains(.documentDirectory, .userDomainMask, true) as NSArray
        let documentsDirectory = paths.object(at: 0) as! NSString
        let writablePath = documentsDirectory.appendingPathComponent("VirtualCurrency.plist")
        
        vc = NSMutableArray(contentsOfFile: writablePath)!
        tableView.reloadData()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        tableView.delegate = self
        tableView.dataSource = self
        tableView.frame = CGRect(origin: CGPoint(x:0,y:64), size: CGSize(width:view.frame.width, height:view.frame.height-64))
        tableView.setUpTableView()
        tableView.isEditing = true
        
        let paths : NSArray = NSSearchPathForDirectoriesInDomains(.documentDirectory, .userDomainMask, true) as NSArray
        let documentsDirectory = paths.object(at: 0) as! NSString
        let writablePath = documentsDirectory.appendingPathComponent("VirtualCurrency.plist")
        
        vc = NSMutableArray(contentsOfFile: writablePath)!
    }
    
    override func viewWillAppear(_ animated: Bool)  {
        super.viewWillAppear(animated)
        self.tableView.reloadData()
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    // MARK: Table View
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return vc.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = UITableViewCell()
        
        cell.textLabel?.text = vc[indexPath.row] as! String
        cell.textLabel?.textColor = UIColor.white
        cell.backgroundColor = UIColor.black
        return cell
    }
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            
            let paths : NSArray = NSSearchPathForDirectoriesInDomains(.documentDirectory, .userDomainMask, true) as NSArray
            let documentsDirectory = paths.object(at: 0) as! NSString
            let writablePath = documentsDirectory.appendingPathComponent("VirtualCurrency.plist")
 
            vc.removeObject(at: indexPath.row)
            vc.write(toFile: writablePath, atomically: true)
            tableView.deleteRows(at: [indexPath], with: .fade)
        }
    }

}
