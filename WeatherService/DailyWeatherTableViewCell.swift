//
//  DailyWeatherTableViewCell.swift
//  WeatherApp
//
//  Created by Shireen Warrier on 3/9/17.
//  Copyright © 2017 Shireen Warrier. All rights reserved.
//

import UIKit

class DailyWeatherTableViewCell: UITableViewCell {
    var dayLabel: UILabel!
    var icon: UIImageView!
    var highTemp: UILabel!
    var lowTemp: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        self.backgroundColor = UIColor(hex: "7FC9EF")
        setupUI()
        // Initialization code
    
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        
        // Configure the view for the selected state
    }
    
    func setupUI() {
        dayLabel = UILabel(frame: CGRect(x: contentView.frame.minX + 20, y: contentView.frame.minY + 10, width: contentView.frame.width * 0.4, height: contentView.frame.height))
        dayLabel.textColor = UIColor.black
        dayLabel.font = UIFont(name: "ArialMT", size: 19)
        dayLabel.adjustsFontForContentSizeCategory = true
        
        icon = UIImageView(frame: CGRect(x: dayLabel.frame.maxX + 10, y: contentView.frame.minY, width: contentView.frame.width * 0.1, height: contentView.frame.height))
        icon.contentMode = .scaleAspectFit
        
        highTemp = UILabel(frame: CGRect(x: icon.frame.maxX + 60, y: contentView.frame.minY + 10, width: contentView.frame.width * 0.15, height: contentView.frame.height))
        highTemp.textColor = UIColor.black
        highTemp.font = UIFont(name: "ArialMT", size: 12)
        highTemp.adjustsFontForContentSizeCategory = true
        
        lowTemp = UILabel(frame: CGRect(x: highTemp.frame.maxX + 10, y: contentView.frame.minY + 10, width: contentView.frame.width * 0.15, height: contentView.frame.height))
        lowTemp.textColor = UIColor.black
        lowTemp.font = UIFont(name: "ArialMT", size: 12)
        lowTemp.adjustsFontForContentSizeCategory = true
        
        contentView.addSubview(dayLabel)
        contentView.addSubview(icon)
        contentView.addSubview(highTemp)
        contentView.addSubview(lowTemp)
    }
}
