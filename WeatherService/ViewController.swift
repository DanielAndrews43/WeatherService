//
//  ViewController.swift
//  WeatherService
//
//  Created by Daniel Andrews on 3/7/17.
//  Copyright © 2017 Daniel Andrews. All rights reserved.
//

import UIKit
import Alamofire
import CoreLocation

class ViewController: UIViewController {
    
    var temp: String!
    var rainTime: String!
    var tempDescription: String!
    
    var tempView: UIView!
    var rainView: UIView!
    var descView: UIView!
    
    let tempHeight: CGFloat = 0.6
    let rainHeight: CGFloat = 0.1
    let descHeight: CGFloat = 0.3
    
    let locationManager = CLLocationManager()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Ask for Authorisation from the User.
        self.locationManager.requestAlwaysAuthorization()
        
        // For use in foreground
        self.locationManager.requestWhenInUseAuthorization()
        
        locationManager.desiredAccuracy = kCLLocationAccuracyNearestTenMeters
        locationManager.startUpdatingLocation()
        locationManager.requestWhenInUseAuthorization()
        
        let location = locationManager.location
        
        let coords: String = String(location!.coordinate.latitude) + "," + String(location!.coordinate.longitude)
        let todoEndpoint: String = "https://api.darksky.net/forecast/586eff41ea9820bdc94c1df3aa5e35e7/" + coords
        
        Alamofire.request(todoEndpoint)
            .responseString { response in
                // print response as string for debugging, testing, etc.
                print(response.result.value ?? "")
                print(response.result.error ?? "")
        }
        
        //Change these all later to pull from the API
        temp = "53"
        rainTime = "7:14pm"
        tempDescription = "It will be a bit chilly today, so make sure to put on a pair of pants and nice sweater"
        
        view.backgroundColor = UIColor(hex: "7BA9FF")
        
        setUpLayout()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    func setUpLayout() {
        
        makeTemperature()
        makeRain()
        makeDescription()
    }
    
    func makeTemperature() {
        tempView = UIView (frame: CGRect(x: 0, y: 0, width: view.frame.width, height: view.frame.height * tempHeight))
        
        let tempLabel: UILabel = UILabel(frame: CGRect(x: 0, y: tempView.frame.height * 0.1, width: tempView.frame.width, height: tempView.frame.height * 0.8))
        tempLabel.center = CGPoint(x: tempView.frame.width / 2, y: tempView.frame.height / 2)
        
        let font: UIFont? = UIFont(name: "Helvetica", size:300)
        let fontSuper: UIFont? = UIFont(name: "Helvetica", size:50)
        let attString: NSMutableAttributedString = NSMutableAttributedString(string: self.temp + "ºF", attributes: [NSFontAttributeName:font!])
        attString.setAttributes([NSFontAttributeName: fontSuper!, NSBaselineOffsetAttributeName: 170], range: NSRange(location: 2, length: 2))
        tempLabel.attributedText = attString;
        
        tempLabel.textColor = UIColor.white
        tempLabel.textAlignment = .center
        tempLabel.numberOfLines = 1
        tempLabel.layer.shadowOffset = CGSize(width: 0, height: 0)
        tempLabel.layer.shadowOpacity = 0.5
        tempLabel.layer.shadowRadius = 20
        
        
        tempView.addSubview(tempLabel)
        view.addSubview(tempView)
    }
    
    func makeRain() {
        rainView = UIView (frame: CGRect(x: 0, y: tempView.frame.maxY, width: view.frame.width, height: view.frame.height * rainHeight))
        let rainLabel: UILabel = UILabel(frame: CGRect(x: rainView.frame.width * 0.1, y: rainView.frame.height * 0.1, width: rainView.frame.width * 0.8, height: rainView.frame.height * 0.8))
        rainLabel.center = CGPoint (x: rainView.frame.width / 2, y: rainView.frame.height / 2)
        rainLabel.text = "It is going to rain today at: \n" + rainTime
        rainLabel.numberOfLines = 2
        rainLabel.textAlignment = .center
        rainLabel.font = UIFont.systemFont(ofSize: 20)
        rainLabel.textColor = UIColor.white
        
        rainView.addSubview(rainLabel)
        view.addSubview(rainView)
    }
    
    func makeDescription() {
        descView = UIView(frame: CGRect(x: 0, y: rainView.frame.maxY, width: view.frame.width, height: view.frame.height * descHeight))
        let descLabel: UILabel = UILabel(frame: CGRect(x:  descView.frame.width * 0.1, y: descView.frame.height * 0.1, width: descView.frame.width * 0.8, height: descView.frame.height * 0.8))
        descLabel.center = CGPoint(x: descView.frame.width / 2, y: descView.frame.height / 2)
        descLabel.text = self.tempDescription
        descLabel.numberOfLines = 0
        descLabel.textAlignment = .left
        descLabel.textColor = UIColor.white
        descLabel.font = UIFont.systemFont(ofSize: 18.0)
        
        descView.addSubview(descLabel)
        view.addSubview(descView)
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
