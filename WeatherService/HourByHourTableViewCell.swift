//
//  HourByHourTableViewCell.swift
//  WeatherService
//
//  Created by Daniel Andrews on 3/9/17.
//  Copyright © 2017 Daniel Andrews. All rights reserved.
//

import UIKit

class HourByHourTableViewCell: UITableViewCell {

    var timeHeight: CGFloat = 0.3
    var iconHeight: CGFloat = 0.4
    var tempHeight: CGFloat = 0.3
    
    var timeView: UIView!
    var iconView: UIImageView!
    var tempView: UIView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        setTimeView()
        setIconView()
        setTempView()
    }
    
    func setTimeView() {
        timeView = UIView(frame: CGRect(x: 0, y: 0, width: frame.width, height: frame.height * timeHeight))
        let timeLabel: UILabel = UILabel(frame: CGRect(x: timeView.frame.width * 0.1, y: timeView.frame.height * 0.1, width: timeView.frame.width * 0.8, height: timeView.frame.height * 0.8))
        timeLabel.center = CGPoint(x: timeView.frame.width / 2, y: timeView.frame.height / 2)
        
        timeView.addSubview(timeLabel)
        addSubview(timeView)
    }
    
    func setIconView() {
        iconView = UIImageView(frame: CGRect(x: 0, y: timeView.frame.maxY, width: frame.width, height: frame.height * iconHeight))
        iconView.contentMode = .scaleAspectFit
        
        addSubview(iconView)
    }
    
    func setTempView() {
        tempView = UIView(frame: CGRect(x: 0, y: iconView.frame.maxY, width: frame.width, height: frame.height * tempHeight))
        let tempLabel: UILabel = UILabel(frame: CGRect(x: tempView.frame.width * 0.1, y: tempView.frame.height * 0.1, width: tempView.frame.width * 0.8, height: tempView.frame.height * 0.8))
        tempLabel.center = CGPoint(x: tempView.frame.width / 2, y: tempView.frame.height / 2)
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
