//
//  HourlyWeatherTableViewCell.swift
//  WeatherApp
//
//  Created by Shireen Warrier on 3/10/17.
//  Copyright © 2017 Shireen Warrier. All rights reserved.
//

import UIKit

class HourlyWeatherTableViewCell: UICollectionViewCell {
    var timeLabel: UILabel!
    var icon: UIImageView!
    var tempLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        self.backgroundColor = UIColor(hex: "3498DB")
        setupUI()
        // Initialization code
    }
        // Configure the view for the selected state
    func setupUI() {
        timeLabel = UILabel(frame: CGRect(x: 0, y: 0, width: contentView.frame.width, height: contentView.frame.height * (1/3)))
        timeLabel.numberOfLines = 0
        timeLabel.textAlignment = .center
        timeLabel.textColor = UIColor.white
        timeLabel.font = UIFont(name: "ArialMT", size: 14)
        timeLabel.adjustsFontForContentSizeCategory = true
        
        icon = UIImageView(frame: CGRect(x: 0, y: timeLabel.frame.maxY, width: contentView.frame.width * (1/3), height: contentView.frame.height * (1/3)))
        icon.contentMode = .scaleAspectFit
        icon.center = CGPoint(x: frame.width / 2, y: frame.height / 2)
        
        tempLabel = UILabel(frame: CGRect(x: 0, y: icon.frame.maxY, width: contentView.frame.width, height: contentView.frame.height * (1/3)))
        tempLabel.numberOfLines = 0
        tempLabel.textAlignment = .center
        tempLabel.textColor = UIColor.white
        //tempLabel.font = UIFont(name: "ArialMT", size: 19)
        tempLabel.adjustsFontForContentSizeCategory = true
        
        contentView.addSubview(timeLabel)
        contentView.addSubview(icon)
        contentView.addSubview(tempLabel)
        contentView.bringSubview(toFront: timeLabel)
        contentView.bringSubview(toFront: tempLabel)
    }

}
