//
//  CustomTableViewCell.swift
//  BitValue
//
//  Created by LinTing-yang on 2017/1/15.
//  Copyright © 2017年 sample. All rights reserved.
//

import UIKit

class CustomTableViewCell: UITableViewCell {
    
    @IBOutlet var currencyName: UILabel!
    @IBOutlet var currencyValue: UILabel!
    @IBOutlet var currencyChange: UIButton!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        currencyChange.layer.cornerRadius = 8
        setVolumeColor()
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        
        // Configure the view for the selected state
        
        //改變選取項目的顏色
        if self.isSelected{
            self.contentView.backgroundColor = UIColor.darkGray
        }else{
            self.contentView.backgroundColor = UIColor.clear
        }
        
        setVolumeColor()
    }
    
    override func setHighlighted(_ highlighted: Bool, animated: Bool) {
        super.setHighlighted(highlighted, animated: animated)
        
        //改變長按項目的顏色
        if self.isHighlighted{
            self.contentView.backgroundColor = UIColor.darkGray
        }else{
            self.contentView.backgroundColor = UIColor.clear
        }
        
        setVolumeColor()
    }
    
    func setVolumeColor(){
        //設定漲幅顯示顏色
        let i = currencyChange.titleLabel!.text!
        if i != "null"{
            if i.hasPrefix("-"){
                currencyChange.backgroundColor = UIColor.green
            }else{
                currencyChange.backgroundColor = UIColor.red
            }
        }else{
            currencyChange.backgroundColor = UIColor.lightGray
        }
    }
}
