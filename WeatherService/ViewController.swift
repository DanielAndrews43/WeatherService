//
//  ViewController.swift
//  WeatherService
//
//  Created by Daniel Andrews on 3/7/17.
//  Copyright © 2017 Daniel Andrews. All rights reserved.
//

import UIKit
import CoreLocation
import SwiftyJSON
import Alamofire

class ViewController: UIViewController {
    
    //top part
    var temp: Int!
    var rainTime: String!
    var tempDescription: String!
    
    //hourly part
    var hourlyTemps: [Int] = []
    var hourlyIconNames: [String] = []
    var hourlyTimes: [String] = []
    var hourlyImage: [UIImage] = []
    
    //daily part
    var dailyIconNames: [String] = []
    var dailyHighs: [Int] = []
    var dailyLows:  [Int] = []
    var dailyImages: [UIImage] = []
    var dailyDayNames: [String] = []
    
    var tempView: UIView!
    var dailyWeatherTableView: UITableView!
    var hourlyWeatherCollectionView: UICollectionView!
    
    var tempLabel: UILabel!
    var rainLabel: UILabel!
    var descLabel: UILabel!
    
    let tempHeight: CGFloat = 0.5
    let rainHeight: CGFloat = 0.25
    let descHeight: CGFloat = 0.25
    
    let myNotificationKey = "com.devs.notificationKey"
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        NotificationCenter.default.addObserver(self, selector: #selector(self.catchNotification(_:)), name: NSNotification.Name(rawValue: self.myNotificationKey), object: nil)
        
        view.backgroundColor = UIColor(hex: "3498DB")
    }
    
