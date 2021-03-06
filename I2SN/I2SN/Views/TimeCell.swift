//
//  TimeCell.swift
//  I2SN
//
//  Created by 권준원 on 2021/01/26.
//

import UIKit

class TimeCell: UITableViewCell {
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        accessoryType = selected ? .checkmark : .none
        selectionStyle = .none
    }

}