    func catchNotification(_ notification: NSNotification) {
        
        let userInfo = JSON(notification.userInfo!)
        
        temp = Int(userInfo["currently"]["temperature"].doubleValue)
        rainTime = "NEVER"
        tempDescription = userInfo["currently"]["summary"].stringValue
        
        for hour in userInfo["hourly"]["data"].arrayValue {
            hourlyTemps.append(Int(hour["temperature"].doubleValue))
            
            let unixTime: Int = hour["time"].intValue
            let date = NSDate(timeIntervalSince1970: Double(unixTime))
            let dateFormatter = DateFormatter()
            dateFormatter.timeStyle = DateFormatter.Style.short //Set time style
            dateFormatter.dateStyle = DateFormatter.Style.none //Set date style
            dateFormatter.timeZone = TimeZone(abbreviation: "pst")
            let localDate = dateFormatter.string(from: date as Date)
            hourlyTimes.append(localDate)
            
            let iconName = hour["icofn"].stringValue
            hourlyIconNames.append(iconName)
            
            if iconName == "partly-cloudy-day" {
                hourlyImage.append(#imageLiteral(resourceName: "partly-cloudy-day"))
            } else if iconName == "partly-cloudy-night" {
                hourlyImage.append(#imageLiteral(resourceName: "partly-cloudy-night"))
            } else if iconName == "clear-day" {
                hourlyImage.append(#imageLiteral(resourceName: "clear-day"))
            } else if iconName == "clear-night" {
                hourlyImage.append(#imageLiteral(resourceName: "clear-night"))
            } else if iconName == "rain" {
                hourlyImage.append(#imageLiteral(resourceName: "rain"))
            } else if iconName == "cloudy" {
                hourlyImage.append(#imageLiteral(resourceName: "cloudy"))
            } else {
                hourlyImage.append(#imageLiteral(resourceName: "clear-day"))
            }
        }
        
        for day in userInfo["daily"]["data"].arrayValue {
            dailyHighs.append(Int(day["temperatureMax"].doubleValue))
            dailyLows.append(Int(day["temperatureMin"].doubleValue))
            let iconName = day["icon"].stringValue
            dailyIconNames.append(iconName)
            
            let unixTime: Int = day["time"].intValue
            let date = NSDate(timeIntervalSince1970: Double(unixTime))
            let dateFormatter = DateFormatter()
            dateFormatter.timeStyle = DateFormatter.Style.none //Set time style
            dateFormatter.dateStyle = DateFormatter.Style.short //Set date style
            dateFormatter.timeZone = TimeZone(abbreviation: "pst")
            let localDate = dateFormatter.string(from: date as Date)
            dailyDayNames.append(localDate)
            
            if iconName == "partly-cloudy-day" {
                dailyImages.append(#imageLiteral(resourceName: "partly-cloudy-day"))
            } else if iconName == "partly-cloudy-night" {
                dailyImages.append(#imageLiteral(resourceName: "partly-cloudy-night"))
            } else if iconName == "clear-day" {
                dailyImages.append(#imageLiteral(resourceName: "clear-day"))
            } else if iconName == "clear-night" {
                dailyImages.append(#imageLiteral(resourceName: "clear-night"))
            } else if iconName == "rain" {
                dailyImages.append(#imageLiteral(resourceName: "rain"))
            } else if iconName == "cloudy" {
                dailyImages.append(#imageLiteral(resourceName: "cloudy"))
            } else {
                dailyImages.append(#imageLiteral(resourceName: "clear-day"))
            }
        }
        
        setUpLayout()
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    func setUpLayout() {
        
        setupMainView()
        setupDailyWeatherTableView()
        setupHourlyWeatherCollectionView()
    }
    
    func setupMainView() {
        tempView = UIView(frame: CGRect(x: 0, y: 0, width: view.frame.width, height: view.frame.height * 0.3))
        
        tempLabel = UILabel(frame: CGRect(x: 0, y: 0, width: tempView.frame.width, height: tempView.frame.height * tempHeight))
        let font: UIFont? = UIFont(name: "Helvetica", size: 75)
        tempLabel.font = font
        tempLabel.textColor = UIColor.white
        tempLabel.textAlignment = .center
        tempLabel.numberOfLines = 1
        tempLabel.layer.shadowOffset = CGSize(width: 0, height: 0)
        tempLabel.layer.shadowOpacity = 0.5
        tempLabel.layer.shadowRadius = 20
        tempLabel.text = String(temp) + "°"
        
        rainLabel = UILabel(frame: CGRect(x: 0, y: tempLabel.frame.maxY, width: tempView.frame.width, height: tempView.frame.height * rainHeight))
        rainLabel.text = "It is going to rain today at: \n" + rainTime
        rainLabel.numberOfLines = 2
        rainLabel.textAlignment = .center
        rainLabel.font = UIFont.systemFont(ofSize: 20)
        rainLabel.textColor = UIColor.white
        
        descLabel = UILabel(frame: CGRect(x: 0, y: rainLabel.frame.maxY, width: tempView.frame.width, height: tempView.frame.height * descHeight))
        descLabel.text = self.tempDescription
        descLabel.numberOfLines = 0
        descLabel.textAlignment = .center
        descLabel.textColor = UIColor.white
        descLabel.font = UIFont.systemFont(ofSize: 18.0)
        
        tempView.addSubview(tempLabel)
        tempView.addSubview(rainLabel)
        tempView.addSubview(descLabel)
        view.addSubview(tempView)
    }
    
    func setupDailyWeatherTableView() {
        //Initialize TableView Object here
        dailyWeatherTableView = UITableView(frame: CGRect(x: 0, y: view.frame.height/2, width: view.frame.width, height: view.frame.height/2))
        
        //Register the tableViewCell you are using
        dailyWeatherTableView.register(DailyWeatherTableViewCell.self, forCellReuseIdentifier: "dailyWeatherCell")
        
        //Set properties of TableView
        dailyWeatherTableView.delegate = self
        dailyWeatherTableView.dataSource = self
        dailyWeatherTableView.rowHeight = 100
        //dailyWeatherTableView.contentInset = UIEdgeInsets(top: 0, left: 0, bottom: 50/2, right: 0)
        
        //Add tableView to view
        view.addSubview(dailyWeatherTableView)

    }
    
    func setupHourlyWeatherCollectionView() {
        let layout = UICollectionViewFlowLayout()
        layout.minimumLineSpacing = 0
        layout.minimumInteritemSpacing = 0
        
        //flowLayout.itemSize = CGSizeMake(UIScreen.mainScreen().bounds.width/2 - 10, 190)
        //flowLayout.sectionInset = UIEdgeInsetsMake(0, 5, 0, 5)
        layout.scrollDirection = UICollectionViewScrollDirection.horizontal
        //flowLayout.minimumInteritemSpacing = 0.0
        //mainHomeCollectionView.collectionViewLayout = flowLayout
        
        hourlyWeatherCollectionView = UICollectionView(frame: CGRect(x: 0, y: tempView.frame.maxY, width: view.frame.width, height: view.frame.height * (0.2)), collectionViewLayout: layout)
        
        hourlyWeatherCollectionView.register(HourlyWeatherTableViewCell.self, forCellWithReuseIdentifier: "hourlyWeatherCell")
        
        hourlyWeatherCollectionView.delegate = self
        hourlyWeatherCollectionView.dataSource = self
        //hourlyWeatherCollectionView.contentInset = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0)
        
        hourlyWeatherCollectionView.layer.borderWidth = 3
        hourlyWeatherCollectionView.layer.borderColor = UIColor.white.cgColor
        
        view.addSubview(hourlyWeatherCollectionView)
    }
}

extension ViewController: UITableViewDataSource, UITableViewDelegate{
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 7
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "dailyWeatherCell") as! DailyWeatherTableViewCell
        
        for subview in cell.contentView.subviews {
            subview.removeFromSuperview()
        }
        
        cell.awakeFromNib()
        cell.dayLabel.text = dailyDayNames[indexPath.row]
        cell.icon.image = dailyImages[indexPath.row]
        cell.highTemp.text = "H: " + String(dailyHighs[indexPath.row]) + "°"
        cell.lowTemp.text = "L: " + String(dailyLows[indexPath.row]) + "°"
        return cell
    }
    
}

extension ViewController: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout{
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 24
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "hourlyWeatherCell", for: indexPath) as! HourlyWeatherTableViewCell
        
        for subview in cell.contentView.subviews {
            subview.removeFromSuperview()
        }
        
        cell.awakeFromNib()
        
        cell.timeLabel.text = String(hourlyTimes[indexPath.row])
        cell.tempLabel.text = String(hourlyTemps[indexPath.row]) + "°"
        
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, willDisplay cell: UICollectionViewCell, forItemAt indexPath: IndexPath) {
        
        let hourlyCell = cell as! HourlyWeatherTableViewCell
        hourlyCell.icon.image = hourlyImage[indexPath.row]
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: view.frame.width * (1/6), height: hourlyWeatherCollectionView.frame.height)
    }
    
}

extension UIColor {
    convenience init(hex: String) {
        let scanner = Scanner(string: hex)
        scanner.scanLocation = 0
        
        var rgbValue: UInt64 = 0
        
        scanner.scanHexInt64(&rgbValue)
        
        let r = (rgbValue & 0xff0000) >> 16
        let g = (rgbValue & 0xff00) >> 8
        let b = rgbValue & 0xff
        
        self.init(
            red: CGFloat(r) / 0xff,
            green: CGFloat(g) / 0xff,
            blue: CGFloat(b) / 0xff, alpha: 1
        )
    }
}
